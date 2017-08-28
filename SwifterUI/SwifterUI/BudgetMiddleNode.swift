//
//  BudgetMiddleNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

enum Price {
    
    case minimum
    case small
    
    func getString() -> String {
        switch self {
        case .minimum: return "$100 - $200"
        case .small: return "$200 - $300"
        }
    }
}

class BudgetMiddleNode: SFDisplayNode {
    
    var selectedPrice: Price = .minimum {
        didSet {
            self.priceNode.text = self.selectedPrice.getString()
            self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        }
    }
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.font = UIFont.boldSystemFont(ofSize: self.deviceType == .iphone ? 17:21)
        node.text = "We need a price range for\n your diet"
        node.color = UIColor.black
        node.aligment = .center
        return node
    }()
    
    lazy var priceNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.font = UIFont.boldSystemFont(ofSize: self.deviceType == .iphone ? 24:32)
        node.text = self.selectedPrice.getString()
        node.color = UIColor(red: 30, green: 136, blue: 229)
        return node
    }()
    
    lazy var subtitleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.font = UIFont.systemFont(ofSize: self.deviceType == .iphone ? 15:17)
        node.text = "This is the estimated amount that you are going to use weekly"
        node.color = SFAssets.gray
        node.aligment = .center
        return node
    }()
    
    lazy var pageControl: SFPageControlNode = {
        let node = SFPageControlNode()
        node.pageControl.numberOfPages = 2
        node.pageControl.currentPageIndicatorTintColor = UIColor.black
        node.pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.32)
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
        selectedPrice = .small
        pageControl.currentPage = 1
    }
    
    @objc func swipeRight() {
        selectedPrice = .minimum
        pageControl.currentPage = 0
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
                
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 12, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [titleNode, getStackSeparator(), priceNode, getStackSeparator(), subtitleNode, getStackSeparator(), pageControl])
        
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
