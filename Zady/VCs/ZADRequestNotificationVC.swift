//
//  ZADRequestNotificationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/22/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class ZADRequestNotificationVC: ZADViewController {

    @IBOutlet weak var requestNotificationTitleLabel: UILabel!
    @IBOutlet weak var requestNotificationDescLabel: UILabel!
    @IBOutlet weak var requestNotificationImageView: UIImageView!
    @IBOutlet weak var requestNotificationButton: ZADButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillViewWithData()
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
    
    func showNextView() {
        DispatchQueue.main.async {
            let launcher: ZADViewControllerLauncher = ZADViewControllerLauncher()
            launcher.showNextViewController(fromViewController: self)
        }
    }
    
    @IBAction func requestNotification() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {granted, _ in
                if !granted {
                    ZADDefaults.sharedInstance.isNotificationDenied = true
                } else {
                    DispatchQueue.main.async {
                        let application = UIApplication.shared
                        application.registerForRemoteNotifications()
                        self.showNextView()
                    }
                }
        })
    }
}

