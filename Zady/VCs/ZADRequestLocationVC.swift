//
//  ZADRequestLocationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/22/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import MapKit

class ZADRequestLocationVC: ZADViewController {
    @IBOutlet weak var requestLocationTitleLabel: UILabel!
    @IBOutlet weak var requestLocationDescLabel: UILabel!
    @IBOutlet weak var requestLocationImageView: UIImageView!
    @IBOutlet weak var requestLocationButton: ZADButton!
    var locationManager:ZADLocationManager?
    
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
        locationManager = ZADLocationManager()
        if let locationManager = locationManager {
            locationManager.delegate = self
            locationManager.requestAuthorization()
        }
    }
    
    @IBAction func showRequestNotifictaionVC() {
        self.performSegue(withIdentifier: "showNotification", sender: nil)
    }
}

extension ZADRequestLocationVC: ZADLocationManagerProtocol {
    func didlocationUpdated(location: CLLocation) {
        
    }
    
    func didAcquireLocation(acuireLocation: Bool) {
        showRequestNotifictaionVC()
    }
}
