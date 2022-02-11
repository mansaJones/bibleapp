//
//  LoginVC+Extensions.swift
//  BibleGamifiedApp
//
//  Created by indianic on 03/01/22.
//
import UIKit
import Foundation
import GoogleSignIn
import AuthenticationServices
import KeychainAccess

extension LoginVC {

    // MARK: - Custom Methods

    /// handleLoginAction - Handle the login with email ID & password and handle go to the home screen.
    func manageHandleLoginAction() {

        if isValidate() {
            self.loginViewModel.setLoginInInfo(tfEmailUsername.text ?? "", password: tfPassword.text ?? "")

            self.loginViewModel.callMakeLoginAPI { (status) in
                if status {
                    self.handleLoginAction()
                }
            }
        }
    }

    func handleLoginAction() {
        if let user = UserManager.shared.current?.data {
            if user.email?.isBlank ?? false  ||  user.full_name?.isBlank ?? false {
                UDSettings.isUserLogin = false
                if let avtarVC = R.storyboard.profile.editProfileVC() {
                    avtarVC.isFromSignup = true
                    self.pushVC(controller: avtarVC)
                }
            } else {
                showDadshboardVC()
            }
        } else {
            showDadshboardVC()
        }
    }

    func showDadshboardVC () {
        Utility.shared.initSoundToPlay()

        if let homeNavigationController = self.navigationController as? HomeNavigationController {
            APPDELEGATE.homeNavigationVC = homeNavigationController
        }
        self.performSegue(withIdentifier: R.segue.loginVC.segueShowDashboard, sender: nil)

    }

    /// validation method to validate Data
    func isValidate() -> Bool {

        var isValidate = true

        if (tfEmailUsername.text ?? "").isBlank {
            tfEmailUsername.shake()
            AlertMesage.show(.error, message: R.string.localizable.kemailUsername())
            isValidate = false

        } else if (tfPassword.text ?? "").isBlank {
            tfPassword.shake()
            AlertMesage.show(.error, message: R.string.localizable.kpassword())
            isValidate = false
        }
        return isValidate
    }

    /// - Parameter viewController: - view controller to present the viewcontroller for google authentication view
    func handleGoogleLoginAction(_ viewController: UIViewController) {

        GIDSignIn.sharedInstance.signIn(with: APPDELEGATE.signInConfig!, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            self.view.endEditing(true)

            self.loginViewModel.setSocialLoginInInfo(user.profile?.email ?? "", fullName: user.profile?.name ?? "", socialId: user.userID ?? "", socialType: .kGoogle)

            self.loginViewModel.callMakeSocialLoginAPI { (status) in
                if status {
                    self.handleLoginAction()
                }
            }
        }
    }

    func handleFacebookLoginAction() {
        FBManager.shared.userData(Constant.kFacebookPersmission) { (user, success) in

            if success, let aUser = user as? SocialUser {
                // ✅ Facebook Login success
                self.view.endEditing(true)

                self.loginViewModel.setSocialLoginInInfo(aUser.email ?? "", fullName: aUser.fullName ?? "", socialId: aUser.socialID ?? "", socialType: .kFacebook)

                self.loginViewModel.callMakeSocialLoginAPI { (status) in
                    if status {
                        self.handleLoginAction()
                    }
                }
            } else {
                // 🚨 Error in the Login
                FBManager.shared.logOut { _, _ in  }
            }
        }
    }

    /// handleAppleLoginAction : Method to do login with Apple & get the authentication with apple to get the user's account details
    func handleAppleLoginAction() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()

            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])

            authorizationController.delegate = self

            authorizationController.presentationContextProvider = self

            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
}

extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // For present windows
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    // ASAuthorizationControllerDelegate function for authorization failed
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

    }

    // ASAuthorizationControllerDelegate function for successful authorization
    @available(iOS 13.0, *)
    fileprivate func setAppleCredentialsInKeychain(_ firstName: String, _ lastName: String, _ email: String, _ appleIDCredential: ASAuthorizationAppleIDCredential) {
        var dicAppleUserInfo = [String: String]()
        dicAppleUserInfo[API.Request.fname] = firstName
        dicAppleUserInfo[API.Request.lname] = lastName
        dicAppleUserInfo[API.Request.email] = email
        dicAppleUserInfo[API.Request.appleid] = appleIDCredential.user

        let keyChain = Keychain()

        if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: dicAppleUserInfo, requiringSecureCoding: true) {
            do {
                // store data in keychain
                try keyChain.set(encodedData, key: Constant.kAppleIDUserInfo)
                self.loginViewModel.setSocialLoginInInfo(email, fullName: firstName, socialId: appleIDCredential.user, socialType: .kApple)

            } catch let error {

            }
        }
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let userIdentifier = appleIDCredential.user

            if let firstName = appleIDCredential.fullName?.givenName, let lastName = appleIDCredential.fullName?.familyName {
                setAppleCredentialsInKeychain(firstName, lastName, "", appleIDCredential)
            } else {
                Utility.showSimpleHUD()
                self.fetchAppleIDUserInfo(appleIDCredential: appleIDCredential.user)
            }

        } else if authorization.credential is ASPasswordCredential {
            UDSettings.isUserLogin = true
        }
    }

    func fetchAppleIDUserInfo(appleIDCredential: String) {

        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: appleIDCredential) { (credentialState, _) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid. Show Home UI Here

                    do {
                        // Get the data stored in keychain.
                        guard let data: Data = try keyChain.getData(Constant.kAppleIDUserInfo) else { return }

                        if let dicAppleUserInfo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String] {

                            if let firstName = dicAppleUserInfo[API.Request.fname] ,
                               let lastName = dicAppleUserInfo[API.Request.lname],
                               let email = dicAppleUserInfo[API.Request.email],
                               let appleid = dicAppleUserInfo[API.Request.appleid] {
                                Utility.dismissHUD()

                                self.loginViewModel.setSocialLoginInInfo(email, fullName: firstName, socialId: appleid, socialType: .kApple)
                                self.loginViewModel.callMakeSocialLoginAPI { (status) in
                                    if status {
                                        self.handleLoginAction()
                                    }
                                }

                            } else  if let firstName = dicAppleUserInfo[API.Request.first_name] ,
                                       let lastName = dicAppleUserInfo[API.Request.last_name],
                                       let email = dicAppleUserInfo[API.Request.email],
                                       let appleid = dicAppleUserInfo[API.Request.appleid] {

                                Utility.dismissHUD()

                                self.loginViewModel.setSocialLoginInInfo(email, fullName: firstName, socialId: appleid, socialType: .kApple)
                                //
                                self.loginViewModel.callMakeSocialLoginAPI { (status) in
                                    if status {
                                        self.handleLoginAction()
                                    }
                                }
                            }
                        }
                    } catch {
                    }

                    break
                case .revoked:
                    // The Apple ID credential is revoked. Show SignIn UI Here.
                    break
                case .notFound:
                    // No credential was found. Show SignIn UI Here.
                    break
                default:
                    break
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
