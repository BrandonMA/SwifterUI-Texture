//
//  SFImageNodeController.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 23/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFImageViewerNodeController: SFViewController<SFImageViewerNode>, UIScrollViewDelegate {
    
    // MARK: - Initializers
        
    public init(with image: UIImage, automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFImageViewerNode(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        SFNode.view.delegate = self
        SFNode.image = image
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        SFNode.layout(withSize: self.view.bounds.size)
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.SFNode.layout(withSize: size)
    }
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        SFNode.updateConstraintsForSize(self.view.bounds.size)
        
        if SFNode.view.zoomScale > SFNode.view.minimumZoomScale {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.statusBarIsHidden = true
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.statusBarIsHidden = false
        }
    }
    
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return SFNode.imageView
    }
}










































