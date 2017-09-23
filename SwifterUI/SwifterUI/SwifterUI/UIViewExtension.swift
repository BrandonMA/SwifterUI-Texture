//
//  UIViewExtension.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 20/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func addShadow(color: UIColor, offSet: CGSize, radius: CGFloat, opacity: Float, path: CGPath? = nil) {
        
        var finalPath: CGPath
        if path == nil {
            finalPath = UIBezierPath(rect: self.bounds).cgPath
        } else {
            finalPath = path!
        }
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = finalPath
    }
    
}
