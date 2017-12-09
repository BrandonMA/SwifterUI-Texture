//
//  SFImageViewController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFImageGalleryController: SFPagerController {
    
    // MARK: - Instance Properties
    
    open var images: [UIImage]
    
    // MARK: - Initializers
    
    public init(with images: [UIImage]) {
        self.images = images
        super.init(automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let selected = self.SFNode.currentPageIndex
        for i in 0...images.count {
            guard let controller = self.SFNode.nodeForPage(at: i).viewController as? SFImageViewerNodeController else { return }
            coordinator.animate(alongsideTransition: { (context) in
                controller.SFNode.layout(withSize: size)
                self.SFNode.scrollToPage(at: selected, animated: false)
            }, completion: nil)
        }
    }
    
    open override func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return images.count
    }
    
    open override func pagerNode(_ pagerNode: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let image = self.images[index]
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            return SFImageViewerNodeController(with: image, automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        }, didLoad: nil)
        node.style.preferredSize = pagerNode.bounds.size
        return node
    }
    
    
    
}













