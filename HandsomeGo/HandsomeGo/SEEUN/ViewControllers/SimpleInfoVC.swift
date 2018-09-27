//
//  SimpleInfoVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class SimpleInfoVC: UIViewController {
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0MiwiaWF0IjoxNTM3MzYxNDI1LCJleHAiOjE1Mzk5NTM0MjV9.GNSbBt28VaJPlISjzP82WUhHONpAfR-VgLC84cZxhD0"
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var placeTableView: UITableView!
    
    var placeId = 1
    var stampStatus = 0
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
        
        StampStatusService.shareInstance.getStampStatus(token: token, stampId: placeId, completion: { (stamp) in
            if stamp.stampStatus == 1 {
                self.stampStatus = stamp.stampStatus
                self.saveButton.setTitle("적립내역 보기", for: .normal)
            }
        }) { (err) in
        }
    }
    
    @IBAction func stampAction(_ sender: UIButton) {
        // 게스트일때
        if token == ""{
            
        } else { // 로그인했을때
            if stampStatus == 0{
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "saveStampVC") as! saveStampVC
                vc.placeId = self.placeId
                
                StampSaveService.shareInstance.saveStamp(token: token, stampId: placeId, completion: { (res) in
                    print(res)
                    self.navigationController?.pushViewController(vc, animated: true)
                }) { (err) in
                    
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            
            } else if stampStatus == 1 {
                
             // 마이페이지로 화면전환
                
            }
        }
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
