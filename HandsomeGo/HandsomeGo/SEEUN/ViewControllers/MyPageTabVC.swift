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
    
    var opened = false {
        didSet {
            infoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.dataSource = self
        infoTableView.delegate = self
    }
}

extension MyPageTabVC:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 && opened == true {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.section == 0{
            cell = infoTableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            
        } else if indexPath.section == 1 {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "InfoChangeCell")
        } else if indexPath.section == 2 && indexPath.row == 0  {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "StampButtonCell")
        } else if indexPath.section == 2 && indexPath.row == 1 {
            let listCell = infoTableView.dequeueReusableCell(withIdentifier: "StampListCell") as! StampListCell
            
            let unit = self.view.frame.width/375
            
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
            opened = !opened
        }
    }
    
}
//
//extension MyPageTabVC: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: self.stampCollectionView.frame.width / 4 , height: self.stampCollectionView.frame.width / 4)
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = stampCollectionView.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath)
//
//        return cell
//    }
//}
