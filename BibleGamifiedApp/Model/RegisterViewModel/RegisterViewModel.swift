//
//  RegisterViewModel.swift
//  BibleGamifiedApp
//
//  Created by indianic on 29/11/21.
//

import Foundation
import UIKit

class RegisterInfo {

    var fullName: String = ""
    var deviceToken: String = UDSettings.deviceToken ?? "123456789"
    var user_name: String = ""
    var email: String = ""
    var birth_date: String = ""
    var parent_email_id: String = ""
    var referral_code: String = ""
    var password: String = ""
    var password_confirmation: String = ""

}
class RegisterViewModel: NSObject {

    var objRegiterModel = RegisterInfo()
    var objLoginModel: LoginModel?

    /// setRegisterPasswordInfo: Call this method to set Resiter password Info
    /// - Parameter phoneNo: phoneNo
    func setRegisterInInfo(_ password: String, _ confimrpassword: String) {
        objRegiterModel.password = password
        objRegiterModel.password_confirmation = confimrpassword

    }
    /// callGetOTPAPI: Call this method to Register
    /// - Parameter completion: Bool
    public func callMakeRegisterAPI(completion: @escaping (Bool) -> Void) {
        var dictParam: [String: Any] = [:]
        dictParam[API.Request.full_name]  = objRegiterModel.fullName
        dictParam[API.Request.user_name]  = objRegiterModel.user_name
        dictParam[API.Request.email]  = objRegiterModel.email
        dictParam[API.Request.birth_date]  = objRegiterModel.birth_date
        dictParam[API.Request.referral_code]  = objRegiterModel.referral_code
        dictParam[API.Request.password]  = objRegiterModel.password
        dictParam[API.Request.password_confirmation]  = objRegiterModel.password_confirmation
        dictParam[API.Request.deviceType] = API.Request.deviceTypeiOS
        dictParam[API.Request.deviceToken] = objRegiterModel.deviceToken
        dictParam[API.Request.parent_email_id] = objRegiterModel.parent_email_id

        Network.request(target: Service.register(param: dictParam), success: { (_, json, _) in
            if (json?[API.Response.data].dictionary) != nil {

                guard let aResponse = json else { return }
                self.objLoginModel = LoginModel(json: aResponse)

                let isSynced = UserManager.shared.syncCurrentUser(with: LoginModel(json: [:]))

                if let extraMeta = self.objLoginModel?.extraMeta, let accessToken = extraMeta.token, isSynced {
                    UserManager.shared.syncCurrentUser(with: self.objLoginModel!)
                    UserManager.shared.updateAuthToken(accessToken)
                    UDSettings.isUserLogin = true
                    completion(true)
                } else {
                    UDSettings.isUserLogin = false
                    completion(false)
                }
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

}
