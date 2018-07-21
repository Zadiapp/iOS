//
//  ZADOperation.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/21/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import Foundation

protocol Operation {
    associatedtype Output
    
    /// Request to execute
    var request: ZADRequest { get }
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    /// - Returns: in completionHandler
    func execute(dispatcher: ZADDispatcher, completionHandler:(Output)->())
}
