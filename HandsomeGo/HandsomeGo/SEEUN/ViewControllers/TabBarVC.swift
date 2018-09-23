//
//  TabBarVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is QRcodeTabVC {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "QRcodeTabVC") as? QRcodeTabVC {
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
            
            return false
        }
        
        // Tells the tab bar to select other view controller as normal
        return true
    }
    
}

