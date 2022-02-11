//
//  CATransitionExtesions.swift
//  StructureApp
//
//  Created by indianic on 13/12/18.
//  Copyright © 2018 IndiaNIC Infotech Ltd. All rights reserved.
//

import Foundation
import UIKit

public enum AnimationType: String {

    case oglFlip = "oglFlip"

    case pageCurl = "pageCurl"

    case pageUnCurl = "pageUnCurl"

    case fade = "fade"

    case cube = "cube"

    case moveIn = "moveIn"

    case push = "push"

    case reveal = "reveal"

    case rippleEffect = "rippleEffect"

    case suckEffect = "suckEffect"

    case cameraIris = "cameraIris"

}

public enum AnimationSubType: String {

    case fromLeft = "fromLeft"

    case fromRight = "fromRight"

    case fromTop = "fromTop"

    case fromBottom = "fromBottom"

}

extension CATransition {

    /// An object that provides an animated transition between a layer's states
    ///
    ///     let animation = CATransition.transition(type: .fade, subType: .fromLeft, duration: 1.0)
    ///     self.imageView.layer.add(animation, forKey: "animation")
    ///
    ///
    /// ## AnimationType ##
    ///  - .oglFlip
    ///  - .pageCurl
    ///  - .pageUnCurl
    ///  - .fade
    ///  - .cube
    ///  - .moveIn
    ///  - .push
    ///  - .reveal
    ///  - .rippleEffect
    ///  - .suckEffect
    ///  - .cameraIris
    ///
    /// ## AnimationSubType ##
    ///  - .fromLeft
    ///  - .fromRight
    ///  - .fromTop
    ///  - .fromBottom
    ///
    /// - Parameters:
    ///   - type: Type of animation which you want
    ///   - subType: SubType / Direction of the animation
    ///   - duration: Duraion of the animation. Default is 0.75
    /// - Returns: Returns the CATransition animation object which you can
    public class func transition(type: AnimationType, subType: AnimationSubType, duration: Double = 0.75) -> CATransition {

        // Initialize the transition
        let animation = CATransition()

        // Set transition properties
        animation.type = CATransitionType(rawValue: type.rawValue)
        animation.subtype = CATransitionSubtype(rawValue: subType.rawValue)
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        return animation

    }

}
