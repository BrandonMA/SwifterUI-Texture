//
//  AppleMusicLikePresentationController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public protocol SFAppleMusicLikeDismissProtocol: class {
    
    // MARK: - Instance Properties
    
    // initialPoint: Keep track of the initial point of the UIPanGestureRecognizer inside dismiss(with:) function, the initial value of this variable is not important, is constantly updated by dismiss(with:)
    var initialPoint: CGFloat { get set }
    
    // MARK: - Instance Methods
    
    // didDragged: Gets called when the user drag the SFNode, also it is in charge of animating the changes
    func dismiss(with gesture: UIPanGestureRecognizer)
    
}

extension SFAppleMusicLikeDismissProtocol where Self: UIViewController {

    public func dismiss(with gesture: UIPanGestureRecognizer) {

        guard let window = UIApplication.shared.keyWindow else { fatalError() } // Get the current window, if you can't get it then something is wrong with the OS so crash
        let currentPoint = gesture.location(in: window).y // Get the current point of the dragging gesture

        if gesture.state == .began {
            initialPoint = gesture.location(in: window).y // Set the initialPoint to the correct value
        } else  if gesture.state == .changed {
            let distance =  currentPoint - initialPoint // Calculate distance between initial point and new position
            self.view.frame.origin.y += distance
            initialPoint = currentPoint // and set the new value of initialPoint
            if self.view.frame.origin.y > 120 {
                dismiss(animated: true, completion: nil)
            }
        } else if gesture.state == .ended {
            if self.view.frame.origin.y < 120 { // if self.view is less than 120 then take it back to the correct place
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
                    self.view.frame.origin.y = 30
                }, completion: nil)
            } else { // if not then dismiss it
                dismiss(animated: true, completion: nil)
            }
        }
    }

}

open class SFAppleMusicLikePresentationController<SFPresentingNodeType>: SFPresentationController<SFPresentingNodeType> where SFPresentingNodeType: SFDisplayNode {
    
    lazy var dimmingView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = self.colorStyle == .light ? UIColor.black : UIColor.white
        return view
    }()
    
    // MARK: - Instance Methods
    
    open override func updateColors() {
        dimmingView.backgroundColor = self.colorStyle == .light ? UIColor.black : UIColor.white
        if self.automaticallyAdjustsColorStyle == true {
            if let controller = self.presentingViewController as? SFViewController<SFPresentingNodeType> {
                controller.SFNode.updateColors()
            }
        }
    }
    
    override open func presentationTransitionWillBegin() {
        
        self.dimmingView.frame = self.presentingViewController.view.frame
        self.presentingViewController.view.addSubview(self.dimmingView)
        self.presentedView?.roundTop(radius: 16)
        
        UIView.animate(withDuration: 0.25) {
            self.dimmingView.alpha = 0.30
            self.presentingViewController.view.clipsToBounds = true
            self.presentingViewController.view.layer.cornerRadius = 16
            self.presentingViewController.view.frame.origin.y += 20
            
            if let controller = self.presentingViewController as? SFViewController<SFPresentingNodeType> {
                if controller.automaticallyAdjustsColorStyle == true {
                    controller.automaticallyAdjustsColorStyle = false
                    self.automaticallyAdjustsColorStyle = true
                    self.updateColors()
                }
                controller.statusBarStyle = .lightContent
            }
        }
        
    }
        
    override open func dismissalTransitionWillBegin() {
        
        if let controller = self.presentingViewController as? SFViewController<SFPresentingNodeType> {
            if self.automaticallyAdjustsColorStyle == true {
                controller.automaticallyAdjustsColorStyle = true
                controller.updateColors()
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.dimmingView.alpha = 0
            self.presentingViewController.view.layer.cornerRadius = 0
            self.presentingViewController.view.frame.origin.y -= 20
        }) { (finished) in
            self.dimmingView.removeFromSuperview()
        }
        
    }
    
    override open func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override open func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height - 30)
    }
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        
        var frame = CGRect.zero
        guard let containerView = containerView else { return CGRect.zero }
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        
        frame.origin = CGPoint(x: 0, y: 30)
        
        return frame
    }
    
}
