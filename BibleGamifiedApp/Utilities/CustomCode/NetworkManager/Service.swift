//
//  Service.swift
//  DoThatApp
//
//  Created by DoThatApp on  31/03/20.
//  Copyright © 2019 indianic. All rights reserved.
//

import Foundation
import Moya
import UIKit

enum Service {

    /// User
    case login(param: [String: Any])

    case register(param: [String: Any])

    case socialLogin(param: [String: Any])

    case saveProfile(param: [String: Any])

    case forgotPassword(param: [String: Any])

    // Get Profile Information of the logged-in user.
    case getCustomerInfo(Int)

    // Logout User
    case logout(param: [String: Any])

    // Update User Profile
    case updateProfile(param: [String: Any])

    // Avtar Upload.
    case avtarUpload(param: [String: Any])

    // Get Leader Board
    case getLeaderBoard(param: [String: Any])

    // Get My Ranking
    case getMyRanking

    // User Game Level Progress
    case getGameLevelProgress

    // Game Level Progres Update
    case updateLevel(param: [String: Any])

    // Level Buy
    case levelBuy(param: [String: Any])

}

extension Service: TargetType {

    var task: Task {

        switch self {
        case .getMyRanking,
              .getGameLevelProgress:
            return .requestPlain

        case.getCustomerInfo:

            return .requestParameters(parameters: [:], encoding: self.parameterEncoding)

        case .register(let param),
             .logout(let param),
             .forgotPassword(let param),
             .updateProfile( let param),
             .getLeaderBoard(let param),
             .updateLevel(let param),
             .levelBuy(let param),
             .login(let param), .socialLogin(let param):

            return .requestParameters(parameters: param, encoding: self.parameterEncoding)

        case .saveProfile(let param),
             .avtarUpload(let param):

            let aDictData = param
            var formData = [Moya.MultipartFormData]()

            for (key, value) in aDictData {
                if let img = value as? UIImage {
                    let imageData = img.pngData()
                    if imageData != nil {
                        formData.append(MultipartFormData(provider: .data(imageData!), name: key, fileName: "image.png", mimeType: "image/png"))
                    }

                } else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
                }
            }
            return .uploadMultipart(formData)
        }
    }

    func handleAdminTokenWithContentType() -> [String: String] {

        if let strToken = UDSettings.accessToken {
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(strToken)"]
        }

        return ["Content-Type": "application/json"]
    }

    func handleCustomerTokenWithContentType() -> [String: String] {

        if let strToken = UDSettings.accessToken {
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(strToken)"]
        }

        return ["Content-Type": "application/json"]
    }

    /// The headers to be used in the request.
    var headers: [String: String]? {
        return self.handleCustomerTokenWithContentType()

        /*
        switch self {

        case  .getCustomerInfo:

            /// Pass the token if it is available. Note that the token will only be available after user has logged in to the Application.
            return self.handleCustomerTokenWithContentType()

        case .saveProfile:
            /// Pass the token if it is available. Note that the token will only be available after user has logged in to the Application.
            return self.handleCustomerTokenWithContentType()

        default:
            /// Pass the token if it is available. Note that the token will only be available after user has logged in to the Application.
            return ["Content-Type": "application/json"]
        }
        */

    }

    /// Base Url
    var baseURL: URL {
        switch self {
        default:
            return APIBASEURL.baseURL
        }
    }

    // MARK: - path
    var path: String {
        switch self {

        case .forgotPassword:
            return "api/v1/oauth/forgotPassword"

        case .login:
            return "api/v1/oauth/login"

        case .register:
            return "api/v1/oauth/register"

        case .socialLogin:
            return "api/v1/oauth/socialLogin"

        case .saveProfile:
            return "api/v1/users"

        case .avtarUpload:
            return "api/v1/users/updateAvatar"

        case .logout:
            return "api/v1/oauth/logout"

        case .updateProfile:
            return "api/v1/users"

        case .getLeaderBoard:
            return "api/v1/games/leaderBoard"

        case .getMyRanking:
            return "api/v1/games/myRanking"

        case .getGameLevelProgress:
            return "api/v1/games/getUserLevelProgress"

        case .updateLevel:
            return "api/v1/games/addUpdateUserGameProgress"

        case .levelBuy:
            return "api/v1/games/userGamePurchase"

        case .getCustomerInfo(let id):
            return "api/v1/users/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {

        case .getCustomerInfo,
             .getMyRanking,
             .getGameLevelProgress,
            .getLeaderBoard:
            return .get

//        case .deleteEvent, .deleteProfile, .deleteQuickbloxDialog:
//            return .delete

        case .updateProfile:
            return .put

        default:
            return .post
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {

        case .getCustomerInfo,
             .getLeaderBoard:
            return URLEncoding.default

        default:
            return JSONEncoding.default
        }
    }

    var sampleData: Data {
        return Data()
    }
}
