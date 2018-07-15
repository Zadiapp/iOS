//
//  ViewController.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/12/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ZADStrings.currentLangugae = "en"
        label.text = ZADStrings().localizedStringWithKey(key: "seasonsGreetings")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

