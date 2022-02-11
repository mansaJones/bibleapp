//
//  Utility.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:06 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  
import AVFoundation
import Foundation
import UIKit
import JGProgressHUD

/// Utility class for application
public struct Utility {

    static var shared = Utility()
    var arrAllGames = [AllGames.dragDrop, AllGames.cardMatch]
    var totalGameDuration: Float =  25
    var intGameLife = 3
    var player: AVAudioPlayer?
    var hud = JGProgressHUD()

    /// App's name (if applicable).
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }

    /// This will return a App Vendor UUID
    public static var appVendorUUID: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }

    /// App's bundle ID (if applicable).
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    /// StatusBar height
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    /// App current build number (if applicable).
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }

    /// App's current version (if applicable).
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// Current battery level.
    public static var batteryLevel: Float {
        return CURRENTDEVICE.batteryLevel
    }

    /// Screen height.
    public static var screenHeight: CGFloat {
#if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.height
#elseif os(watchOS)
        return CURRENT_DEVICE.screenBounds.height
#endif
    }

    /// Screen width.
    public static var screenWidth: CGFloat {
#if os(iOS) || os(tvOS)
        return UIScreen.main.bounds.width
#elseif os(watchOS)
        return CURRENT_DEVICE.screenBounds.width
#endif
    }

    /// Current orientation of device.
    public static var deviceOrientation: UIDeviceOrientation {
        return CURRENTDEVICE.orientation
    }

    /// Check if app is running in debug mode.
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
#if DEBUG
        return true
#else
        return false
#endif
    }

    /// Check if multitasking is supported in current device.
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }

    /// Current status bar network activity indicator state.
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }

    /// Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }

    /// Check if application is running on simulator (read-only).
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }

    /// Key window (read only, if applicable).
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }

    ///  Most top view controller (if applicable).
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }

    /// This method will return a Top Most View Controller (currectly visible) of the application's window which you can use.
    ///
    /// - Returns: Object of the UIViewController
    public func topMostController() -> UIViewController? {

        //        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        //        while (topController.presentedViewController != nil) {
        //            topController = topController.presentedViewController!
        //        }
        //        return topController

        var from = UIApplication.shared.keyWindow?.rootViewController
        while from != nil {
            if let to = (from as? UITabBarController)?.selectedViewController {
                from = to
            } else if let to = (from as? UINavigationController)?.visibleViewController {
                from = to
            } else if let to = from?.presentedViewController {
                from = to
            } else {
                break
            }
        }
        return from

    }

    /// Class name of object as string.
    ///
    /// - Parameter object: Any object to find its class name.
    /// - Returns: Class name for given object.
    static func typeName(for object: Any) -> String {
        let objectType = type(of: object.self)
        return String.init(describing: objectType)
    }

    /// Called when user takes a screenshot
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { notification in
            action(notification)
        }
    }

    /// This method will generate the notification feedback
    ///
    /// - Parameter notificationType: type of feedback you want. - error , warning , success
    static func notificationFeedbackGenerator(_ notificationType: UINotificationFeedbackGenerator.FeedbackType = .error) {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(notificationType)
    }

    /// This method will generate the notification feedback
    ///
    /// - Parameter notificationType: type of feedback you want.
    static func impactFeedbackGenerator(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .heavy) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.impactOccurred()
    }

    /// This method will generate the notification feedback
    ///
    static func selectionFeedbackGenerator() {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
    }

    /// This method will calculate the new height for the image based on the current image size.
    ///
    /// - Parameters:
    ///   - currentImageSize: Current size of the image
    ///   - displayWidth: Width in which you want to show the image.
    /// - Returns: new height based on the given Width.
    func getImageDisplayHeight(_ currentImageSize: CGSize, displayWidth: CGFloat) -> CGFloat {

        // Calculate the Ratio for the current Image.
        let ratioFactor = currentImageSize.width / currentImageSize.height

        // Calculate the New height for the image based on the Display Width and the Ratio Factor and return the new Height.
        return (displayWidth / ratioFactor)

    }

    /// Dispatch Queue delay with compltion handler
    /// - Parameters:
    ///   - delay: delay time
    ///   - closure: compltion call back
    static func delay(_ delay: Double, closure:@escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

    /// Setup Collection with 2 collum
    /// - Parameters:
    ///   - collection: UIcollectionview
    ///   - cellHeight: Collection cell height
    static func setupCollectionUi(collection: UICollectionView, cellHeight: CGFloat) {
        let fllowLayout = UICollectionViewFlowLayout()
        fllowLayout.itemSize = CGSize(width: (Constant.DEVICE_SCREEN_WIDTH/2.2)-50, height: (Constant.DEVICE_SCREEN_WIDTH/2.2)-50)
        fllowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        fllowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        fllowLayout.minimumInteritemSpacing = 0.0
        collection.collectionViewLayout = fllowLayout

    }

    /// This method will set root menu video controller
    ///
    /// - Parameters:
    ///   - isFromNotification: set coming from notification

    static func setRootScreen(isAnimation: Bool = false, isShowGameUnlock: Bool = false) {

        if let controller = R.storyboard.dashboard.mainDashboardVC(), let loginVC =  R.storyboard.main.loginVC() {
            let navigationController = HomeNavigationController(rootViewController: UDSettings.isUserLogin ? controller: loginVC)
            controller.isShow = isShowGameUnlock
            if  isAnimation {
                UIView.transition(with: KEY_WINDOW!,
                                  duration: 0.5, options: .transitionFlipFromLeft,
                                  animations: {
                    KEY_WINDOW?.rootViewController = navigationController
                    KEY_WINDOW?.makeKeyAndVisible()

                }, completion: { _ in

                })
            } else {
                KEY_WINDOW?.rootViewController = navigationController
                KEY_WINDOW?.makeKeyAndVisible()
            }
        }
    }

    static func showSimpleHUD() {

        if let aView = Utility.shared.topMostController()?.view {
            Utility.shared.hud.vibrancyEnabled = true
            //            Utility.shared.hud.textLabel.text = "Simple example in Swift"
            Utility.shared.hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
            Utility.shared.hud.show(in: aView)
        }
    }

    static func dismissHUD() {
        Utility.shared.hud.dismiss(afterDelay: 1)
    }

}

extension Utility {

    mutating func initSoundToPlay() {
        guard let url = R.file.background_sound_1Mp3() else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = -1

            self.playSound()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    func playSound() {
        guard let player = player else { return }
        if !player.isPlaying {
            player.play()
            UDSettings.isSoundPlaying = true
        }
    }
    func pauseSound() {
        guard let player = player else { return }
        if player.isPlaying {
            player.pause()
            UDSettings.isSoundPlaying = false
        }
    }

    static func showGames(randomElement: AllGames, VC: UIViewController, objGameLevel: GamesDataModel) {
        switch randomElement {
        case .dragDrop:
            if let resultVC = R.storyboard.game.dragDropGameVC() {
                resultVC.objGamesDataModel = objGameLevel
                VC.pushVC(controller: resultVC)
            }

        case .cardMatch:
            if let resultVC = R.storyboard.game.cardMatchingVC() {
                resultVC.objGamesDataModel = objGameLevel
                VC.pushVC(controller: resultVC)
            }
        }
    }
}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
