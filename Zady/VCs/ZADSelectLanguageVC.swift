//
//  ZADSelectLanguageVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/12/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADSelectLanguageVC: ZADViewController {
    @IBOutlet weak var selectLanguageTitleLabel: UILabel!
    @IBOutlet weak var selectLanguageDescLabel: UILabel!
    @IBOutlet weak var selectLanguageImageView: UIImageView!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    func fillViewWithData() {
        self.selectLanguageTitleLabel.text = ZADStrings.sharedInstance.selectLanguageTitle
        self.selectLanguageDescLabel.text = ZADStrings.sharedInstance.selectLanguageDescription
    }
    
    func applyTheme() {
        self.selectLanguageTitleLabel.textColor = ZADColors.titleColor
        self.selectLanguageDescLabel.textColor = ZADColors.descColor
        
        self.selectLanguageDescLabel.font = UIFont.systemFont(ofSize: 19.2)
        self.selectLanguageTitleLabel.font = UIFont.systemFont(ofSize: 27.2)
    }
    
    override func didLangugageChanged() {
        
    }
    
    @IBAction func changeToAppLanguageToEnglish() {
        changeLanguge(languge: .english)
    }
    
    @IBAction func changeToAppLanguageToArabic() {
        changeLanguge(languge: .arabic)
    }
    
    func changeLanguge(languge:Langugage) {
        ZADStrings.sharedInstance.changeLangugage(lang: languge)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
