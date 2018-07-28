//
//  ZADFBLoginManager.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/29/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ZADFBLoginManager: NSObject {

    static let sharedInstance = ZADFBLoginManager()
    var profile:FBSDKProfile?
    
    func login(viewController:UIViewController) {
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile"], from: viewController) { (result, error) in
            if ((error) != nil) {
                print("Process error")
            } else if (result?.isCancelled)! {
                print("Cancelled")
            } else {
                print("Logged in")
            }
        }
    }
    
    func isLoggedIn() -> Bool {
        return (FBSDKAccessToken.current() != nil);
    }
    
    func fetchProfileData(compeletionHandler:@escaping (FBSDKProfile?, Error?)->()) {
        FBSDKProfile.loadCurrentProfile { (profile, error) in
            if let profile = profile {
                self.profile = profile
                self.saveUserId(userID: profile.userID)
                compeletionHandler(profile, nil)
            }
            
            if let error = error {
                compeletionHandler(nil, error)
            }
        }
    }
    
    func saveUserId(userID:String) {
        let userdefaults = UserDefaults.standard
        userdefaults.setValue(userID, forKey: "FBUserID")
        userdefaults.synchronize()
    }
    
    func userId() -> String? {
        let userdefaults = UserDefaults.standard
        return userdefaults.string(forKey: "FBUserID")
    }
}
