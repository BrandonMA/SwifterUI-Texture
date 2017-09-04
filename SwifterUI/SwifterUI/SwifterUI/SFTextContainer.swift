//
//  SFTextContainer.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public typealias TextAttributes = [String: Any]

public let SFTextAttributeName = "SFTextAttributeName"
public enum SFTextType: String {
    case button
    case text
}

public protocol SFTextContainer {
    
    // MARK: - Instance Properties
    
    // color: text color of your label
    var textColor: UIColor { get set }
    
    // font: font used for your label
    var font: UIFont { get set }
    
    // text: text that is going to be shown
    var text: String { get set }
    
    // attributedString: final string to be set
    var mutableAttributedText: NSMutableAttributedString { get }
    
    // aligment: Text aligment of your label
    var aligment: NSTextAlignment { get set }
    
    var extraAttributes: [String : TextAttributes] { get set }
    
    // setAttributedText: Set the attributes of your label node under the hood whenever you update one of it's three properties
    func setAttributedText()
    
    // addExtraAttributes: Add extraAttributes to attributedString
    func addExtraAttributes(to string: NSMutableAttributedString)
    
}

extension SFTextContainer {
    
    public var mutableAttributedText: NSMutableAttributedString {
        get {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = self.aligment
            let string = NSMutableAttributedString(string: self.text,
                                                              attributes: [
                                                                NSForegroundColorAttributeName: self.textColor,
                                                                NSFontAttributeName: self.font,
                                                                NSParagraphStyleAttributeName: paragraphStyle])
            addExtraAttributes(to: string)
            return string
        }
    }
    
    public func addExtraAttributes(to string: NSMutableAttributedString) {
        if self.extraAttributes.count != 0 {
            self.extraAttributes.forEach({ (attribute) in
                string.addAttributes(attribute.value, range: self.text.nsRange(of: attribute.key))
            })
        }
    }
    
}













