//
//  AppDelegate.swift
//  BibleGamifiedApp
//
//  Created by indianic on 12/11/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import FBSDKCoreKit
import Firebase
import FirebaseDynamicLinks
import SwiftyStoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var signInConfig: GIDConfiguration?
    var homeNavigationVC: HomeNavigationController?
    let customURLScheme = "refercode"

    /// set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.all

    /// app didfinish lunching 
    /// - Parameters:
    ///   - application: <#application description#>
    ///   - launchOptions: <#launchOptions description#>
    /// - Returns: <#description#>
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Google signing clientid & Google map api key
        signInConfig = GIDConfiguration.init(clientID: APIKey.googleAPI.clientID)

        setupIQKeyboardManager()

        self.handelAutologin()

        // Facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        // SwiftyStoreKit inapp purhcase setup
        self.handleInAppPurhcase()

        FirebaseOptions.defaultOptions()?.deepLinkURLScheme = customURLScheme
        FirebaseApp.configure()

        setupIAP()

        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {

        // Handle If it is facebook URL
        if ApplicationDelegate.shared.application(app,
                                                  open: url,
                                                  sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                  annotation: options[UIApplication.OpenURLOptionsKey.annotation]) {
            return true
        }

        return false

    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        // Handle Facebook URL
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            self.handleIncomingDynamicLink(dynamicLink)
        } else if ApplicationDelegate.shared.application(application,
                                                         open: url,
                                                         sourceApplication: sourceApplication,
                                                         annotation: annotation) {
            return true
        }
        return false

    }

    /// handleIncomingDynamicLink: Call this method to manage dynamic link
    /// - Parameter dynamicLink: dynamicLink
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink) {

        guard let url = dynamicLink.url else {
            //            print("dynamic link object has not url")
            return
        }
        guard let componets: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = componets.queryItems else { return }

        if let accessToken = UDSettings.accessToken, !accessToken.isEmpty, UDSettings.isUserLogin == true {
            if let indexID = queryItems.firstIndex(where: { $0.name == "eventID" }), indexID < queryItems.count {
                if let strEventID = queryItems[indexID].value, !strEventID.isBlank {
//                    self.goToEventDetail(strEventID: strEventID)
                }
            }
        }
    }

    // MARK: - IQKeyboardManager: Keyboard Manager
    /// setupIQKeyboardManager: Call this method to set IQKeyboard
    func setupIQKeyboardManager() {

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = R.color.a4C1A00()

    }

    func setupIAP() {

        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in

            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    let downloads = purchase.transaction.downloads
                    if !downloads.isEmpty {
                        SwiftyStoreKit.start(downloads)
                    } else if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    print("\(purchase.transaction.transactionState.debugDescription): \(purchase.productId)")
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break // do nothing
                }
            }
        }

        SwiftyStoreKit.updatedDownloadsHandler = { downloads in

            // contentURL is not nil if downloadState == .finished
            let contentURLs = downloads.compactMap { $0.contentURL }
            if contentURLs.count == downloads.count {
                print("Saving: \(contentURLs)")
                SwiftyStoreKit.finishTransaction(downloads[0].transaction)
            }
        }
    }

}
