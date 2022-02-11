//
//  UILabelExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:29 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import UIKit

// MARK: - Methods
public extension UILabel {

    /// Initialize a UILabel with text
    convenience init(text: String?) {
        self.init()
        self.text = text

    }

    /// Required height for a label
    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }

}

class GradientLabel: UILabel {
    var gradientColors: [CGColor] = []

    override func drawText(in rect: CGRect) {
//        self.font = R.font.magraBold(size: 25)
        if let gradientColor = drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }

    @IBInspectable
    public var fontSize: CGFloat = 20 {
        didSet {
            self.font = R.font.magraBold(size: fontSize)
        }
    }

    /// <#Description#>
    /// - Parameters:
    ///   - rect: <#rect description#>
    ///   - colors: <#colors description#>
    /// - Returns: <#description#>
    private func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }

        let context = UIGraphicsGetCurrentContext()

        // this will make vertical gradiant 
        context?.drawLinearGradient(gradient,
                                    start: CGPoint(x: 0, y: size.height),
                                    end: CGPoint.zero,
                                    options: [])

        // this will make horizontal gradiant
//        context?.drawLinearGradient(gradient,
//                                    start: CGPoint.zero,
//                                    end: CGPoint(x: size.width, y: 0),
//                                    options: [])
//
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}
