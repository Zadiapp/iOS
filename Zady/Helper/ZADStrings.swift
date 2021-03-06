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
    case notSet = "NA"
}

protocol ZADStringsProtocol {
    func didLangugageChanged ()
}

class ZADStrings: NSObject {
    static let sharedInstance = ZADStrings()
    private var _currentLangugae:Langugage = .notSet
    private var currentLangugae:Langugage {
        set {
            _currentLangugae = newValue
        }
        get {
            if _currentLangugae == .notSet {
                if let deviceLang = NSLocale.preferredLanguages.first {
                    return deviceLang.contains("ar") ? .arabic  : .english
                } else {
                    return .english
                }
            } else {
                return _currentLangugae
            }
        }
    }
    
    var viewControllers:[String:ZADStringsProtocol] = [:]
    var selectLanguageTitle:String  {get {return localizedStringWithKey(key: "selectLangugageTitle")}}
    var selectLanguageDescription:String  {get {return localizedStringWithKey(key: "selectLanguageDescription")}}
    var requestLocationTitle:String  {get {return localizedStringWithKey(key: "requestLocationTitle")}}
    var requestLocationDescription:String  {get {return localizedStringWithKey(key: "requestLocationDescription")}}
    var allow:String  {get {return localizedStringWithKey(key: "allow")}}
    var requestNotificationTitle:String  {get {return localizedStringWithKey(key: "requestNotificationTitle")}}
    var requestNotificationDescription:String  {get {return localizedStringWithKey(key: "requestNotificationDescription")}}
    var confirm:String  {get {return localizedStringWithKey(key: "confirm")}}
    var selectYourLocation:String  {get {return localizedStringWithKey(key: "selectYourLocation")}}
    var chooseMarket:String  {get {return localizedStringWithKey(key: "chooseMarket")}}
    var market:String  {get {return localizedStringWithKey(key: "market")}}
    var markets:String  {get {return localizedStringWithKey(key: "markets")}}

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
            notifyViewController()
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
