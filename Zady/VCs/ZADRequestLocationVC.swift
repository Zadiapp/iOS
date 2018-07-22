//
//  ZADRequestLocationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/22/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADRequestLocationVC: ZADViewController {
    @IBOutlet weak var requestLocationTitleLabel: UILabel!
    @IBOutlet weak var requestLocationDescLabel: UILabel!
    @IBOutlet weak var requestLocationImageView: UIImageView!
    @IBOutlet weak var requestLocationButton: ZADButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    func fillViewWithData() {
        self.requestLocationTitleLabel.text = ZADStrings.sharedInstance.requestLocationTitle
        self.requestLocationDescLabel.text = ZADStrings.sharedInstance.requestLocationDescription
        self.requestLocationButton.setTitle(ZADStrings.sharedInstance.allow, for: .normal)
    }
    
    func applyTheme() {
        self.requestLocationTitleLabel.textColor = ZADColors.titleColor
        self.requestLocationDescLabel.textColor = ZADColors.descColor
        
        self.requestLocationDescLabel.font = UIFont.systemFont(ofSize: 19.2)
        self.requestLocationTitleLabel.font = UIFont.systemFont(ofSize: 27.2)
        
        self.requestLocationButton.backgroundColor = ZADColors.buttonOrangeColor
        self.requestLocationButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func didLangugageChanged() {
        fillViewWithData()
    }
    
    @IBAction func requestLocation() {
        ZADLocationManager.sharedInstance.delegate = self
        ZADLocationManager.sharedInstance.requestAuthorization()
    }
    
    @IBAction func showRequestNotifictaionVC() {
        self.performSegue(withIdentifier: "showNotification", sender: nil)
    }
}

extension ZADRequestLocationVC: ZADLocationManagerProtocol {
    func didAcquireLocation(acuireLocation: Bool) {
        showRequestNotifictaionVC()
    }
}
