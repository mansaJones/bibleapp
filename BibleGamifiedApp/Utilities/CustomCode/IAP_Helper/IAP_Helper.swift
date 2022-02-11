//
//  IAP_Helper.swift
//  BibleGamifiedApp
//
//  Created by indianic on 31/12/21.
//
import UIKit
import Foundation
import SwiftyStoreKit

struct IAP_Helper {

    static var shared = IAP_Helper()

    func getInfo() {

        SwiftyStoreKit.retrieveProductsInfo([IAP.oneTimePurchaseID]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("priceString: \(priceString)")
            } else if let invalidProductId = result.invalidProductIDs.first {
                print("Could not retrieve product info , Invalid product identifier: \(invalidProductId)")
            } else {
                let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
                print(errorString)
            }
        }
    }

    func purchase(callbackSuccess : @escaping(_ productId: String, _ receiptInfo: String) -> Void) {

        SwiftyStoreKit.purchaseProduct(IAP.oneTimePurchaseID, atomically: true) { result in

            if case .success(let purchase) = result {
                let downloads = purchase.transaction.downloads

                if !downloads.isEmpty {
                    SwiftyStoreKit.start(downloads)
                }
                // Deliver content from server, then:
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }

            self.alertForPurchaseResult(result) { productID, receiptInfo in
                if !productID.isEmpty {
                    callbackSuccess(productID, receiptInfo)
                }
            }
        }
    }

    func showAlert(_ alert: UIAlertController) {
        guard Utility.shared.topMostController() != nil else {
            Utility.shared.topMostController()?.present(alert, animated: true, completion: nil)
            return
        }
    }

    func alertForProductRetrievalInfo(_ result: RetrieveResults) -> UIAlertController {

        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        } else if let invalidProductId = result.invalidProductIDs.first {
            return alertWithTitle("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)")
        } else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
            return alertWithTitle("Could not retrieve product info", message: errorString)
        }
    }

    // swiftlint:disable cyclomatic_complexity
    func alertForPurchaseResult(_ result: PurchaseResult, callbackSuccess : @escaping(_ productId: String, _ receipt: String) -> Void) -> UIAlertController? {
        switch result {
        case .success(let purchase):
            print("Purchase Success: \(purchase.productId)")
            verifyPurchase(.nonConsumablePurchase) { productid, receiptInfo in
                callbackSuccess(productid, receiptInfo)
            }
            return nil
        case .error(let error):
            print("Purchase Failed: \(error)")
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: error.localizedDescription)
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
            case .paymentCancelled: // user cancelled the request, etc.
                return nil
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked")
            default:
                return alertWithTitle("Purchase failed", message: (error as NSError).localizedDescription)
            }
        case .deferred(purchase: let purchase):
            print("Testing")
            return alertWithTitle("Purchase failed", message: "Something went wrong")
        }
    }

    func restorePurchases() {

        SwiftyStoreKit.restorePurchases(atomically: true) { results in

            for purchase in results.restoredPurchases {
                let downloads = purchase.transaction.downloads
                if !downloads.isEmpty {
                    SwiftyStoreKit.start(downloads)
                } else if purchase.needsFinishTransaction {
                    // Deliver content from server, then:
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            self.showAlert(self.alertForRestorePurchases(results))
        }
    }

    func alertForRestorePurchases(_ results: RestoreResults) -> UIAlertController {

        if results.restoreFailedPurchases.count > 0 {
            print("Restore Failed: \(results.restoreFailedPurchases)")
            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support")
        } else if results.restoredPurchases.count > 0 {
            print("Restore Success: \(results.restoredPurchases)")
            return alertWithTitle("Purchases Restored", message: "All purchases have been restored")
        } else {
            print("Nothing to Restore")
            return alertWithTitle("Nothing to restore", message: "No previous purchases were found")
        }
    }

    func verifyReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {

        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: "c5af7e037a3f442aa671be2b53b879ec")
        SwiftyStoreKit.verifyReceipt(using: appleValidator, completion: completion)
    }

    func verifyPurchase(_ purchase: RegisteredPurchase, callbackSuccess : @escaping(_ productId: String, _ receipt: String) -> Void) {

        verifyReceipt { result in

            switch result {
            case .success(let receipt):

                let productId = IAP.oneTimePurchaseID

                switch purchase {
                case .autoRenewableWeekly, .autoRenewableMonthly, .autoRenewableYearly:
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable,
                        productId: productId,
                        inReceipt: receipt)
                case .nonRenewingPurchase:
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .nonRenewing(validDuration: 60),
                        productId: productId,
                        inReceipt: receipt)
                default:
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(
                        productId: productId,
                        inReceipt: receipt)
                    let receiptData = SwiftyStoreKit.localReceiptData
                    if let receiptString = receiptData?.base64EncodedString(options: []), !receiptString.isEmpty {
                        callbackSuccess(productId, receiptString)
                    }
                }

            case .error:
                self.showAlert(self.alertForVerifyReceipt(result))
            }
        }
    }

    func alertWithTitle(_ title: String, message: String) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }

    func alertForVerifyPurchase(_ result: VerifyPurchaseResult, productId: String) -> UIAlertController {

        switch result {
        case .purchased:
            print("\(productId) is purchased")
            return alertWithTitle("Product is purchased", message: "Product will not expire")
        case .notPurchased:
            print("\(productId) has never been purchased")
            return alertWithTitle("Not purchased", message: "This product has never been purchased")
        }
    }

    func alertForVerifyReceipt(_ result: VerifyReceiptResult) -> UIAlertController {

        switch result {
        case .success(let receipt):
            print("Verify receipt Success: \(receipt)")
            return alertWithTitle("Receipt verified", message: "Receipt verified remotely")
        case .error(let error):
            print("Verify receipt Failed: \(error)")
            switch error {
            case .noReceiptData:
                return alertWithTitle("Receipt verification", message: "No receipt data. Try again.")
            case .networkError(let error):
                return alertWithTitle("Receipt verification", message: "Network error while verifying receipt: \(error)")
            default:
                return alertWithTitle("Receipt verification", message: "Receipt verification failed: \(error)")
            }
        }
    }

}
