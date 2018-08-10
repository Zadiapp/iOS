//
//  ZADButton.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/22/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 30.0
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 21.2, weight: .bold)
    }
    
    var applyShadow:Bool {set {newValue ? addShadow() : removeShadow() } get {return self.applyShadow}}
    var borderColor:UIColor {set {addBorderColor(color: newValue)} get {return self.borderColor}}
    
    func addBorderColor(color:UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
    }
    
    func removeShadow() {
        self.layer.shadowColor = nil
        self.layer.shadowOpacity = 0.0
        self.layer.shadowRadius = 0.0
    }
}
