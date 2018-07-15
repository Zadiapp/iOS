//
//  ZADStrings.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/16/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADStrings: NSObject {
    static var currentLangugae = "ar"
    
    func localizedStringWithKey(key:String) -> String {
        let bundle = bundleWtihLanguage(lang: ZADStrings.currentLangugae)
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
