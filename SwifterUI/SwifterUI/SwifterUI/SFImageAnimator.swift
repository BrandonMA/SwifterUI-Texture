////
////  SFImageNavigator.swift
////  SwifterUI
////
////  Created by brandon maldonado alonso on 05/09/17.
////  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
////
//
//import AsyncDisplayKit
//
//public class SFImageAnimator: SFImageAnimatorProtocol {
//
//    public var imageAnimator: UIViewPropertyAnimator =  UIViewPropertyAnimator()
//    public var thumbnailFrame: CGRect? = nil
//    weak public var initialSuperNode: ASDisplayNode? = nil
//
//    public func animate(imageNode: SFImageNode, gesture: UIGestureRecognizer) {
//
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        window.addSubnode(imageNode)
//
//        if let gesture = gesture as? UIPanGestureRecognizer {
//            if gesture.state == .began {
//                startAnimation(imageNode: imageNode, gesture: gesture)
//            } else if gesture.state == .changed {
//                animateSwipe(imageNode: imageNode, gesture: gesture)
//            } else if gesture.state == .ended {
//                endAnimation(imageNode: imageNode, gesture: gesture)
//            }
//        } else if let gesture = gesture as? UITapGestureRecognizer {
//            startAnimation(imageNode: imageNode, gesture: gesture)
//            endAnimation(imageNode: imageNode, gesture: gesture)
//        }
//
//
//    }
//
//    public func startAnimation(imageNode: SFImageNode, gesture: UIGestureRecognizer) {
//        var finalFrame: CGRect = CGRect()
//        switch imageNode.currentState {
//        case .fullScreen:
//            if let frame = self.thumbnailFrame {
//                finalFrame = frame
//            }
//        case .thumbnail:
//            self.thumbnailFrame = imageNode.frame
//            finalFrame = UIScreen.main.bounds
//            self.initialSuperNode = imageNode.supernode
//        }
//
//        self.imageAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7, animations: {
//            imageNode.frame = finalFrame
//        })
//    }
//
//    public func animateSwipe(imageNode: SFImageNode, gesture: UIPanGestureRecognizer) {
//
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        let translation = gesture.translation(in: window)
//
//        let yTranslation = window.center.y + translation.y
//
//        var progress:CGFloat = 0
//
//        switch imageNode.currentState {
//        case .thumbnail:
//            progress = 1 - (yTranslation / window.center.y)
//        case .fullScreen:
//            progress = (yTranslation / window.center.y) - 1
//        }
//
//        progress = max(0.0001, min(0.9999, progress))
//        imageAnimator.fractionComplete = progress
//    }
//
//    public func endAnimation(imageNode: SFImageNode, gesture: UIGestureRecognizer) {
//
//        self.imageAnimator.addCompletion({ (animatingPosition) in
//            gesture.isEnabled = true
//        })
//
//        gesture.isEnabled = false
//
//        self.imageAnimator.startAnimation()
//
//        switch imageNode.currentState {
//        case .fullScreen:
//            self.initialSuperNode?.addSubnode(imageNode)
//            imageNode.currentState = .thumbnail
//        case .thumbnail:
//            imageNode.currentState = .fullScreen
//        }
//    }
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
