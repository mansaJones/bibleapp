//
//  UINavigationControllerExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:31 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import UIKit

// MARK: - Methods
public extension UINavigationController {

//    /// Pop ViewController with completion handler.
//    ///
//    /// - Parameter completion: optional completion handler (default is nil).
//    func popViewController(_ completion: (() -> Void)? = nil) {
//        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popViewController(animated: true)
//        CATransaction.commit()
//    }
//
//    /// Push ViewController with completion handler.
//    ///
//    /// - Parameters:
//    ///   - viewController: viewController to push.
//    ///   - completion: optional completion handler (default is nil).
//    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
//        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        pushViewController(viewController, animated: true)
//        CATransaction.commit()
//    }

    /// Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }

    func fetchMatchingVC(ofKind kind: AnyClass) -> UIViewController? {
        return self.viewControllers.first(where: {$0.isKind(of: kind)})
    }
}
