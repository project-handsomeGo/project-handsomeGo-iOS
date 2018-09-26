//
//  SimpleInfoVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class SimpleInfoVC: UIViewController {

    @IBOutlet weak var placeTableView: UITableView!
    var placeId = 1
    var place: Place? {
        didSet {
            placeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataInit()
        placeTableView.delegate = self
        placeTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func dataInit() {
        PlaceService.shareInstance.getPlace(placeId: placeId, completion: { (place) in
            print("성공!!")
            self.place = place
        }) { (err) in
            print("에러")
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

extension SimpleInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if place != nil { return 1 }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placeTableView.dequeueReusableCell(withIdentifier: "PlaceInfoCell") as! PlaceInfoCell
        if let place = place {
        cell.placeImageView.imageFromUrl(place.placePic, defaultImgPath: "")
        cell.nameLabel.text = place.placeName
        cell.addressLabel.text = place.placeAddress
        cell.infoLabel.text = place.placeContent
        cell.reviewCntLabel.text = "\(place.commentCount)"
        }
        return cell
    }
    
    
}
