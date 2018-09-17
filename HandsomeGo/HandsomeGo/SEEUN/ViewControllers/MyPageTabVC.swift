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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.dataSource = self
        infoTableView.delegate = self
    }
}

extension MyPageTabVC:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.row == 0{
            cell = infoTableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            
        } else if indexPath.row == 1 {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "InfoChangeCell")
        } else if indexPath.row == 2 {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "StampButtonCell")
        } else if indexPath.row == 3 {
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
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
           
           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileChangeVC") as! ProfileChangeVC
             self.navigationController?.pushViewController(vc, animated: true)
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
