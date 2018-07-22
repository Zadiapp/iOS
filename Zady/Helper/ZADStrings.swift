//
//  ZADStrings.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/16/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

public enum Langugage:String {
    case arabic = "ar"
    case english = "en"
}

protocol ZADStringsProtocol {
    func didLangugageChanged ()
}

class ZADStrings: NSObject {
    static let sharedInstance = ZADStrings()
    private var currentLangugae:Langugage = .english
    var viewControllers:[String:ZADStringsProtocol] = [:]
    
    var selectLanguageTitle:String  {get {return localizedStringWithKey(key: "selectLangugageTitle")}}
    var selectLanguageDescription:String  {get {return localizedStringWithKey(key: "selectLanguageDescription")}}

    func registerLangugaeUpdate(name:String?, viewController:ZADStringsProtocol) {
        if let name = name {
            viewControllers[name] = viewController
        }
    }
    
    func unregisterLangugaeUpdate(name:String?) {
        if let name = name {
            viewControllers.removeValue(forKey: name)
        }
    }
    
    func notifyViewController() {
        for (_, viewController) in viewControllers {
            viewController.didLangugageChanged()
        }
    }
    
    func changeLangugage(lang: Langugage) {
        if lang != currentLangugae {
            currentLangugae = lang
        }
    }
    
    func localizedStringWithKey(key:String) -> String {
        let bundle = bundleWtihLanguage(lang: ZADStrings.sharedInstance.currentLangugae.rawValue)
        guard let localizationBundle = bundle else {
            return ""
        }
        
        return NSLocalizedString(key, tableName: nil, bundle: localizationBundle, value: "", comment: "")
    }
    
    private func bundleWtihLanguage(lang:String) -> Bundle! {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle
    }
    
}
