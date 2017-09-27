//
//  SFImageNodeController.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 23/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class SFImageZoomNodeController: SFViewController<SFImageZoomNode>, UIScrollViewDelegate {
    
    // MARK: - Initializers
        
    init(withImage image: UIImage, automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFImageZoomNode(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        SFNode.view.delegate = self
        SFNode.image = image
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        SFNode.layout(withSize: self.view.bounds.size)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        SFNode.updateConstraintsForSize(self.view.bounds.size)
        
        if SFNode.view.zoomScale > SFNode.view.minimumZoomScale {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.statusBarIsHidden = true
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.statusBarIsHidden = false
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return SFNode.imageView
    }
}










































