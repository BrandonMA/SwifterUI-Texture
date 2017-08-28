//
//  MovementMiddleNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

enum MovementLevel: String {
    case Highly
    case Normally
}

class MovementMiddleNode: SFDisplayNode {
    
    var selectedLevel: MovementLevel = .Highly {
        didSet {
            labelNode.text = self.selectedLevel.rawValue
            self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        }
    }
    
    lazy var labelNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = UIColor.black
        node.font = self.deviceType == .iphone ? UIFont.boldSystemFont(ofSize: 17):UIFont.boldSystemFont(ofSize: 21)
        node.text = self.selectedLevel.rawValue
        node.aligment = .center
        return node
    }()
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.image = UIImage(named: "banana")
        return node
    }()
    
    lazy var pageControl: SFPageControlNode = {
        let node = SFPageControlNode()
        node.pageControl.numberOfPages = 2
        node.pageControl.currentPageIndicatorTintColor = UIColor.black
        node.pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.30)
        return node
    }()
    
    init() {
        super.init(automaticallyAdjustsColorStyle: false)
        self.view.isUserInteractionEnabled = true
        
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        leftSwipeRecognizer.direction = .left
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        rightSwipeRecognizer.direction = .right
        
        self.view.addGestureRecognizer(leftSwipeRecognizer)
        self.view.addGestureRecognizer(rightSwipeRecognizer)
    }
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
    
    @objc func swipeLeft() {
        UIView.transition(with: imageNode.view, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.selectedLevel = .Normally
            self.imageNode.image = UIImage(named: "sophie")
            self.pageControl.currentPage = 1
        }, completion: nil)
    }
    
    @objc func swipeRight() {
        UIView.transition(with: imageNode.view, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.selectedLevel = .Highly
            self.imageNode.image = UIImage(named: "banana")
            self.pageControl.currentPage = 0
        }, completion: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        imageNode.style.height = ASDimension(unit: ASDimensionUnit.fraction, value: 0.65)
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [labelNode, getStackSeparator(), imageNode, getStackSeparator(), pageControl])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stackLayout)
    }
    
    // animateLayoutTransition: Animate all changes in layout, this is implemented for convenience and simple animations used on the library, override this for a different transition
    open override func animateLayoutTransition(_ context: ASContextTransitioning) {
        
        for node in self.subnodes {
            node.frame = context.initialFrame(for: node)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                node.frame = context.finalFrame(for: node)
            }, completion: { (finished) in
                context.completeTransition(finished)
            })
        }
    }
    
}




























