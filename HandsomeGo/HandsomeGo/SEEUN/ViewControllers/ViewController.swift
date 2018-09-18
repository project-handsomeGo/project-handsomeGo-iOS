//
//  ViewController.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 4..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var sc: UIScrollView!
    @IBOutlet weak var imv: UIImageView!
    
    @IBOutlet weak var rightLayout: NSLayoutConstraint!
//    @IBOutlet weak var leftLayout: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightLayout.constant = -229*self.view.frame.width/375
        
        let off = CGPoint(x: 75, y: 0)
        sc.setContentOffset(off, animated: false)
        print( sc.contentOffset.x )
        sc.alwaysBounceVertical = false
        sc.alwaysBounceHorizontal = false
        sc.minimumZoomScale = 1.0
        sc.maximumZoomScale = 3.0
        sc.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let off = CGPoint(x: 75, y: 0)
        sc.setContentOffset(off, animated: false)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(sc.contentOffset.x)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imv
    }

}

