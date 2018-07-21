//
//  ZADViewController.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/22/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADViewController: UIViewController ,ZADStringsProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerNotifications()
    }

    func registerNotifications() {
        ZADStrings.sharedInstance.registerLangugaeUpdate(name:"\(type(of: self))", viewController: self)
    }
    
    func unregisterNotifications() {
        ZADStrings.sharedInstance.unregisterLangugaeUpdate(name:"\(type(of: self))")
    }
    
    deinit {
        unregisterNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLangugageChanged() {
        
    }
}
