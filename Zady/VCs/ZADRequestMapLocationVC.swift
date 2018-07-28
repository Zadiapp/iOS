//
//  ZADRequestMapLocationVC.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 7/27/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import MapKit

protocol ZADRequestMapLocationVCDelegate {
    func didSelectLocation(mapItem:MKMapItem);
}

class ZADRequestMapLocationVC: UIViewController {
    @IBOutlet weak var closeButton:UIButton!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var clearSearchButton:UIButton!
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var confirmButton:ZADButton!
    @IBOutlet weak var searchView:UIView!
    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var searchResultsTableView:UITableView!
    @IBOutlet weak var searchResultsTableViewHeight:NSLayoutConstraint!
    var mapItems:[MKMapItem]?
    let maximumSearchResultsTableViwHeight = CGFloat(44 * 5);
    var delegate:ZADRequestMapLocationVCDelegate?
    
    var mapLocationController:ZADMapLocationController = ZADMapLocationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        setupMapView()
        setupView()
    }
    
    func setupView() {
        self.clearSearchButton.isHidden = true
        self.searchResultsTableView.isHidden = true
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
        self.clearSearchButton.isHidden = true
        self.searchTextField.resignFirstResponder()
        clearSearchResults()
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func search(keyword:String) {
        if keyword.count == 0 {
            clearSearchResults()
            return
        }
        
        mapLocationController.searchLocationWith(keyword: keyword, region: mapView.region) {[weak self] (matchingItems) in
            self?.mapItems = matchingItems
            self?.updateSearchResultsView()
        }
    }
    
    func clearSearchResults() {
        self.mapItems = []
        self.updateSearchResultsView()
        self.adjustTableViewHeight()
    }
    
    func adjustTableViewHeight() {
        let searchTableViewHeight = CGFloat((self.mapItems?.count)! * 44) > maximumSearchResultsTableViwHeight ? maximumSearchResultsTableViwHeight : CGFloat((self.mapItems?.count)! * 44)
        self.searchResultsTableViewHeight.constant = searchTableViewHeight
    }
    
    func updateSearchResultsView() {
        if (self.mapItems?.count)! > 0 {
            self.searchResultsTableView.isHidden = false
            searchResultsTableView.reloadData()
            adjustTableViewHeight()
        } else {
            self.searchResultsTableView.isHidden = true
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

extension ZADRequestMapLocationVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = mapItems {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let mapItem = mapItems![indexPath.row]
        cell.textLabel?.text = mapItem.placemark.name
        return cell
    }
    
}

extension ZADRequestMapLocationVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMapItem:MKMapItem = self.mapItems![indexPath.row]
        if let delegate = self.delegate {
            delegate.didSelectLocation(mapItem: selectedMapItem)
        }
        
        close()
    }
}

extension ZADRequestMapLocationVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.count == 0 {
            self.clearSearchButton.isHidden = true
        } else {
            self.clearSearchButton.isHidden = false
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(search), with: text, afterDelay: 1.0)
        return true
    }
}
