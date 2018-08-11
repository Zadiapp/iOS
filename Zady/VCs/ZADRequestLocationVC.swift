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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillViewWithData()
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
        
        self.requestLocationDescLabel.font = UIFont.systemFont(ofSize: 19.6, weight: .regular)
        self.requestLocationTitleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .bold)
        
        self.requestLocationButton.backgroundColor = ZADColors.buttonGreenColor
        self.requestLocationButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func didLangugageChanged() {
        fillViewWithData()
    }
    
    @IBAction func requestLocation() {
        locationManager = ZADLocationManager()
        if ZADLocationManager.isLocationCancled() {
            showMapView()
        } else {
            if let locationManager = locationManager {
                locationManager.delegate = self
                locationManager.requestAuthorization()
            }
        }
    }
    
    @IBAction func showRequestNotifictaionVC() {
        self.performSegue(withIdentifier: "showNotification", sender: nil)
    }
    
    func showMapView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mapLocation = storyBoard.instantiateViewController(withIdentifier: "RequestMapLocation") as! ZADRequestMapLocationVC
        mapLocation.delegate = self
        self.present(mapLocation, animated: true, completion: nil)
    }
    
    func isNotificationDenied() -> Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    func showNextViewController() {
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.6) {
            let launcher: ZADViewControllerLauncher = ZADViewControllerLauncher()
            launcher.showNextViewController(fromViewController: self)
        }
    }
}

extension ZADRequestLocationVC : ZADRequestMapLocationVCDelegate {
    func didSelectLocation(mapItem:CLLocationCoordinate2D) {
        ZADDefaults.sharedInstance.userLocation = mapItem
        showNextViewController()
    }
}

extension ZADRequestLocationVC: ZADLocationManagerProtocol {
    func didlocationUpdated(location: CLLocation) {
        ZADDefaults.sharedInstance.userLocation = location.coordinate
        showNextViewController()
    }
    
    func didAcquireLocation(acuireLocation: Bool) {
        if !acuireLocation {
            showMapView()
        } else {
            locationManager?.requestLocation()
        }
    }
}
