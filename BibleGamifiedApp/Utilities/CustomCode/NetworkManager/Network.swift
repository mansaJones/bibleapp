//
//  APIManager.swift
//  BibleGamifiedApp
//
//  Created by BibleGamifiedApp on  31/03/21.
//  Copyright © 2021 BibleGamifiedApp. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import SwiftyJSON
// import SVProgressHUD
import JGProgressHUD
struct AlamofireManager {

    static let shared: Session = {

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90.0           // Seconds
        configuration.timeoutIntervalForResource = 90.0          // Seconds 
        return Alamofire.Session(configuration: configuration)

    }()
}

let provider = MoyaProvider<Service>()

class Network {

    /// - Parameters:
    ///   - target: Your API Target.
    ///   - successCallback: Success block.
    ///   - failureCallback: failure block.

    typealias CompletionBlock = (((_ isSuccess: Bool, _ json: JSON?, _ statusCode: Int) -> Void)?)

    static var completionBlock: CompletionBlock?

    class func request(target: Service, isShowLoader: Bool = true, success callBackHandler: CompletionBlock, failure failureCallback: @escaping (MoyaError) -> Void) {

        print("==== URL ===== \(target.baseURL)")
        print("==== PATH ==== \(target.path)")
        print("==== METHOD ==== \(target.method.rawValue)")
        print("==== HEADER ==== \(target.headers ?? [:])")
        print("==== PARAMETER ==== \(target.task)")

        if isShowLoader {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)) {
                Utility.showSimpleHUD()
            }
        }

        provider.request(target) { (result) in

            if isShowLoader {
                Utility.dismissHUD()
            }

            switch result {

            case .success(let response):
                let json = try? JSON.init(data: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                switch response.statusCode {
                case 200...300: // greater or equal than 200 and less or equal than 300

                    print("json = \(String(describing: json))")

                    callBackHandler?(true, json, response.statusCode)

                case 400...500:
                    // -- Possible case
                    // 1. while registration email address is not unique.
                    print("json = \(String(describing: json))")

                    guard json != nil else { return }

                    if let responseJson = json?.dictionary, let aError = responseJson[API.Response.error]?.dictionary {

                        if let aMessage = aError[API.Response.message]?.string {
                            AlertMesage.show(.error, message: aMessage )
                        }
                    }

                    // -- Possible case
                    // -- Authentication token is no longer valid.

                    // Check if login api returns with the 401.
                    if response.statusCode == 401 {
                        UserManager.shared.removeUser()
                        Utility.shared.pauseSound()
                        Utility.setRootScreen(isAnimation: true, isShowGameUnlock: false)
                    }
                    callBackHandler?(false, json, response.statusCode)
                case 401:
                    print("json = \(String(describing: json))")

                    // -- Possible case
                    // -- Authentication token is no longer valid.

                    // Check if login api returns with the 401.

                    if response.request?.url?.absoluteString.contains(target.path) ?? false {

                        guard json != nil else { return }

                        callBackHandler?(false, json, response.statusCode)
                    }
                default:
                    callBackHandler?(true, json, response.statusCode)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }

}

public extension Collection {

    /// Convert self to JSON String.
    /// Returns: the pretty printed JSON string or an empty string if any error occur.
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }
}
