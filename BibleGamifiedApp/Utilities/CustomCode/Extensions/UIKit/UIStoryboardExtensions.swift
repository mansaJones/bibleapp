//
//  UIStoryboardExtensions.swift
//  StructureApp
//
//  Created by indianic on 11/12/18.
//  Copyright © 2018 IndiaNIC Infotech Ltd. All rights reserved.
//

// HOW TO USE:
//
// let objVC = Storyboard.Home.instantiate(viewController: ViewController.self)

import UIKit

enum Storyboard: String {

    case Main, Home

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    @discardableResult
    func instantiate<T: UIViewController>(viewController: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {

        let storyboardID = (viewController as UIViewController.Type).storyboardID

        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile: \(file) \nLine Number: \(line) \nFunction: \(function)")
        }

        return scene
    }

    func initialViewController() -> UIViewController? {

        return instance.instantiateInitialViewController()
    }

}

extension UIViewController {

    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromStoryboard: Storyboard) -> Self {
        return fromStoryboard.instantiate(viewController: self)
    }

}
