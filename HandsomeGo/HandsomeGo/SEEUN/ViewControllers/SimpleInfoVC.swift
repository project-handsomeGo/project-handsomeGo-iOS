//
//  SimpleInfoVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class SimpleInfoVC: UIViewController {

    var placeId = 1
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var reviewCntLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataInit()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func dataInit() {
        PlaceService.shareInstance.getPlace(placeId: placeId, completion: { (place) in
            
            self.placeImageView.imageFromUrl(place.placePic, defaultImgPath: "")
            self.nameLabel.text = place.placeName
            self.addressLabel.text = place.placeAddress
            self.infoLabel.text = place.placeContent
            self.reviewCntLabel.text = "\(place.commentCount)"
        }) { (err) in
        }
    }
    
    @IBAction func stampAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "saveStampVC") as! saveStampVC
        vc.placeId = self.placeId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
