//
//  FloatExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:45 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import CoreGraphics

// MARK: - Properties
public extension Float {

    /// Int.
    var int: Int {
        return Int(self)
    }

    /// Double.
    var double: Double {
        return Double(self)
    }

    /// CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }

}
