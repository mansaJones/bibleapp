//
//  FloatingPointExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:45 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
// MARK: - Properties
public extension FloatingPoint {

    /// Absolute value of integer number.
    var abs: Self {
        return Swift.abs(self)
    }

    /// Check if integer is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// Check if integer is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// Ceil of number.
    var ceil: Self {
        return Foundation.ceil(self)
    }

    /// Radian value of degree input.
    var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }

    /// Floor of number.
    var floor: Self {
        return Foundation.floor(self)
    }

    /// Degree value of radian input.
    var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }

}

// MARK: - Methods
public extension FloatingPoint {

    /// Random number between two number.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random number between two numbers.
    static func random(between min: Self, and max: Self) -> Self {
        let aMin = Self.minimum(min, max)
        let aMax = Self.maximum(min, max)
        let delta = aMax - aMin
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + aMin
    }

    /// Random number in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random number in the given closed range.
    static func random(inRange range: ClosedRange<Self>) -> Self {
        let delta = range.upperBound - range.lowerBound
        return Self(arc4random()) / Self(UInt64(UINT32_MAX)) * delta + range.lowerBound
    }

}
