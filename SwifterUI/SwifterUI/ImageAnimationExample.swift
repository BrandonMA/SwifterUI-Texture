//
//  ImageAnimationExample.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 23/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class ImageContainerNode: SFDisplayNode {
    
    lazy var photoImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFit
        return imageNode
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        photoImageNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 200), height: ASDimension(unit: ASDimensionUnit.points, value: 200))
        return ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: photoImageNode)
    }
}

class ImageController: SFViewController<ImageContainerNode> {
    
    init() {
        super.init(SFNode: ImageContainerNode(), automaticallyAdjustsColorStyle: true)
        SFNode.photoImageNode.image = UIImage(named: "image")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
