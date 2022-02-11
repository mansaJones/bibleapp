//
//  LoginViewModel.swift
//  BibleGamifiedApp
//
//  Created by indianic on 26/11/21.
//

import UIKit
// import SVProgressHUD

enum socialLoginType: String {
    case kFacebook = "facebook"
    case kGoogle = "google"
    case kApple = "apple"
}

class LoginViewModel: NSObject {

    var emailID: String = ""
    var fullName: String = ""

    var password: String = ""
    var deviceType: String = "iOS"
    var deviceToken: String = UDSettings.deviceToken ?? "123456789"
    var socialId: String = ""
    var socialType: socialLoginType = .kApple

    var objLoginModel: LoginModel?

    /// setLoginInInfo: Call this method to set Login Info
    /// - Parameter phoneNo: phoneNo
    func setLoginInInfo(_ emailID: String, password: String) {
        self.emailID = emailID
        self.password = password
    }

    /// setLoginInInfo: Call this method to set Login Info
    /// - Parameter phoneNo: phoneNo
    func setSocialLoginInInfo(_ emailID: String, fullName: String, socialId: String, socialType: socialLoginType) {
        self.emailID = emailID
        self.fullName = fullName
        self.socialId = socialId
        self.socialType = socialType
    }

    /// callGetOTPAPI: Call this method to OTP
    /// - Parameter completion: Bool
    public func callMakeLoginAPI(completion: @escaping (Bool) -> Void) {

        let dictParam = [API.Request.email: self.emailID, API.Request.password: self.password,
                         API.Request.deviceType: API.Request.deviceTypeiOS, API.Request.deviceToken: deviceToken]

        Network.request(target: Service.login(param: dictParam), isShowLoader: true, success: { (_, json, _) in

            if let settings = json?.dictionary {

                if (settings[API.Response.data]?.dictionary) != nil {

                    if let successMsg = settings[API.Response.message]?.string {
                        AlertMesage.show(.info, message: successMsg)
                    }

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

                } else if let status = settings[API.Response.status]?.int, status == 0 {
                    if let successMsg = settings[API.Response.message]?.string {
                        AlertMesage.show(.info, message: successMsg)
                    }
                    completion(false)
                }
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

    /// callGetOTPAPI: Call this method to OTP
    /// - Parameter completion: Bool
    public func callMakeSocialLoginAPI(completion: @escaping (Bool) -> Void) {

        let dictParam = [API.Request.email: self.emailID,
                         API.Request.social_id: self.socialId,
                         API.Request.full_name: self.fullName,
                         API.Request.type: self.socialType.rawValue,
                         API.Request.deviceType: API.Request.deviceTypeiOS,
                         API.Request.deviceToken: deviceToken]

        Network.request(target: Service.socialLogin(param: dictParam), isShowLoader: true, success: { [self] (_, json, _) in

            if let settings = json?.dictionary {

                if let data = settings[API.Response.data]?.dictionary {

                    if let successMsg = settings[API.Response.message]?.string {
                        AlertMesage.show(.info, message: successMsg)
                    }

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

                } else if let status = settings[API.Response.status]?.int, status == 0 {
                    if let successMsg = settings[API.Response.message]?.string {
                        AlertMesage.show(.error, message: successMsg)
                    }
                    completion(false)
                }
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)

        }
    }

    /// callForgotPasswordAPI: Call this method for forgot password
    /// - Parameter completion: Bool
    public func callForgotPasswordAPI(completion: @escaping (Bool) -> Void) {

        let dictParam = [API.Request.email: self.emailID]

        Network.request(target: Service.forgotPassword(param: dictParam), success: { (_, json, _) in

            if let settings = json?.dictionary {
                if let dict = settings[API.Response.extra_meta]?.dictionary {
                    if let successMsg = dict[API.Response.message]?.string {
                        AlertMesage.show(.info, message: successMsg)

                    }
                    completion(true)

                } else if let dict = settings[API.Response.error]?.dictionary {

                    if let errorMsg = dict[API.Response.message]?.string {
                        AlertMesage.show(.error, message: errorMsg)
                    }
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
//
// extension LoginViewModel {
//    func emailValidation(txtEmail: UITextField) -> Bool {
//        if (txtEmail.text ?? "").isBlank {
//            txtEmail.shake()
//            AlertMesage.show(.error, message: R.string.localizable.kemail())
//            return false
//        } else if !(txtEmail.text ?? "").isEmail {
//            txtEmail.shake()
//            AlertMesage.show(.error, message: R.string.localizable.kemail())
//            return false
//        }
//        setLoginInInfo(txtEmail.text!, password: "")
//        return true
//    }
// }
