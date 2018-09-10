//
//  HomeTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 10..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeTabVC: UIViewController {

    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var rankBtn: UIButton!
    
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rankTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rankTableView.delegate = self
        rankTableView.dataSource = self
    }
}

extension HomeTabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankTableView.dequeueReusableCell(withIdentifier: "RankCell", for: indexPath) as! RankCell
        return cell
        
    }
}
