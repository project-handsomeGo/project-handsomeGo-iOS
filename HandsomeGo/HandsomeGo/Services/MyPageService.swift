
//
//  MyPageService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MyPageService: APIService, RequestService{
    static let shareInstance = MyPageService()
    let URL = url("/mypage")
    typealias NetworkData = MypageData
    
    func getMyPage(token: String, completion: @escaping (Profile) -> Void, error: @escaping (Int) -> Void) {
       
        let header: HTTPHeaders = [
            "Authorization" : token,
            "Content-Type" : "application/json"
        ]
        gettable(URL, body: nil, header: header) { res in
            switch res {
            case .success(let productData):
                
                let data = productData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
