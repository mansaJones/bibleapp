//
//  CGFloatExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:21 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import UIKit
// MARK: - Properties
public extension CGFloat {

    /// Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(self)
    }

    /// Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }

    /// Radian value of degree input.
    var degreesToRadians: CGFloat {
        return CGFloat.pi * self / 180.0
    }

    /// Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }

    /// Check if CGFloat is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// Check if CGFloat is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// Int.
    var int: Int {
        return Int(self)
    }

    /// Float.
    var float: Float {
        return Float(self)
    }

    /// Double.
    var double: Double {
        return Double(self)
    }

    /// Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }

}

// MARK: - Methods
public extension CGFloat {

    /// Random CGFloat between two CGFloat values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random CGFloat between two CGFloat values.
    static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
        let delta = max - min
        return min + CGFloat(arc4random_uniform(UInt32(delta)))
    }

}
