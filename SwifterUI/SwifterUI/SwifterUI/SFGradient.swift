//
//  SFGradient.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 22/04/17.
//  Copyright © 2017 brandon maldonado alonso. All rights reserved.
//

import UIKit

public struct SFGradient {
    
    // MARK: - Instance Properties
    
    public var colors: [CGColor]
    public var direction: SFGradientDirection
    public var inverted: Bool = false {
        didSet {
            var newColors: [CGColor] = []
            self.colors.forEach { (color) in
                newColors.insert(color, at: 0)
            }
            self.colors = newColors
        }
    }
    
    // MARK: - Initializers
    
    // init: initialize a SFGradient with multiple colors and a direction
    // - Parameters:
    //   colors: colors for your gradient
    //   direction: indicates the direction of a gradient, vertical or horizontal
    public init(with colors: [CGColor], direction: SFGradientDirection) {
        self.colors = colors
        self.direction = direction
    }
    
    // MARK: - Instance Methods
    
    // getGradientLayer: return a CAGradientLayer with the previously specified colors and direction
    // - Parameters:
    //   width: horizontal lenght of your layer
    //   height: vertical lenght of your layer
    public func getGradientLayer(width: CGFloat, height: CGFloat) -> CAGradientLayer {
        // Create gradient
        let gradientLayer = CAGradientLayer() // Create a CAGradientLayer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height) // Set layer size because it a layer doesn't change it's size dynamically
        gradientLayer.colors = self.colors // Add all colors
        gradientLayer.startPoint = direction.getStartPoint() // Set the startpoint of your gradient
        gradientLayer.endPoint = direction.getEndPoint() // Set the endpoint of your gradient
        return gradientLayer
    }
    
    // getGradientImage: return an UIImage with the previously specified colors and direction
    // - Parameters:
    //   width: horizontal lenght of your layer
    //   height: vertical lenght of your layer
    public func getGradientImage(width: CGFloat, height: CGFloat) -> UIImage? {
        // Render the gradient to UIImage
        let layer: CAGradientLayer = self.getGradientLayer(width: width, height: height) // Call getGradientLayer to generate a CAGradientLayer with the corresponding size
        UIGraphicsBeginImageContext(layer.bounds.size) // Initialize a UIGraphicsContext with the layer size
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context) // Render the layer as an Image
        let image = UIGraphicsGetImageFromCurrentImageContext() // Transforms the Image context to a UIImage
        UIGraphicsEndImageContext() // Stop UIGraphicsContext
        return image
    }
    
    // getGradientImage: return an UIImage with the previously specified colors and direction asynchronously
    // - Parameters:
    //   width: horizontal lenght of your layer
    //   height: vertical lenght of your layer
    //   handler: return the async generated image
    public func getGradientImage(width: CGFloat, height: CGFloat, handler: @escaping (UIImage?) -> ()) {
        Dispatch.addAsyncTask(to: .background) { 
            handler(self.getGradientImage(width: width, height: height)) // Calls getGradientImage on the background so it doesn't affect UI performance
        }
    }
}



















