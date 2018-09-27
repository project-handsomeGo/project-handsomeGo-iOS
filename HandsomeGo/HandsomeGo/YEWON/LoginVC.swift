//
//  LoginVC.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import UIKit
import KakaoCommon
import KakaoOpenSDK

class LoginVC: UIViewController {

    let userdefault = UserDefaults.standard
    var token = "" // 연동 후 통신하면 서버한테 나중에 받을것
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func kakaoBtn(_ sender: Any) {
        let session: KOSession = KOSession.shared()
        
        
        if session.isOpen() {
            session.close()
        }
        
        
        session.open(completionHandler: { (error) -> Void in
            print("t0")
            if session.isOpen() {
                print("t00")
                KOSessionTask.userMeTask(completion:{ (profile, error) in
                    print("t000")
                    
                    
                    if profile != nil {
                        print("t0000")
                        DispatchQueue.main.async {
                            print("t00000")
                            let kakao: KOUserMe = profile as! KOUserMe
                            print(String(describing: kakao.id))
                            
                        }
                        
                    }
                    
                }
                )
            }
        })
    }
    
    
    //1. 카카오 연동하기
    
    //2. 게스트 입장하기 token ==""
    
    //
    @IBAction func loginBtnAct(_ sender: UIButton) {
        
        // 통신 (카카오에서 받은 정보를 서버한테 보내고 토큰값 받는다.)
        // 유저디폴트 설정
        /*LoginService.logInit(id: "", name: "", profileImagePath: ""){ (token) in
         self.token = token
            self.userdefault.set(token, forKey: "token")
        }*/
        
       token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0MSwiaWF0IjoxNTM2ODMyMzM4LCJleHAiOjE1Mzk0MjQzMzh9.ssbA-QxKsjgmzw2q9X06F4kDefuLttwGDN8KFFCab8Q"
        self.userdefault.set(token, forKey: "token")
        // 화면 전환
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func guestBtnAct(_ sender: UIButton) {
        self.userdefault.set(token, forKey: "token") //""
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.present(vc, animated: false, completion: nil)
    }
}
