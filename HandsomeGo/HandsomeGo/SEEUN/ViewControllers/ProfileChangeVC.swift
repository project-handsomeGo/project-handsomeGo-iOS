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
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius =
            86*self.view.frame.height/667
        profileImageView.layer.masksToBounds = true
        
        nameTxfd.delegate = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
