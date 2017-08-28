//
//  HomeController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class HomeController: SFViewController<HomeNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block: () -> ASCellNode = {
            let cell = HomeCell()
            cell.imageNode.image =  UIImage(named: "breakfast")
            cell.titleNode.text = "Full English Breakfast"
            cell.subtitleNode.text = "Full English Breakfast"
            return cell
        }
        return block
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let controller = FoodDetailController()
        present(controller, animated: true, completion: nil)
    }
    
    open var titleHeader: String = "" {
        didSet {
            if #available(iOS 11.0, *) {
                self.navigationItem.title = self.titleHeader
            }
        }
    }
    
    public override var shouldAutorotate: Bool {
        return false
    }
    
    init() {
        super.init(SFNode: HomeNode(), automaticallyAdjustsColorStyle: false)
        SFNode.backgroundColor = UIColor.white
        self.SFNode.collectionNode.dataSource = self
        self.SFNode.collectionNode.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleHeader = "Next Meal: Breakfast"
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shop"), style: UIBarButtonItemStyle.done, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItemStyle.done, target: self, action: nil)
        
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: SFNode.deviceType == .iphone ? 30 : 34)
            ]
        }
    }
}
