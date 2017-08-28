//
//  SignUpController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class SignUpController: SFSignUpNodeController {
    
    init() {
        super.init(automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.SFNode.signUpButton.gradient =  SFGradient(with: [UIColor(red: 255, green: 199, blue: 0).cgColor, UIColor(red: 255, green: 149, blue: 0).cgColor], direction: SFGradientDirection.vertical)
    }
    
    override func signUpButtonDidTouch() {
        let controller = UINavigationController(rootViewController: WelcomeController())
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
}
