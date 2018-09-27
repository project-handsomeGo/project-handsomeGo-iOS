//
//  PlaceVC.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    var tempPlace: Place!
    var tempToken =  UserDefaults.standard.string(forKey: "token")
    
    @IBOutlet weak var categoryColor: UIView!
    @IBOutlet weak var placeImgView: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAdd: UILabel!
    @IBOutlet weak var placeCategory: UILabel!
    @IBOutlet weak var placeContent: UILabel!
    @IBOutlet weak var placeScore: UILabel!
    @IBOutlet weak var placeReviewCount: UILabel!
    @IBOutlet var starImg: [UIImageView]!
    @IBOutlet weak var reviewCollection: UICollectionView!
    
    @IBOutlet weak var reviewCollectionH: NSLayoutConstraint!
    
    @IBOutlet weak var moreBtnH: NSLayoutConstraint!
    @IBOutlet weak var moreBtnView: UIView!
    
    @IBOutlet weak var reviewGoBtnH: NSLayoutConstraint!
    @IBOutlet weak var reviewGoBtnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funcForView()
        funcForDataUpload()
    }
    
    func funcForView(){
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        let Category = tempPlace?.placeCategory
        if ( Category == "역사 문화"){
            self.categoryColor.backgroundColor = UIColor(red: 251.0/255.0, green: 139.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        }else if ( Category == "과학 경제"){
            self.categoryColor.backgroundColor = UIColor(red: 91.0/255.0, green: 162.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        }
        
        self.moreBtnView.isHidden = true
        self.moreBtnH.constant = 0
        
        self.reviewGoBtnH.constant = 95
        self.reviewGoBtnView.isHidden = false
        
        if review == 1{
            self.reviewGoBtnH.constant = 0
            self.reviewGoBtnView.isHidden = true
        }else{
            reviewGoBtnView.center.x = self.view.frame.width + 30
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 30.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseOut, animations: ({
                self.reviewGoBtnView.center.x = self.view.frame.width / 2
            }), completion: nil)
            
            if stemp == 0{
                // 스테프를 찍어주세오
            }else if stemp == 1{
                //별점 평가해주세요
            }else if stemp == 2{
                //로그인해주세요
            }
        }
    }
    var stemp = 0
    var review = 0
    
    //data upload
    var tempReviewList : [ReviewList] = [ReviewList]()
    func funcForDataUpload(){
        self.placeImgView.kf.setImage(with: URL(string: (tempPlace?.placePic)!))
        self.placeName.text = tempPlace?.placeName
        self.placeAdd.text = tempPlace?.placeAddress
        self.placeCategory.text = tempPlace?.placeCategory
        self.placeContent.text = tempPlace?.placeContent
        self.placeScore.text = String((tempPlace?.placeStar)!)
        
        for i in 0...4{
            if i < (tempPlace?.placeStar)! {
                self.starImg[i].image =  UIImage(named: "starYellow.png")
            }else{
                self.starImg[i].image = UIImage(named: "starBlank.png")
            }
        }
        ReviewService.getReivew(id: (tempPlace?.placeID)!){ (reviewList,status,myComment) in
            self.tempReviewList = reviewList
            let count = reviewList.count
            self.placeReviewCount.text = "리뷰 " + String(count) + "개"
            if (count > 1){
                self.moreBtnH.constant = 39
                self.moreBtnView.isHidden = false
            }else if (count == 0){
                self.reviewCollectionH.constant = 0
            }
            if (status == "스탬프를 먼저 찎어주세요."){
                self.stemp = 0
            }else if (status == "별점을 평가해주세요"){
                self.stemp = 1
            }else if (status == "로그인 해주세요."){
                self.stemp = 1
            }
            if (myComment != ""){ // 널이 아니면, 이미 평가했다는것!
                self.review = 1
            }
            self.reviewCollection.reloadData()
        }
    }
    
    // collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tempReviewList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCVC", for: indexPath) as! ReviewCVC
        cell.reviewName.text = self.tempReviewList[indexPath.row].writer_name
        
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        dateFormatter.timeZone = TimeZone.current
        let originDate = dateFormatter.date(from: self.tempReviewList[indexPath.row].comment_date)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        cell.reviewDate.text = dateFormatter.string(from: originDate!)
        //
        
        cell.reviewComment.text = self.tempReviewList[indexPath.row].comment_comment!
        for i in 0...4{
            if i < (self.tempReviewList[indexPath.row].comment_star) {
                cell.starImg[i].image = UIImage(named: "starYellow.png")
            }else{
                cell.starImg[i].image = UIImage(named: "starBlank.png")
            }
        }
         cell.photoImg[0].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic1, defaultImgPath: "")
        cell.photoImg[1].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic2, defaultImgPath: "")
        cell.photoImg[2].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic3, defaultImgPath: "")
        cell.photoImg[3].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic4, defaultImgPath: "")
        return cell
    }
    
    @IBAction func backBtnAct(_ sender: UIButton) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    // register btn act
    @IBAction func reviewBtnAct(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Place", bundle:nil ).instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        vc.tempPlaceId = (self.tempPlace?.placeID)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // add btn act
    var count = 1
    @IBAction func moreBtnAt(_ sender: UIButton) {
        if count < self.tempReviewList.count{
        self.reviewCollectionH.constant += 250
        }
        count += 1
    }
}
