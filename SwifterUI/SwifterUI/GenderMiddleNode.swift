//
//  GenderMiddleNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

enum Gender: String {
    case Male
    case Female
}
class GenderMiddleNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    var selectedGender: Gender = .Male {
        didSet {
            titleNode.text = self.selectedGender.rawValue
            self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        }
    }
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = UIColor.black
        node.font = self.deviceType == .iphone ? UIFont.boldSystemFont(ofSize: 17):UIFont.boldSystemFont(ofSize: 21)
        node.text = self.selectedGender.rawValue
        node.aligment = .center
        return node
    }()
    
    lazy var maleImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.image = UIImage(named: "\(Gender.Male.rawValue)")
        return node
    }()
    
    lazy var femaleImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.image = UIImage(named: "\(Gender.Female.rawValue)")
        return node
    }()
    
    lazy var pageControl: SFPageControlNode = {
        let node = SFPageControlNode()
        node.pageControl.numberOfPages = 2
        node.pageControl.currentPageIndicatorTintColor = UIColor.black
        node.pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.32)
        return node
    }()
    
    // MARK: - Initializers
    
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
    
    // MARK: - Instance Methods
    
    @objc func swipeLeft() {
        selectedGender = .Female
        UIView.animate(withDuration: 0.5, animations: {
            // This values were selected by trying a lot, i don't know why they make both images the size they should
            self.maleImageNode.view.transform = CGAffineTransform(scaleX: 0.77, y: 0.77)
            self.femaleImageNode.view.transform = CGAffineTransform(scaleX: 1.28, y: 1.28)
        })
        self.pageControl.currentPage = 1
    }
    
    @objc func swipeRight() {
        selectedGender = .Male
        UIView.animate(withDuration: 0.5, animations: {
            self.maleImageNode.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.femaleImageNode.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        self.pageControl.currentPage = 0
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        maleImageNode.style.height = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        maleImageNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 0.33)
        femaleImageNode.style.height = ASDimension(unit: ASDimensionUnit.fraction, value: 0.4)
        femaleImageNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 0.33)
        
        let maleLayout = ASCenterLayoutSpec(horizontalPosition: selectedGender == .Male ? .center : .start, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: maleImageNode)
        
        let femaleLayout = ASCenterLayoutSpec(horizontalPosition: selectedGender == .Female ? .center : .end, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: femaleImageNode)
        
        var finalLayout = ASOverlayLayoutSpec(child: maleLayout, overlay: femaleLayout)
        
        let titleLayout = ASCenterLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.start, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: titleNode)
        
        finalLayout = ASOverlayLayoutSpec(child: finalLayout, overlay: titleLayout)
        
        let pageControlLayout = ASCenterLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.end, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: pageControl)
        
        finalLayout = ASOverlayLayoutSpec(child: finalLayout, overlay: pageControlLayout)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0), child: finalLayout)
    }
    
    // animateLayoutTransition: Animate all changes in layout, this is implemented for convenience and simple animations used on the library, override this for a different transition
    open override func animateLayoutTransition(_ context: ASContextTransitioning) {
        
        for node in self.subnodes {
            node.frame = context.initialFrame(for: node)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                node.frame = context.finalFrame(for: node)
            }, completion: { (finished) in
                context.completeTransition(finished)
            })
        }
    }
    
}












