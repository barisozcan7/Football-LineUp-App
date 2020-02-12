//
//  DemoViewController.swift
//  gestureDemo
//
//  Created by Barıs Ozcan on 28.12.2019.
//  Copyright © 2019 Barıs Ozcan. All rights reserved.
//

import UIKit

extension DemoViewController:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if(gestureRecognizer == panGestureRecognizer && otherGestureRecognizer == swipeGestureRecognizer){
            return true
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if((gestureRecognizer == pinchGestureRecognizer && otherGestureRecognizer == rotationGestureRecognizer) || (gestureRecognizer == rotationGestureRecognizer && otherGestureRecognizer == pinchGestureRecognizer)){
                   return true
               }
               return false
    }
}

class DemoViewController: UIViewController {
    
    @IBOutlet weak var square: UIView!
    
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet var pinchGestureRecognizer: UIPinchGestureRecognizer!
    
    @IBOutlet var rotationGestureRecognizer: UIRotationGestureRecognizer!
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapped(_ sender: Any) {
        square.transform = CGAffineTransform.identity
    }
    
    
    @IBAction func panRecognized(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        square.center = CGPoint(x: square.center.x + translation.x, y: square.center.y + translation.y)
        
//        square.transform = square.transform.translatedBy(x: translation.x, y: translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func pinchDetected(_ sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        
        square.transform = square.transform.scaledBy(x: scale, y: scale)

        sender.scale = 1
        
    }
    
    
    @IBAction func rotationDetected(_ sender: UIRotationGestureRecognizer) {
        
        let rotation = sender.rotation
        
        square.transform = square.transform.rotated(by: rotation)
        
        sender.rotation = 0
    }
    
    @IBAction func swipeDetected(_ sender: UISwipeGestureRecognizer) {
               let red = Float.random(in: 0...255) / 255.0
               
               let green = Float.random(in: 0...255) / 255.0
               
               let blue = Float.random(in: 0...255) / 255.0
               
               square.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
    

}
