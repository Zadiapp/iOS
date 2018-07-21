//
//  ZADDispatcher.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/21/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import Foundation
public protocol ZADDispatcher {
    
    /// Configure the dispatcher with an environment
    ///
    /// - Parameter environment: environment configuration
    init(environment: ZADEnvironment)
        
    /// This function execute the request and provide a compeltionHandler
    /// with the response.
    ///
    /// - Parameter request: request to execute
    /// - Returns: compeltionHandler
    func execute(request: ZADRequest, compeltionHandler:@escaping (ZADResponse)->()) throws
    
}
