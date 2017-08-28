//
//  CircleButton.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class CircleButton: ASButtonNode {
    override func layout() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 14)
        self.layer.shadowRadius = 23
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.cornerRadius = self.frame.width / 2
    }
}
