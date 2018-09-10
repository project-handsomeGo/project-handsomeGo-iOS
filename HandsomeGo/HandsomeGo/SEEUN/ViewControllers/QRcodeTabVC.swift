//
//  QRcodeTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 4..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class QRcodeTabVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIStoryboard(name: "QRcode", bundle: nil).instantiateViewController(withIdentifier: "QRcodeVC")
        self.present(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
