//
//  SimpleInfoVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class SimpleInfoVC: UITabBarController {

    var placeId = 0
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var stampCntLabel: UILabel!
    @IBOutlet weak var reviewCntLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func stampAction(_ sender: UIButton) {
    }
    @IBAction func dismissAction(_ sender: UIButton) {
    }
    

}
