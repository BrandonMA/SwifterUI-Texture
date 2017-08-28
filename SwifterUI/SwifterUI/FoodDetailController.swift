//
//  FoodDetailController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoodDetailController: SFViewController<FoodDetailNode>, ASCollectionDataSource {
    
    init() {
        super.init(SFNode: FoodDetailNode() , automaticallyAdjustsColorStyle: false)
        self.SFNode.collectionNode.dataSource = self
        self.SFNode.closeButton.addTarget(self, action: #selector(closeButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func closeButtonDidTouch() {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block: () -> ASCellNode = {
            let cell = FoodDetailCell()
            cell.titleNode.font =  UIFont.boldSystemFont(ofSize: 17)
            cell.cornerRadius = 8
            return cell
        }
        
        return block
    }
    
}
