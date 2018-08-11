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
import CoreLocation

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
        
        self.requestNotificationDescLabel.font = UIFont.systemFont(ofSize: 19.6, weight: .regular)
        self.requestNotificationTitleLabel.font = UIFont.systemFont(ofSize: 21.2, weight: .bold)
        
        self.requestNotificationButton.backgroundColor = ZADColors.buttonGreenColor
        self.requestNotificationButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func didLangugageChanged() {
        fillViewWithData()
    }
    
    func showNextView() {
        sendRequest()
        DispatchQueue.main.async {
            let launcher: ZADViewControllerLauncher = ZADViewControllerLauncher()
            launcher.showNextViewController(fromViewController: self)
        }
    }
    
    func sendRequest() {
        let language = ZADDefaults.sharedInstance.applicationLanguage?.rawValue
        let Identifier = UIDevice.current.identifierForVendor?.uuidString
        let coordinate = ZADDefaults.sharedInstance.userLocation
        let token = ZADDefaults.sharedInstance.userToken
        let registerTask = ZADRegisterTask(lang: language, deviceId: Identifier, token: token, coordinate: coordinate)
        registerTask.execute(dispatcher: ZADNetwork.getDispatcher()) { (user) in
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

