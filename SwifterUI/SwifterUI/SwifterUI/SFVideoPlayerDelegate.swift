//
//  SFVideoPlayerDelegate.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public protocol SFVideoPlayerDelegate: class {
    
    // MARK: - Instance Methods
    
    func prepare(mediaController: UIViewController)
}

public extension SFVideoPlayerDelegate where Self: UIViewController {
    
    // MARK: - Instance Methods
    
    public func prepare(mediaController: UIViewController) {
        mediaController.didMove(toParentViewController: self)
        self.addChildViewController(mediaController)
    }
}
