//
//  SFImageGalleryController.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 06/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFMediaGalleryCell: SFCellNode {
    
    lazy var imageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFit
        return imageNode
    }()
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: UIScreen.main.bounds.width), height: ASDimension(unit: ASDimensionUnit.points, value: UIScreen.main.bounds.height))
        return ASCenterLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.start, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: imageNode)
    }
}

open class SFMediaGalleryNode: SFCollectionNode {
    
    lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle, collectionViewLayout: self.collectionLayout)
        view.isPagingEnabled = true
    }
}

open class SFMediaGalleryController: SFViewController<SFMediaGalleryNode>, ASCollectionDataSource {
    
    open var images: [UIImage?] = []
    open var urls: [URL?] = []
    private var startIndex = IndexPath(item: 0, section: 0)
    open var startItem = 0 {
        didSet {
            self.startIndex.item = startItem
        }
    }
    
    init(automaticallyAdjustsColorStyle: Bool, images: [UIImage?]) {
        self.images = images
        super.init(SFNode: SFMediaGalleryNode(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.SFNode.dataSource = self
    }
    
    convenience init(automaticallyAdjustsColorStyle: Bool, urls: [URL?]) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle, images: [])
        self.urls = urls
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return images.count > 0 ? images.count : urls.count
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let cell = SFMediaGalleryCell(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
            
            if self.images.count > 0 {
                cell.imageNode.image = self.images[indexPath.row]
            } else if self.urls.count > 0 {
                cell.imageNode.url = self.urls[indexPath.row]
            }
            
            return cell
        }
    }
    
}













