//
//  ProfileChangeVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 17..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ProfileChangeVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTxfd: UITextField!
    let imagePicker : UIImagePickerController = UIImagePickerController()
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0MiwiaWF0IjoxNTM3MzYxNDI1LCJleHAiOjE1Mzk5NTM0MjV9.GNSbBt28VaJPlISjzP82WUhHONpAfR-VgLC84cZxhD0"
    
    @IBAction func openGalleryAction(_ sender: UIButton) {
        openGallery()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius =
            43*self.view.frame.height/667
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        nameTxfd.delegate = self
        
        dataInit()
        barButtonInit()
    }
    
    func barButtonInit() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        
        let button = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(saveAction))
        button.setTitleTextAttributes( [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFR", size: 15)!, NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        self.navigationItem.rightBarButtonItem = button
        
        
    }
    
    func dataInit() {
        MyPageService.shareInstance.getMyPage(token: token, completion: { (profile) in
            self.profileImageView.imageFromUrl(profile.picture, defaultImgPath: "")
            self.nameTxfd.text = profile.name
            
        }) { (err) in
        }
    }
    
    @objc func saveAction() {
        MyPageService.shareInstance.changeMyPage(token: token, name: nameTxfd.text! , photo: profileImageView.image) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}



extension ProfileChangeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            
            // false이면 이미지를 자르지 않고
            // true면 자유자제로 크롭 가능
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImageView.image = originalImage
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
}

