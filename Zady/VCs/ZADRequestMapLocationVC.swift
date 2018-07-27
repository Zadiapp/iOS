//
//  ZADRequestMapLocationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/27/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import MapKit

class ZADRequestMapLocationVC: UIViewController {
    @IBOutlet weak var closeButton:UIButton!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var clearSearchButton:UIButton!
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var confirmButton:ZADButton!
    @IBOutlet weak var searchView:UIView!
    @IBOutlet weak var mapView:MKMapView!
    var mapLocationController:ZADMapLocationController = ZADMapLocationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        setupMapView()
    }
    
    func setupMapView() {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(30.0444196, 31.2357116)
        let span = MKCoordinateSpanMake(0, 360 / pow(2, Double(12)) * Double(mapView.frame.size.width) / 256)
        let viewRegion:MKCoordinateRegion  = MKCoordinateRegionMake(coordinate, span);
        let adjustedRegion:MKCoordinateRegion = mapView.regionThatFits(viewRegion)
        mapView.setRegion(adjustedRegion, animated: true)
        mapView.showsUserLocation = true;
    }
    
    @IBAction func confirmLocation() {
        
    }
    
    @IBAction func clearSearch() {
        self.searchTextField.text = ""
        self.searchTextField.resignFirstResponder()
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func search(keyword:String) {
        mapLocationController.searchLocationWith(keyword: keyword, region: mapView.region) { (matchingItems) in
            let names = matchingItems.map({ (mapitem) -> String in
                return mapitem.name!
            })
            
            print("\(names)")
        }
    }
    
    func fillViewWithData() {
        self.confirmButton.setTitle(ZADStrings.sharedInstance.confirm, for: .normal)
        self.titleLabel.text = ZADStrings.sharedInstance.selectYourLocation
        self.searchTextField.placeholder = ZADStrings.sharedInstance.selectYourLocation
    }
    
    func applyTheme() {
        self.titleLabel.textColor = ZADColors.titleColor
        self.titleLabel.font = UIFont.systemFont(ofSize: 27.2)
        self.searchTextField.textColor = ZADColors.textFieldTextColor
        self.searchTextField.font = UIFont.systemFont(ofSize: 15.0)
        
        self.confirmButton.backgroundColor = ZADColors.buttonOrangeColor
        self.confirmButton.setTitleColor(UIColor.white, for: .normal)
        
        self.searchView.layer.cornerRadius = 10.0
        self.searchView.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZADRequestMapLocationVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        search(keyword: text)
        return true
    }
}
