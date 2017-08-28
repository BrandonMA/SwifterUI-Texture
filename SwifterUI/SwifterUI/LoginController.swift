//
//  LoginController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class LoginController: SFLoginNodeController {
    
    init() {
        super.init(automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SFNode.logo = UIImage(named: "icon")
        self.SFNode.title = "ZipUp"
        self.SFNode.signInButton.gradient =  SFGradient(with: [UIColor(red: 255, green: 199, blue: 0).cgColor, UIColor(red: 255, green: 149, blue: 0).cgColor], direction: SFGradientDirection.vertical)
        self.signUpController = SignUpController()
    }
    
    override func signInButtonDidTouch() {
        self.SFNode.isLoading = true
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
        
        Dispatch.delay(by: 3.0, dispatchLevel: DispatchLevel.background) {
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                self.SFNode.isLoading = false
                self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
            })
        }
    }
}





















