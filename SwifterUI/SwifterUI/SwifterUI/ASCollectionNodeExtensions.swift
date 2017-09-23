//
//  ASCollectionNodeExtensions.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 10/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public extension ASCollectionNode {
    
    public func scrollDown(section: Int) {
        if self.numberOfItems(inSection: section) > 0 {
            self.scrollToItem(at: IndexPath(item: numberOfItems(inSection: section) - 1, section: section), at: UICollectionViewScrollPosition.bottom, animated: true)
        }
    }
    
    public func insertLastItem(section: Int) {
        if self.numberOfItems(inSection: section) > 0 {
            self.insertItems(at: [IndexPath(item: self.numberOfItems(inSection: section), section: section)])
        } else {
            self.insertItems(at: [IndexPath(item: 0, section: section)])
        }
    }
}
