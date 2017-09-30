//
//  Message.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 10/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public enum SFMessageSenderType {
    case me
    case someone
}

public struct SFMessage {
    public var image: UIImage? = nil
    public var text: String? = nil
    public var sender: SFMessageSenderType = .me
    
    public init(image: UIImage?, text: String?, sender: SFMessageSenderType = .me) {
        self.image = image
        self.text = text
        self.sender = sender
    }
}
