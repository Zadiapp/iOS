//
//  ZADRequestNotificationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/22/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADRequestNotificationVC: ZADViewController {

    @IBOutlet weak var requestNotificationTitleLabel: UILabel!
    @IBOutlet weak var requestNotificationDescLabel: UILabel!
    @IBOutlet weak var requestNotificationImageView: UIImageView!
    @IBOutlet weak var requestNotificationButton: ZADButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    func fillViewWithData() {
        self.requestNotificationTitleLabel.text = ZADStrings.sharedInstance.requestNotificationTitle
        self.requestNotificationDescLabel.text = ZADStrings.sharedInstance.requestNotificationDescription
        self.requestNotificationButton.setTitle(ZADStrings.sharedInstance.allow, for: .normal)
    }
    
    func applyTheme() {
        self.requestNotificationTitleLabel.textColor = ZADColors.titleColor
        self.requestNotificationDescLabel.textColor = ZADColors.descColor
        
        self.requestNotificationDescLabel.font = UIFont.systemFont(ofSize: 19.2)
        self.requestNotificationTitleLabel.font = UIFont.systemFont(ofSize: 27.2)
        
        self.requestNotificationButton.backgroundColor = ZADColors.buttonOrangeColor
        self.requestNotificationButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func didLangugageChanged() {
        fillViewWithData()
    }
    
    @IBAction func requestNotification() {

    }
}
