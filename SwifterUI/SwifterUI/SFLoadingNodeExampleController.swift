//
//  SFLoadingNodeExampleController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 10/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SFLoadingNodeExampleController: SFViewController<SFLoadingNodeExample> {
    
    init() {
        super.init(SFNode: SFLoadingNodeExample(), automaticallyAdjustsColorStyle: true)
        
        SFNode.buttonNode.addTarget(self, action: #selector(backgroundNodeDidTap), forControlEvents: ASControlNodeEvent.touchUpInside)
        
    }
    
    @objc func backgroundNodeDidTap() {
        self.SFNode.isLoading = true
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        
        Dispatch.delay(by: 3.0, dispatchLevel: DispatchLevel.background) {
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                self.SFNode.isLoading = false
                self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
            })
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SFLoadingNodeExample: SFDisplayNode {
    
    lazy var buttonNode: SFButtonNode = {
        let node = SFButtonNode()
        node.text = LocalizedString.shared.getStart()
        node.font = UIFont.systemFont(ofSize: 24)
        return node
    }()
    
    lazy var searchBar: SFSearchBar = {
        let searchbar = SFSearchBar()
        return searchbar
    }()
    
    lazy var textField: SFTextField = {
        let textField = SFTextField()
        textField.aligment = .left
        textField.leftPadding = 12
        textField.placeholder = "placeholder"
        return textField
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let layout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [searchBar, textField, getStackSeparator(),buttonNode, getStackSeparator()])
        
        return addLoadingNode(to: ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), child: layout))
    }
    
}













