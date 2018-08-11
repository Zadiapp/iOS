//
//  ZADRequestMapLocationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/27/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import GoogleMaps

protocol ZADRequestMapLocationVCDelegate {
    func didSelectLocation(mapItem:CLLocationCoordinate2D);
}

class ZADRequestMapLocationVC: UIViewController {
    @IBOutlet weak var closeButton:UIButton!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var clearSearchButton:UIButton!
    @IBOutlet weak var selectedPlaceLabel:UILabel!
    @IBOutlet weak var confirmButton:ZADButton!
    @IBOutlet weak var mapView:GMSMapView!
    var mapItems:[GMSMarker]?
    var delegate:ZADRequestMapLocationVCDelegate?
    
    var mapLocationController:ZADMapLocationController = ZADMapLocationController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        fillViewWithData()
        setupMapView()
        setupView()
    }
    
    func setupView() {
        self.clearSearchButton.isHidden = true
    }
    
    func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 30.0444196, longitude: 31.2357116, zoom: 6.0)
        self.mapView.delegate = self
        self.mapView.camera = camera
    }
    
    @IBAction func confirmLocation() {
        
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func fillViewWithData() {
        self.confirmButton.setTitle(ZADStrings.sharedInstance.confirm, for: .normal)
        self.titleLabel.text = ZADStrings.sharedInstance.selectYourLocation
    }
    
    func applyTheme() {
        self.titleLabel.textColor = ZADColors.titleColor
        self.titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .regular)
        self.selectedPlaceLabel.textColor = ZADColors.textFieldTextColor
        self.selectedPlaceLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        
        self.confirmButton.backgroundColor = ZADColors.buttonGreenColor
        self.confirmButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    DispatchQueue.main.async {
                        self.selectedPlaceLabel.text = addressString
                    }
                }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZADRequestMapLocationVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let coordinate = mapView.camera.target
        getAddressFromLatLon(pdblLatitude: "\(coordinate.latitude)", withLongitude: "\(coordinate.longitude)")
    }
}

