//
//  SFImageZoomNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 25/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFImageZoomNode: SFScrollNode {
    
    // MARK: - Instance Properties
    
    open var image: UIImage = UIImage()
    
    open lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    open var imageViewTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    open var imageViewRightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    open var imageViewBottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    open var imageViewLeftConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        automaticallyManagesContentSize = false
        self.view.showsHorizontalScrollIndicator = false
        self.view.showsVerticalScrollIndicator = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapZoom(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Instance Methods
    
    open func layout(withSize size: CGSize) {
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.deactivate([imageViewTopConstraint, imageViewRightConstraint, imageViewBottomConstraint, imageViewLeftConstraint])
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        imageViewRightConstraint = imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        imageViewLeftConstraint = imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        
        NSLayoutConstraint.activate([imageViewTopConstraint, imageViewRightConstraint, imageViewBottomConstraint, imageViewLeftConstraint])
        
        updateMinZoomScaleForSize(size)
        updateConstraintsForSize(size)
    }
    
    open func handleDoubleTapZoom(sender: UITapGestureRecognizer) {
        
        if self.view.zoomScale != self.view.minimumZoomScale {
            self.view.setZoomScale(self.view.minimumZoomScale, animated: true)
        } else {
            let location = sender.location(in: self.imageView)
            self.view.zoom(to: CGRect(x: location.x, y: location.y, width: self.imageView.bounds.width / 2, height: self.imageView.bounds.height / 2), animated: true)
        }
    }
    
    open func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / image.size.width
        let heightScale = size.height / image.size.height
        let minScale = min(widthScale, heightScale)
        self.view.minimumZoomScale = minScale
        self.view.zoomScale = minScale
    }
    
    open func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewRightConstraint.constant = xOffset
        imageViewLeftConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}
