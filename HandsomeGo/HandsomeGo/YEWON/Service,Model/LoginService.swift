//
//  LoginService.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
/*
 보내는것
 "id" : "카카오톡 로그인 한 후 반환받는 고유 ID",
 "name" : "카카오톡 로그인 한 후 반환받는 사용자 닉네임",
 "profileImagePath" : "카카오톡 로그인 한 후 반환받는 프로필 사진 경로"
 받는것
 token: 사용자 토큰
 */

struct LoginService:APIService{
    static func logInit(id:String, name:String, profileImagePath:String, completion : @escaping (String)->Void) {
        
        let URL = url("/login")
        let body: [String : Any] = [
            "id":id,
            "name":name,
            "profileImagePath":profileImagePath
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseData() {res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    if (JSON(value)["message"].string! == "login success"){
                        completion(JSON(value)["token"].string!)
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
}
