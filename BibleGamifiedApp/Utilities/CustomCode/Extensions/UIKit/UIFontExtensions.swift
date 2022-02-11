//
//  UIFontExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:26 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import UIKit

extension UIFont {

    /// Enum for App Fonts
    public enum FontType {
        /// light
        case light
        /// regular
        case regular
        /// semiBold
        case semiBold
        /// bold
        case bold

        var name: String {
            switch self {
            case .light:
                return "Magra-Bold"
            case .regular:
                return "Magra-Bold"
            case .semiBold:
                return "Magra-Bold"
            case .bold:
                return "Magra-Bold"
            }
        }

    }

    /// Enum for App Font sizes
    public enum FontSize {
        /// header
        case header
        /// largeTitle
        case largeTitle
        /// title
        case title
        /// subtitle
        case subtitle
        /// secondarySubtitle
        case secondarySubtitle

        var size: CGFloat {
            switch self {
            case .header:
                return 17.0
            case .largeTitle:
                return 20.0
            case .title:
                return 15.0
            case .subtitle:
                return 12.0
            case .secondarySubtitle:
                return 11.0
            }
        }

    }

    /// This will return the scalled font as per the native iOS setting. Please note that this will work with your custom font as well. :)
    ///
    ///     UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.heavy).scaled
    var scaled: UIFont {
        return UIFontMetrics.default.scaledFont(for: self)
    }

    /// Use this method to get the type of font you want
    ///
    /// ## Available Font Type ##
    ///  - .light
    ///  - .regular
    ///  - .semiBold
    ///  - .bold
    ///
    /// ## Usage Example: ##
    /// ````
    /// UIFont(type: .light, size: 14.0)
    /// ````
    ///
    /// - Parameters:
    ///   - type: Pre Define Font Type which you need to pass. The default value will be the .regular
    ///   - size: Size of the Font
    public convenience init(type: FontType = .regular, size: CGFloat) {
        self.init(name: type.name, size: size)!
    }

    /// Use this method to get the type of font you want
    ///
    /// ## Available Font Type ##
    ///  - .light
    ///  - .regular
    ///  - .semiBold
    ///  - .bold
    ///
    /// ## Usage Example: ##
    /// ````
    /// UIFont(type: .light, size: .header)
    /// ````
    ///
    /// - Parameters:
    ///   - type: Pre Define Font Type which you need to pass. The default value will be the .regular
    ///   - size: Size of the Font. You can select the size from the pre define enum.
    public convenience init(type: FontType = .regular, size: FontSize) {
        self.init(name: type.name, size: size.size)!
    }

}
