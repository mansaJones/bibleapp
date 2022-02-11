//
//  AppDelegate+Extensions.swift
//  BibleGamifiedApp
//
//  Created by indianic on 08/12/21.
//

import Foundation
import SwiftyStoreKit

extension AppDelegate {
    /// handelAutologin - This method will handle the navigation of the screen while called.
    //    e.g if the application has done with login and there is user's current details stored we can go to Home dashboard screen , if there is not not logged in it will navigate to Login screen and if its for first time then it will go to Walkthrough screen.
    func showLoginScreen() {
        if let objDashboardNav: HomeNavigationController = R.storyboard.main.homeNavigationController(), let loginVC = R.storyboard.main.loginVC() {
            APPDELEGATE.homeNavigationVC = objDashboardNav
            objDashboardNav.setViewControllers([loginVC], animated: false)
            APPDELEGATE.window?.rootViewController = objDashboardNav
            APPDELEGATE.window?.makeKeyAndVisible()
        }
    }

    func handelAutologin() {

        if let accessToken = UDSettings.accessToken, !accessToken.isEmpty, UDSettings.isUserLogin == true {
            if let objDashboardNav: HomeNavigationController = R.storyboard.main.homeNavigationController(), let mainDashboardVC = R.storyboard.dashboard.mainDashboardVC() {
                objDashboardNav.setViewControllers([mainDashboardVC], animated: false)
                APPDELEGATE.homeNavigationVC = objDashboardNav
                APPDELEGATE.window?.rootViewController = objDashboardNav
                APPDELEGATE.window?.makeKeyAndVisible()
                Utility.shared.initSoundToPlay()
            }
        } else {
            self.showLoginScreen()
        }
    }

    /// Handle the inapp purhcase initialisation setup
    func handleInAppPurhcase() {

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
