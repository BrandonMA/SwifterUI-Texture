//
//  AppleMusicLikePresentationController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFAppleMusicPresentationController<SFPresentingNodeType>: SFPresentationController<SFPresentingNodeType> where SFPresentingNodeType: SFDisplayNode {
    
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
