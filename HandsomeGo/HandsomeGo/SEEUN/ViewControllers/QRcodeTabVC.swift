//
//  QRcodeTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 4..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class QRcodeTabVC: UIViewController {
    @IBOutlet weak var rightLayout: NSLayoutConstraint!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var parentView: UIView!
    
    var lastScale: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let vc = UIStoryboard(name: "QRcode", bundle: nil).instantiateViewController(withIdentifier: "QRcodeVC")
//        self.present(vc, animated: true, completion: nil)
//
    }
    
    @IBAction func drag(_ sender: UIPanGestureRecognizer) {
   
        let translation = sender.translation(in: self.view)
       
//        translation.x = max(translation.x, parentView.frame.minX - view2.frame.minX)
//        translation.x = min(translation.x, parentView.frame.maxX - view2.frame.maxX)
//
//        translation.y = max(translation.y, parentView.frame.minY - view2.frame.minY)
//        translation.y = min(translation.y, parentView.frame.maxY - view2.frame.maxY)

        if let view = sender.view {
            
            var rec = view.frame;
            let imgvw = parentView.frame;
            if((rec.origin.x >= imgvw.origin.x && (rec.origin.x + rec.size.width <= imgvw.origin.x + imgvw.size.width)))
            {
                
                let movement = translation;
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                
                rec = view.frame;
                
                if rec.origin.x < imgvw.origin.x {
                    rec.origin.x = imgvw.origin.x
                    
                }
                
                if rec.origin.x + rec.size.width > imgvw.origin.x + imgvw.size.width {
                    rec.origin.x = imgvw.origin.x + imgvw.size.width - rec.size.width;
                }
                view.frame = rec;
                
//                view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
                
                sender.setTranslation(CGPoint.zero, in: self.view)
                
                
            }
        }
        
            
    }

    
    @IBAction func zoomInOut(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            lastScale = sender.scale
        }
        if let pinchView = sender.view , sender.state == .began || sender.state == .changed
        {
            let currentScale = (pinchView.layer.value(forKeyPath: "transform.scale") as AnyObject).floatValue
            let kMaxScale:CGFloat = 3.0
            let kMinScale:CGFloat = 1.0
            
            var newScale = 1.0 - (lastScale - sender.scale)
            if let currentScale = currentScale {
                newScale = min(newScale, kMaxScale / CGFloat(currentScale))
                newScale = max(newScale, kMinScale / CGFloat(currentScale))
                pinchView.transform = pinchView.transform.scaledBy(x: newScale, y: newScale)
                sender.scale = 1.0
                lastScale = sender.scale
            }
        }
        
        
//
//        if let view = sender.view {
//
//            if sender.state == .changed || sender.state == .ended {
//                if sender.scale < 1 {
//                    sender.scale = 1
//                }
//            }
//
//            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
//            sender.scale = 1
//        }
        
       
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
