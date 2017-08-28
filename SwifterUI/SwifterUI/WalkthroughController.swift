//
//  WalkthroughController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class WalkthroughController<ASMiddleNode>: SFViewController<WalkthroughNode<ASMiddleNode>> where ASMiddleNode: ASDisplayNode {
    
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
    
    init(with node: WalkthroughNode<ASMiddleNode>) {
        super.init(SFNode: node, automaticallyAdjustsColorStyle: false)
        node.backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.SFNode.bottomButton.addTarget(self, action: #selector(bottomButtonDidTouch), forControlEvents: .touchUpInside)
    }
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.done, target: self, action: #selector(skipButtonDidTouch))
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: SFNode.deviceType == .iphone ? 30 : 34)
            ]
        }
    }
    
    @objc func skipButtonDidTouch() {
        showHome()
    }
    
    @objc func bottomButtonDidTouch() {
        
    }
    
 func showHome() {
        let controller = UINavigationController(rootViewController: HomeController())
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
}

























