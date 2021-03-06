//
//  SFColorStyle.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

// This enum defines the different color styles providede by SwifterUI and some convenience methods to get colors
public enum SFColorStyle: Int {
    
    case light
    case dark
    
    // MARK: - Instance Methods
    
    // getNavigationBarStyle: return the corresponding UIBarStyle
    public func getNavigationBarStyle() -> UIBarStyle {
        switch self {
        case .light: return .default
        case .dark: return .black
        }
    }
    
    // getBackgroundColor: return the corresponding color for a background layer
    public func getBackgroundColor() -> UIColor {
        switch self {
        case .light: return SFAssets.white
        case .dark: return SFAssets.black
        }
    }
    
    // getAlternativeBackgroundColor: return an alternative background color for things like FluidTableNode where a FluidCellNode is white
    public func getAlternativeBackgroundColor() -> UIColor {
        switch self {
        case .light: return SFAssets.white
        case .dark: return SFAssets.alternativeBlack
        }
    }
    
    // getAlternativeBackgroundColor: return an alternative background color for things like FluidTableNode where a FluidCellNode is white
    public func getAlternativeMainColors() -> UIColor {
        switch self {
        case .light: return SFAssets.alternativeWhite
        case .dark: return SFAssets.alternativeBlack
        }
    }
    
    // getMainColor: return the corresponding color for a title or important text, it is used in FluidTextNode
    public func getMainColor() -> UIColor {
        switch self {
        case .light: return SFAssets.black
        case .dark: return SFAssets.white
        }
    }
    
    // getPlaceholderColor: return the corresponding color for a placeholder or not so important text, it is used in FluidDetailTextNode
    public func getPlaceholderColor() -> UIColor {
        switch self {
        case .light: return SFAssets.lightGray
        case .dark: return SFAssets.gray
        }
    }
    
    // getSeparatorColor: return the corresponding color for FluidTableNode's separator
    public func getSeparatorColor() -> UIColor {
        switch self {
        case .light: return SFAssets.whiteContrast
        case .dark: return SFAssets.blackContrast
        }
    }
    
    // getInteractiveTextColor: return the corresponding color for an interactive text, this is usually used for links or things like that
    public func getInteractiveColor() -> UIColor {
        switch self {
        case .light: return SFAssets.blue
        case .dark: return SFAssets.orange
        }
    }
    
    // getCorrectEffect: return the corresponding UIBlurEffect
    public func getCorrectEffect() -> UIBlurEffect {
        switch self {
        case .light: return UIBlurEffect(style: .light)
        case .dark: return UIBlurEffect(style: .dark)
        }
    }
    
    // getActivityIndicatorStyle: return the corresponding UIActivityIndicatorViewStyle for a FluidActivityIndicator
    public func getActivityIndicatorStyle() -> UIActivityIndicatorViewStyle {
        switch self {
        case .light: return .gray
        case .dark: return .white
        }
    }
    
    // getStatusBarStyle: return the corresponding UIStatusBarStyle
    public func getStatusBarStyle() -> UIStatusBarStyle {
        switch self {
        case .light: return .default
        case .dark: return .lightContent
        }
    }
    
    // getSearchBarStyle: return the corresponding style for a searchBar
    public func getSearchBarStyle() -> UIBarStyle {
        switch self {
        case .light: return .default
        case .dark: return .blackTranslucent
        }
    }
    
    // getKeyboardAppearence: return the corresponding keyboard appearence
    public func getKeyboardAppearence() -> UIKeyboardAppearance {
        switch self {
        case .light: return .default
        case .dark: return .dark
        }
    }
    
    // getSearchBarColor: return the corresponding searchbar color
    public func getTextFieldColor() -> UIColor {
        switch self {
        case .light: return SFAssets.whiteTextField
        case .dark: return SFAssets.alternativeBlack
        }
    }
    
    public func getTextFieldAlternativeColor() -> UIColor {
        switch self {
        case .light: return SFAssets.whiteTextField
        case .dark: return SFAssets.black
        }
    }
    
    // getSearchImage: return a search icon with the correct color
    public func getSearchImage() -> UIImage {
        switch self {
        case .light: return SFAssets.imageOfSearch
        case .dark: return SFAssets.imageOfSearch.tint(color: SFAssets.white, alpha: 1.0) ?? SFAssets.imageOfSearch
        }
    }
    
    // getDetailColor: return the correct color for a label that should not get to much attention from the user
    public func getDetailColor() -> UIColor {
        switch self {
        case .light: return SFAssets.black
        case .dark: return SFAssets.white
        }
    }
    
    public func getScrollIndicatorStyle() -> UIScrollViewIndicatorStyle {
        switch self {
        case .light: return .black
        case .dark: return .white
        }
    }
    
    // getSliderColor: return the correct color for a SFSlider
    public func getSliderColor() -> UIColor {
        switch self {
        case .light: return SFAssets.lightGray
        case .dark: return SFAssets.white
        }
    }
}





















