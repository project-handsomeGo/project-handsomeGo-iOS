//
//  MyPageTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 11..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class MyPageTabVC: UIViewController {
    @IBOutlet weak var infoTableView: UITableView!
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0MiwiaWF0IjoxNTM3MzYxNDI1LCJleHAiOjE1Mzk5NTM0MjV9.GNSbBt28VaJPlISjzP82WUhHONpAfR-VgLC84cZxhD0"
    
    let stampImage = [#imageLiteral(resourceName: "sDoldamgil"),#imageLiteral(resourceName: "sCulture"),#imageLiteral(resourceName: "sUnderBunker.png"),#imageLiteral(resourceName: "sKyungChun"),#imageLiteral(resourceName: "sBongjae"),#imageLiteral(resourceName: "s50Plus"),#imageLiteral(resourceName: "sHamsangPark"),#imageLiteral(resourceName: "sSeoulGarden"),#imageLiteral(resourceName: "sNewPlaza"),#imageLiteral(resourceName: "sHasudo"),#imageLiteral(resourceName: "sBioHub"),#imageLiteral(resourceName: "sCarIndustry"),#imageLiteral(resourceName: "sInnovationHub"),#imageLiteral(resourceName: "sInnovationPark"),#imageLiteral(resourceName: "sSeoulScience"),#imageLiteral(resourceName: "sSeoulHub"),#imageLiteral(resourceName: "sSeoullo7017"),#imageLiteral(resourceName: "sDonuimun"),#imageLiteral(resourceName: "sSeoulbiennale"),#imageLiteral(resourceName: "sSewoon")]
    let stampGrayImage = [#imageLiteral(resourceName: "sDoldamgilGray"),#imageLiteral(resourceName: "sCultureGray"),#imageLiteral(resourceName: "sUnderBunkerGray"),#imageLiteral(resourceName: "sKyungChunGray"),#imageLiteral(resourceName: "sBongjaeGray"),#imageLiteral(resourceName: "s50PlusGray"),#imageLiteral(resourceName: "sHansangParkGray"),#imageLiteral(resourceName: "sSeoulGardenGray"),#imageLiteral(resourceName: "sNewPlazaGray"),#imageLiteral(resourceName: "sHasudoGray"),#imageLiteral(resourceName: "sBioHubGray"),#imageLiteral(resourceName: "sCarIndustryGray"),#imageLiteral(resourceName: "sInnovationHubGray"),#imageLiteral(resourceName: "sInnovationParkGray"),#imageLiteral(resourceName: "sSeoulScienceGray"),#imageLiteral(resourceName: "sSeoulHubGray"),#imageLiteral(resourceName: "sSeoullo7017Gray"),#imageLiteral(resourceName: "sDonuimunGray"),#imageLiteral(resourceName: "sSeoulbiennaleGray"),#imageLiteral(resourceName: "sSewoonGray")]
    
    var myStamp:[UIImage] = []  {
        didSet {
            infoTableView.reloadData()
        }
    }
    
    var myProfile: Profile?  {
        didSet {
            infoTableView.reloadData()
        }
    }
    
    var opened = false {
        didSet {
            infoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.dataSource = self
        infoTableView.delegate = self
        dataInit()
        setupNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataInit()
    }
    func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func dataInit() {
        
        StampListService.shareInstance.getStampList(token: token, completion: { (list) in
            self.myStamp.removeAll()
            for i in 0...list.count-1 {
                if list[i].stampStatus == 0 {
                    self.myStamp.append(self.stampGrayImage[i])
                } else {
                    self.myStamp.append(self.stampImage[i])
                }
            }
            
        }) { (err) in
            
        }
        MyPageService.shareInstance.getMyPage(token: token, completion: { (profile) in
            self.myProfile = profile
        }) { (err) in
        }
    }
    
}

extension MyPageTabVC:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if myProfile != nil && myStamp.count > 0{
            
            return 4
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 && opened == true {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        //수정
        guard let profile = self.myProfile else{return cell}
        let unit = self.view.frame.width/375
        
        if indexPath.section == 0{
            let infoCell = infoTableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            
            infoCell.profileImageView.layer.cornerRadius =
                43*unit
            infoCell.profileImageView.imageFromUrl(profile.picture, defaultImgPath: "")
            infoCell.nameLabel.text = profile.name
            infoCell.stampLabel.text = "\(profile.stampCount) / 20"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
            dateFormatter.timeZone = TimeZone.current
            let originDate = dateFormatter.date(from: profile.lastStampDate)
            dateFormatter.dateFormat = "yyyy.MM.dd"
            infoCell.dateLabel.text = dateFormatter.string(from: originDate!)
            
            return infoCell
            
        } else if indexPath.section == 1 {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "InfoChangeCell")
        } else if indexPath.section == 2 && indexPath.row == 0  {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "StampButtonCell")
        } else if indexPath.section == 2 && indexPath.row == 1 {
            let listCell = infoTableView.dequeueReusableCell(withIdentifier: "StampListCell") as! StampListCell
            listCell.stampImage = myStamp
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20*unit, left: 23*unit, bottom: 20*unit, right: 23*unit)
            layout.itemSize = CGSize(width: 55*unit, height: 55*unit)
            layout.minimumLineSpacing = 27*unit
            layout.minimumInteritemSpacing = 36*unit
            
            listCell.stampCollectionView.collectionViewLayout = layout
            
            listCell.collectionViewHeight.constant = 425*unit
            
            return listCell
        } else if indexPath.section == 3 {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "LogoutCell")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
           
           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileChangeVC") as! ProfileChangeVC
             self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 0 {
            
            dataInit()
            
            opened = !opened
        }
    }
    
}
