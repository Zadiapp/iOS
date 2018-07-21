//
//  ZADRequest.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/21/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import Foundation

/// - JSON: it's a json
/// - Data: it's plain data
public enum DataType {
    case JSON
    case Data
}

public protocol ZADRequest {
    var path:String {get}
    var method:HTTPMethod {get}
    var parameters:RequestParams {get}
    var headers:[String: Any]? {get}
    var dataType:DataType {get}
}

public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum RequestParams {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
}
