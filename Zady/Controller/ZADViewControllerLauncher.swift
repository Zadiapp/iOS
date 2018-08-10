//
//  ZADViewControllerLauncher.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/10/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class ZADViewControllerLauncher: NSObject {

    public func showNextViewController (fromViewController: UIViewController?) {
        if ZADDefaults.sharedInstance.isRegistedRequiredData {
            showHome(fromViewController: fromViewController)
        } else if ZADDefaults.sharedInstance.applicationLanguage! == .notSet {
            showChooseLanguage(fromViewController: fromViewController)
        } else if ZADDefaults.sharedInstance.userLocation == nil {
            showRequestLocation(fromViewController: fromViewController)
        } else if !ZADDefaults.sharedInstance.isNotificationGranted {
            showAllowNotification(fromViewController: fromViewController)
        } else {
            showHome(fromViewController: fromViewController)
        }
    }
    
    private func showHome(fromViewController: UIViewController?) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let marketsNearBy = storyBoard.instantiateViewController(withIdentifier: "MarketsNearBy") as! ZADMarketsNearBy
        showViewController(viewController: marketsNearBy , fromViewController: nil)
    }
    
    private func showChooseLanguage (fromViewController: UIViewController?) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let selectLanguageVC = storyBoard.instantiateViewController(withIdentifier: "selectLanguage") as! ZADSelectLanguageVC
        showViewController(viewController: selectLanguageVC , fromViewController: fromViewController)
    }
    
    private func showAllowNotification (fromViewController: UIViewController?) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let requestNotificationVC = storyBoard.instantiateViewController(withIdentifier: "requestNotification") as! ZADRequestNotificationVC
        showViewController(viewController: requestNotificationVC , fromViewController: fromViewController)
    }
    
    private func showRequestLocation (fromViewController: UIViewController?) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let requestLocationVC = storyBoard.instantiateViewController(withIdentifier: "requestLocation") as! ZADRequestLocationVC
        showViewController(viewController: requestLocationVC , fromViewController: fromViewController)
    }
    
    private func showViewController(viewController:UIViewController, fromViewController: UIViewController?)  {
        if let fromViewController = fromViewController {
            viewController.modalPresentationStyle = .fullScreen
            fromViewController.present(viewController, animated: true, completion: nil)
        } else {
            let appDelegate = UIApplication.shared.delegate
            if let appWindow = appDelegate?.window {
                appWindow?.rootViewController = viewController
                appWindow?.makeKeyAndVisible()
            }
        }
    }
}
