//
//  UIViewControllerExtensions.swift
//  StructureApp
// 
//  Created By: Kushal Panchal, IndiaNIC Infotech Ltd
//  Created on: 23/01/18 3:36 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import UIKit

public extension UIViewController {

    /// This property will set the Image to Navigation Bar
    var navigationBarImage: UIImage? {
        get {
            return (navigationItem.titleView as? UIImageView)?.image
        } set {
            if newValue != nil {
                let imageView = UIImageView(image: newValue)
                imageView.contentMode = .scaleAspectFit
                navigationItem.titleView = imageView
            } else {
                navigationItem.titleView = nil
            }
        }
    }

    /// This method will set the Custom Back Button in the Navigation Bar
    ///
    ///        setCustomBackButton()
    ///
    func setCustomBackButton() {

        navigationItem.hidesBackButton = true

        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        button.contentHorizontalAlignment = .left
        button.setImage(R.image.ic_back_green(), for: .normal)
        button.addTarget(self, action: #selector(btnBackClick(_:)), for: .touchUpInside)

        let btnBarButton: UIBarButtonItem = UIBarButtonItem(customView: button)
        btnBarButton.setBadge(text: "99")
        //        btnBarButton.removeBadge()

        navigationItem.leftBarButtonItems = [btnBarButton]

    }

    /// This is the action method for the Back Button from the navigation bar
    ///
    /// override this method for your custom action handler.
    ///
    /// - Parameter sender: object of the navigation bar button
    @objc func btnBackClick(_ sender: UIButton) {
        print("Extension Back Button CLick action")
    }

    /// This method will set the Custom Back Button in the Navigation Bar
    ///
    ///        setBarDeleteButton()
    ///
    func setBarDeleteButton() {

        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        button.contentHorizontalAlignment = .right
        button.setImage(#imageLiteral(resourceName: "ic_delete"), for: .normal)
        button.addTarget(self, action: #selector(btnBarDeleteClick(_:)), for: .touchUpInside)

        let btnBarButton: UIBarButtonItem = UIBarButtonItem(customView: button)

        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = -8

        navigationItem.rightBarButtonItems = [space, btnBarButton]

    }

    /// This is the action method for the Back Button from the navigation bar
    ///
    /// override this method for your custom action handler.
    ///
    /// - Parameter sender: object of the navigation bar button
    @objc func btnBarDeleteClick(_ sender: UIButton) {
        print("Extension Delete Button Click action")
    }

    /// This property will set the nagivation bar hidden and show.
    ///
    ///        hideNavigationBar = true
    ///
    var hideNavigationBar: Bool {
        get {
            return self.navigationController?.isNavigationBarHidden ?? false
        } set {
            self.navigationController?.isNavigationBarHidden = newValue
        }
    }

    /// This property will use to check if Force Touch is available or not.
    ///
    ///        if isForceTouchAvailable { // Do your code here }
    ///
    var isForceTouchAvailable: Bool {
        return (traitCollection.forceTouchCapability == .available)
    }

    /// This property will used to enable and disable Inreractive Pop Gesture.
    ///
    ///        enableInreractivePopGesture = false
    ///
    var enableInreractivePopGesture: Bool {
        get {
            return navigationController?.interactivePopGestureRecognizer?.isEnabled ?? false
        } set {
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
            navigationController?.interactivePopGestureRecognizer?.isEnabled = newValue
        }
    }

    /// Gesture Delegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    /// push controller
    /// - Parameter controller: UIViewController
    func pushVC(controller: UIViewController, animated: Bool = true) {
        //        self.navigationController?.pushViewController(controller, animated: animated)

        self.navigationController?.pushViewController(controller, animated: true)
        UIView.transition(from: self.view, to: controller.view, duration: 0.85, options: [.transitionFlipFromLeft])
    }

    /// push controller
    /// - Parameter controller: UIViewController
    func presentVC(controller: UIViewController, presentStyle: UIModalPresentationStyle = .overCurrentContext) {
        let navigationController = HomeNavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = presentStyle
        self.present(navigationController, animated: true, completion: nil)

    }

    /// pop to MainDashboardVC view contrller
    /// - Parameter controller: UIViewController
    func poptoDashboard() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MainDashboardVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    /// pop to Login view contrller
    /// - Parameter controller: UIViewController
    func poptoLoginScreen() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    /// dimiss controller
    /// - Parameter controller: UIViewController
    func poptoDismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    /// pop controller
    /// - Parameter controller: UIViewController
    func poptoVC() {
        self.navigationController?.popViewController(animated: true)
    }

    /// pop to game uncloked VC
    func poptoGameUnlockVC() {

        for vc in self.navigationController!.viewControllers where vc is UnlockStageVC {
            let aVC = vc as? UnlockStageVC

            // API call after create new Video
            aVC?.getGameLevelAPI()
            self.navigationController!.popToViewController(vc, animated: true)
            break
        }
    }

    func setTransperantNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor: UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}

private var handle: UInt8 = 0

extension UIBarButtonItem {

    private var badgeLayer: CAShapeLayer? {
        if let badge: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return badge as? CAShapeLayer
        } else {
            return nil
        }
    }

    func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11) {
        badgeLayer?.removeFromSuperlayer()

        if let text = text, text.isEmpty {
            return
        }

        addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
    }

    private func addBadge(text: String, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11) {
        guard let view = self.value(forKey: "view") as? UIView else { return }

        var font = UIFont.systemFont(ofSize: fontSize)

        if #available(iOS 9.0, *) {
            font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
        }

        let badgeSize = text.size(withAttributes: [NSAttributedString.Key.font: font])

        // Initialize Badge
        let badge = CAShapeLayer()

        let height = badgeSize.height
        var width = badgeSize.width + 6 /* padding */

        // make sure we have at least a circle
        if width < height {
            width = height
        }

        // x position is offset from right-hand side
        let xPos = view.frame.width - width + offset.x

        let badgeFrame = CGRect(origin: CGPoint(x: xPos, y: offset.y), size: CGSize(width: width, height: height))

        badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
        view.layer.addSublayer(badge)

        // Initialiaze Badge's label
        let label = CATextLayer()
        label.frame = badgeFrame
        label.string = text
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.font = font
        label.fontSize = font.pointSize

        label.foregroundColor = filled ? UIColor.white.cgColor: color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)

        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }

}
