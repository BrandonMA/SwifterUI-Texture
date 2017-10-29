//
//  SFImageViewController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFImageGalleryController: SFPagerController {
    
    var images: [UIImage]
    
    init(with images: [UIImage]) {
        self.images = images
        super.init(automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return images.count
    }
    
    public override func pagerNode(_ pagerNode: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let image = self.images[index]
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            return SFImageViewerNodeController(withImage: image, automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        }, didLoad: nil)
        node.style.preferredSize = pagerNode.bounds.size
        return node
    }
    
}












