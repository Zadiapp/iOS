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
    @IBOutlet weak var englishButton: ZADButton!
    @IBOutlet weak var arabicButton: ZADButton!

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
        self.arabicButton.addBorderColor(color: ZADColors.buttonBorder)
        self.englishButton.addBorderColor(color: ZADColors.buttonBorder)
        
        let arabicImage = UIImage(named: "ic_lang_ar")
        let englishImage = UIImage(named: "ic_lang_en")
        self.arabicButton.imageView?.image = arabicImage
        self.englishButton.imageView?.image = englishImage
        self.arabicButton.titleLabel?.text = "العربية"
        self.englishButton.titleLabel?.text = "English"

        self.selectLanguageDescLabel.font = UIFont.systemFont(ofSize: 19.2)
        self.selectLanguageTitleLabel.font = UIFont.systemFont(ofSize: 27.2)
        
        self.arabicButton.semanticContentAttribute = .forceRightToLeft
        self.arabicButton.contentHorizontalAlignment = .right
        self.arabicButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 7.0)
        let arabicAvailableSpace = UIEdgeInsetsInsetRect(self.arabicButton.bounds, self.arabicButton.contentEdgeInsets)
        let arabicAvailableWidth = arabicAvailableSpace.width - self.arabicButton.imageEdgeInsets.left - (self.arabicButton.imageView?.frame.width ?? 0) - (self.arabicButton.titleLabel?.frame.width ?? 0)
        self.arabicButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (arabicAvailableWidth / 2))
        
        self.englishButton.contentHorizontalAlignment = .left
        self.englishButton.contentEdgeInsets = UIEdgeInsetsMake(0.0, 7.0, 0.0, 0.0)
        let englishAvailableSpace = UIEdgeInsetsInsetRect(self.englishButton.bounds, self.englishButton.contentEdgeInsets)
        let englishAvailableWidth = englishAvailableSpace.width - self.arabicButton.imageEdgeInsets.right - (self.englishButton.imageView?.frame.width ?? 0) - (self.englishButton.titleLabel?.frame.width ?? 0)
        self.englishButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: (englishAvailableWidth / 2), bottom: 0, right: 0)
    }
    
    override func didLangugageChanged() {
        fillViewWithData()
    }
    
    @IBAction func changeAppLanguageToEnglish() {
        changeLanguge(languge: .english)
    }
    
    @IBAction func changeAppLanguageToArabic() {
        changeLanguge(languge: .arabic)
    }
    
    func changeLanguge(languge:Langugage) {
        ZADStrings.sharedInstance.changeLangugage(lang: languge)
        showNextView()
    }
    
    func showNextView() {
        if  ZADLocationManager.isLocationAuthorized() {
            showRequestNotifictaionVC()
        } else {
            showRequestLocationVC()
        }
    }
    
    func showRequestLocationVC() {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.6) {
            self.performSegue(withIdentifier: "showLocation", sender: nil)
        }
    }
    
    func showRequestNotifictaionVC() {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.6) {
            self.performSegue(withIdentifier: "showNotification", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
