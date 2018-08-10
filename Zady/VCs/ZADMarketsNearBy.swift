//
//  ZADMarketsNearBy.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/1/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADMarketsNearBy: ZADViewController {
    @IBOutlet weak var nearByMarketsTableView:UITableView!
    @IBOutlet weak var chooseMarketLabel: UILabel!
    @IBOutlet weak var marketsCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        nearByMarketsTableView.register(UINib(nibName: "MarketTableViewCell", bundle: nil), forCellReuseIdentifier: "MarketTableViewCell")
        // TODO: move it to controller
        ZADDefaults.sharedInstance.isRegistedRequiredData = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        fillViewWithData()
    }
    
    func fillViewWithData() {
        self.chooseMarketLabel.text = ZADStrings.sharedInstance.chooseMarket
        self.marketsCountLabel.text = "5 \(ZADStrings.sharedInstance.markets)"
    }
    
    func applyTheme() {
        self.chooseMarketLabel.textColor = ZADColors.titleColor
        self.marketsCountLabel.textColor = ZADColors.descColor
        self.chooseMarketLabel.font = UIFont.systemFont(ofSize: 27.2)
        self.marketsCountLabel.font = UIFont.systemFont(ofSize: 15.0)
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2.0
        self.profileImageView.layer.masksToBounds = true
    }
}

extension ZADMarketsNearBy:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
}

extension ZADMarketsNearBy:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell", for: indexPath) as! MarketTableViewCell
        cell.nameLabel.text = "Seoudi"
        cell.openHoursLabel.text = "Open 24 hours"
        return cell
    }
    
    
}
