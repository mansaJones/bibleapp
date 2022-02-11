//
//  ProfileViewModel.swift
//  BibleGamifiedApp
//
//  Created by indianic on 30/11/21.
//

import Foundation
import UIKit

class ProfileViewModel: NSObject {

    var userID: Int = 0
    var objRegiterModel = RegisterInfo()
    var objLoginModel: LoginModel?
    var objFileUpload: FileUploadData?

    /// setProfilwInInfo: Call this method to set Profile Info
    /// - Parameter phoneNo: phoneNo
    func setLoginInInfo(_ userID: Int) {
        self.userID = userID
    }

    /// profile API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func callUserProfileAPI(completion: @escaping (Bool) -> Void) {

        Network.request(target: Service.getCustomerInfo(userID), isShowLoader: false, success: { (_, json, _) in
            if (json?[API.Response.data].dictionary) != nil {
                guard let aResponse = json else { return }

                if let aDictMetaData = json?[API.Response.extra_meta].dictionary {
                    AlertMesage.show(.info, message: aDictMetaData[API.Response.message]?.string)
                }
                self.objLoginModel = LoginModel(json: aResponse)
                UserManager.shared.syncCurrentUser(with: self.objLoginModel!)
                completion(true)
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

    /// Logout API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func callUserLogoutAPI(completion: @escaping (Bool) -> Void) {
        var dictParam: [String: Any] = [:]
        dictParam[API.Request.deviceToken]  = UDSettings.deviceToken ?? "123456789"
        Network.request(target: Service.logout(param: dictParam), isShowLoader: false, success: { (_, json, _) in
            if (json?[API.Response.data].dictionary) != nil {
                completion(true)
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

    /// call User Update Profile API
    /// - Parameter completion: Bool Void
    public func callMakeUpdateProfileAPI(completion: @escaping (Bool) -> Void) {

        var dictParam: [String: Any] = [:]
        dictParam[API.Request.full_name]  = objRegiterModel.fullName
        dictParam[API.Request.isSocialUser]  = UserManager.shared.current?.data?.isSocialUser ?? false
        if !(UserManager.shared.current?.data?.isSocialUser ?? false ) {
            dictParam[API.Request.user_name]  = objRegiterModel.user_name
        }

        dictParam[API.Request.email]  = objRegiterModel.email
        dictParam[API.Request.birth_date]  = objRegiterModel.birth_date
        dictParam[API.Request.referral_code]  = objRegiterModel.referral_code
        dictParam[API.Request.parent_email_id]  = objRegiterModel.parent_email_id.trimmed
        Network.request(target: Service.updateProfile(param: dictParam), isShowLoader: true, success: { (_, json, _) in

            if (json?[API.Response.data].dictionary) != nil {
                // guard let aResponse = json else { return }

                if let aDictMetaData = json?[API.Response.extra_meta].dictionary {
                    AlertMesage.show(.info, message: aDictMetaData[API.Response.message]?.string)
                }
                completion(true)
            } else {
                if let aDictMetaData = json?[API.Response.extra_meta].dictionary {
                    AlertMesage.show(.info, message: aDictMetaData[API.Response.message]?.string)
                }
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

    /// upload Avtar Profile WebService
    /// - Parameter completion: as
    /// - Returns: s
    ///
    public func uploadMediaFile(image: UIImage?, completion: @escaping (Bool) -> Void) {

        var dictParam: [String: Any] = [:]
        dictParam[API.Request.avatar] = image

        let service = Service.avtarUpload(param: dictParam)

        Network.request(target: service, success: { (_, json, _) in

            if let aDictData = json?[API.Response.data].dictionary {

                self.objFileUpload = FileUploadData(object: aDictData)

                if let aDictMetaData = json?[API.Response.extra_meta].dictionary {
                    AlertMesage.show(.info, message: aDictMetaData[API.Response.message]?.string)
                }
                completion(true)
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }
}
