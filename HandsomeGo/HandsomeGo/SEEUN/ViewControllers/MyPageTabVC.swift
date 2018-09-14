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
    @IBOutlet weak var stampCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.dataSource = self
        infoTableView.delegate = self
        stampCollectionView.dataSource = self
        stampCollectionView.delegate = self
    }
    
    


}

extension MyPageTabVC:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.row == 0{
            cell = infoTableView.dequeueReusableCell(withIdentifier: "InfoChange")
        } else if indexPath.row == 1 {
            cell = infoTableView.dequeueReusableCell(withIdentifier: "StampList")
        }
        
        return cell
        
    }
    
}

extension MyPageTabVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
