//
//  ZADNetworkDispatcher.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/21/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import Foundation

public enum ZADNetworkErrors:Error {
    case badInput
    case noData
}

public class ZADNetworkDispatcher: ZADDispatcher {
    private var enviroment: ZADEnvironment
    private var session:URLSession
    
    public required init(environment env: ZADEnvironment) {
        self.enviroment = env
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func execute(request: ZADRequest, compeltionHandler:@escaping (ZADResponse)->()) throws {
        let rawRequest = try self.prepareRequest(request: request)
        let dataTask = self.session.dataTask(with: rawRequest, completionHandler: {
            (data, urlResponse, error) in
            let response = ZADResponse(data: data, response: urlResponse as? HTTPURLResponse, error: error, request: request)
            compeltionHandler(response)
        })
        dataTask.resume()
    }
    
    private func prepareRequest (request: ZADRequest) throws -> URLRequest {
        let fullURL = "\(self.enviroment.host)/\(request.path)"
        var urlRequest = URLRequest(url: URL(string: fullURL)!)
        
        switch request.parameters {
        case .body(let params):
            // Parameters are part of the body
            if let params = params as? [String: String] { // just to simplify
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
            } else {
                throw ZADNetworkErrors.badInput
            }
        case .url(let params):
            // Parameters are part of the url
            if let params = params as? [String: String] { // just to simplify
                let query_params = params.map({ (element) -> URLQueryItem in
                    return URLQueryItem(name: element.key, value: element.value)
                })
                guard var components = URLComponents(string: fullURL) else {
                    throw ZADNetworkErrors.badInput
                }
                components.queryItems = query_params
                urlRequest.url = components.url
            } else {
                throw ZADNetworkErrors.badInput
            }
        }
        
        // Add headers from enviornment and request
        enviroment.headers.forEach {
            urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }
        
        request.headers?.forEach {
            urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
        }
        
        // Setup HTTP method
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest
    }
}
