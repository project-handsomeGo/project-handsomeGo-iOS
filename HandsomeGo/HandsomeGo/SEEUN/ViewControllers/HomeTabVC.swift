//
//  HomeTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 10..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeTabVC: UIViewController {
    var detailOpened = false {
        didSet {
            mapDetailView.isHidden = !detailOpened
        }
    }
    
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var rankBtn: UIButton!
    @IBOutlet weak var mapUnderBar: UIView!
    @IBOutlet weak var rankUnderBar: UIView!
   
    // Map Outlet
    @IBOutlet weak var mapScrollView: UIScrollView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapImageView: UIImageView!
    
    // Map Detail Outlet
    @IBOutlet weak var mapDetailView: UIView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    
    // Rank Outlet
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rankTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapSetup()
        mapDetailSetup()
        rankSetup()
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("\(mapScrollView.contentOffset.x),\(mapScrollView.contentOffset.y)")
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapScrollView.zoomScale = 1.5
        mapScrollView.contentOffset = CGPoint(x: 95, y: 51)
    }
    
    func rankSetup() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
        
        imageView.layer.cornerRadius = 8 * self.view.frame.width/375
        imageView.layer.masksToBounds = true
        
        rankUnderBar.isHidden = true
        rankView.isHidden = true
    }
    
    @IBAction func mapTapAction(_ sender: UIButton) {
        
        rankUnderBar.isHidden = true
        rankView.isHidden = true
        
        mapUnderBar.isHidden = false
        mapScrollView.isHidden = false
        
        mapDetailView.isHidden = !detailOpened
       
    }
    
    @IBAction func rankTapAction(_ sender: UIButton) {
        rankUnderBar.isHidden = false
        rankView.isHidden = false
        
        mapDetailView.isHidden = true
        mapUnderBar.isHidden = true
        mapScrollView.isHidden = true
    }
    @IBAction func mapIconTapAction(_ sender: UIButton) {
        detailOpened = true
    }
    
    @objc func dismissView() {
        detailOpened = false
    }
    
    
}


extension HomeTabVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapView
    }
    
    func mapSetup() {
        
        mapDetailView.isHidden = true
        
        let detailViewDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.mapScrollView.addGestureRecognizer(detailViewDismiss)
        mapScrollView.delegate = self
        mapScrollView.alwaysBounceVertical = false
        mapScrollView.alwaysBounceHorizontal = false
        mapScrollView.minimumZoomScale = 1.0
        mapScrollView.maximumZoomScale = 3.0
        mapScrollView.contentOffset = CGPoint(x: 74, y: 0)
        
    }
    
    func mapDetailSetup(){
        mapDetailView.layer.shadowRadius = 6
        mapDetailView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mapDetailView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mapDetailView.layer.shadowOpacity = 0.15
        
        detailBtn.layer.cornerRadius = 27/2*self.view.frame.width/375

    }
        

}

extension HomeTabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankTableView.dequeueReusableCell(withIdentifier: "RankCell", for: indexPath) as! RankCell
        cell.numLabel.text = "\(indexPath.row+1)"
        return cell
        
    }
}
