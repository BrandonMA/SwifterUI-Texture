//
//  SFAppleMusicPresentable.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 15/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFAppleMusicPresentable: class {
    
    // MARK: - Instance Properties
    
    // appleMusicGestureRecognizer: Gesture to recognize when user try to dismiss, remember to add it inside viewDidAppear
    var appleMusicGestureRecognizer: UIPanGestureRecognizer! { get set }
    
    // initialPoint: Keep track of the initial point of appleMusicGestureRecognizer, the initial value of this variable should be 0
    var initialPoint: CGFloat { get set }
    
    // MARK: - Instance Methods
    
    // appleMusicDismiss: call this inside the @objc func that handle appleMusicGestureRecognizer
    func appleMusicDismiss()
}

extension SFAppleMusicPresentable where Self: UIViewController {
    
    public func appleMusicDismiss() {
        guard let window = UIApplication.shared.keyWindow else { fatalError() }
        let currentPoint = appleMusicGestureRecognizer.location(in: window).y
        
        if appleMusicGestureRecognizer.state == .began {
            initialPoint = appleMusicGestureRecognizer.location(in: window).y
        } else  if appleMusicGestureRecognizer.state == .changed {
            let distance =  currentPoint - initialPoint // Calculate distance between initial point and new position
            self.view.frame.origin.y += distance
            initialPoint = currentPoint
            if self.view.frame.origin.y > 120 {
                dismiss(animated: true, completion: nil)
            }
        } else if appleMusicGestureRecognizer.state == .ended {
            if self.view.frame.origin.y < 120 {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
                    self.view.frame.origin.y = 30
                }, completion: nil)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
