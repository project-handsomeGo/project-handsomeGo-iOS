//
//  saveStampVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class saveStampVC: UIViewController {
    var placeId = 0
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0MiwiaWF0IjoxNTM3MzYxNDI1LCJleHAiOjE1Mzk5NTM0MjV9.GNSbBt28VaJPlISjzP82WUhHONpAfR-VgLC84cZxhD0"
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var stampImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNaviBar()
        dataInit()
    }
    
    func dataInit() {
        StampStatusService.shareInstance.getStampStatus(token: token, stampId: placeId, completion: { (stamp) in
            self.title = stamp.placeName
            self.stampImageView.imageFromUrl(stamp.stampPic, defaultImgPath: "")
            self.categoryLabel.text = stamp.placeCategory
            self.rankLabel.text = "\(stamp.rank)위"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
            dateFormatter.timeZone = TimeZone.current
            let originDate = dateFormatter.date(from: stamp.stampDate)
            dateFormatter.dateFormat = "yyyy.MM.dd"
            self.dateLabel.text = dateFormatter.string(from: originDate!)
            
        }) { (err) in
            
        }
    }
    
    func setupNaviBar() { self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
    }
    
    func setupView() {
        squareView.layer.shadowRadius = 6
        squareView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        squareView.layer.shadowOffset = CGSize(width: 0, height: 3)
        squareView.layer.shadowOpacity = 0.3
        
    }
    
}
