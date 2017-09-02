//
//  SFTextContainer.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public protocol SFTextContainer {
    
    // MARK: - Instance Properties
    
    // color: text color of your label
    var textColor: UIColor { get set }
    
    // font: font used for your label
    var font: UIFont { get set }
    
    // text: text that is going to be shown
    var text: String { get set }
    
    // aligment: Text aligment of your label
    var aligment: NSTextAlignment { get set }
    
    // setAttributedText: Set the attributes of your label node under the hood whenever you update one of it's three properties
    func setAttributedText()
    
}














