//
//  ViewController.swift
//  LyftChallenge
//
//  Created by Abbas Angouti on 11/23/18.
//  Copyright © 2018 Abbas Angouti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var animatingViews: [UIView]!
    
    var animationTimer: Timer!
    let delta: CGFloat = 55
    
    var startingFrame = CGRect(x: 312, y: 233, width: 40, height: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        animationTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true
            , block: animate)
    }

    func animate(t: Timer) {
        var currentFrames = [Int: CGRect]()
        for animatingView in animatingViews {
            currentFrames[animatingView.tag] = animatingView.frame
        }
        
        var finalFrames = [Int: CGRect]()
        for animatingView in animatingViews {
            let currentFrame = currentFrames[animatingView.tag]!
            finalFrames[animatingView.tag] = CGRect(origin: CGPoint(x: currentFrame.origin.x-self.delta, y: currentFrame.origin.y), size: currentFrame.size)
        }
        let inMarginView = animatingViews.filter { $0.frame.origin.x <= delta }
        if inMarginView.count > 0 {
            let toBeShiftedRight = inMarginView.first!
            let toBeShiftedLeft = animatingViews.filter { $0 != toBeShiftedRight }
            // move it to right and start over
            UIView.animate(withDuration: 0.5, animations: {
                toBeShiftedRight.frame = self.startingFrame
                for animatingView in toBeShiftedLeft {
                    animatingView.frame = finalFrames[animatingView.tag]!
                }
            }, completion: nil)
            
        } else {
            for animatingView in self.animatingViews {
                UIView.animate(withDuration: 0.5, animations: {
                    animatingView.frame = finalFrames[animatingView.tag]!
                }, completion: nil)
            }
        }
    }
}

