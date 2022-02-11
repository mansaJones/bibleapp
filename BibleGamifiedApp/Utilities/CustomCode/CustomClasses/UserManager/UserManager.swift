//
//  UserManager.swift
//  DoThatApp
//
//  Created by DoThatApp on 02/04/20.
//  Copyright © 2019 indianic. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess

let keyChain = Keychain()

class UserManager {

    // MARK: Keys Declaration
    private struct SerializationKeys {
        static let userData = "user_data"
        static let appleUserData = "apple_data"
    }

    /// Shared object of the UserManager class
    static let shared: UserManager = UserManager()

    // MARK: - Private Properties

    /// Stores the object of current user.
    private var currentUser: LoginModel?

    // private var currentAppleUser: AppleUser?

    // MARK: - Public Properties

    /// Return the current logged in user object.
    ///
    ///     UserManager.shared.current
    public var current: LoginModel? {
        get {
            return currentUser
        }
    }

    // MARK: - Public Properties

    /// Return the current apple user
    ///
    ///     UserManager.shared.appleUser
    //    public var appleUser: AppleUser? {
    //        get {
    //            return currentAppleUser
    //        }
    //    }

    // MARK: - init Methods

    init() {

        currentUser = nil
        //  currentAppleUser = nil

        // Check if user is logged in or not.
        // Get the data if user is logged in.
        // Store the object
        if UDSettings.isUserLogin, let dict =  getUserData() {
            currentUser = LoginModel(object: dict)
        } else {
            removeUser()
        }

        //  //       Store the apple data
        //        if let appleData = getAppleUserData() {
        //            currentAppleUser = appleData
        //        } else {
        //            removeAppleUser()
        //        }

    }

    // MARK: - Public Methods

    /// This function will sync the current user data with the existing stored data in the keychain.
    ///
    ///     UserManager.shared.syncCurrentUser(with: UserInfoModel())
    ///
    /// - Parameter newUser: Object of the new User.
    /// - Returns: `true` if data is stored successfully otherwise `false`
    @discardableResult
    public func syncCurrentUser(with newUser: LoginModel) -> Bool {
        // Convert to encoded data
        // Store user data in keychain
        let dict = newUser.dictionaryRepresentation()
        if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: dict, requiringSecureCoding: true) {
            do {
                // store data in keychain
                try keyChain.set(encodedData, key: SerializationKeys.userData)

                // store new user in the local current user which will be accessed later in the application.
                currentUser = newUser

                // set the UserDefault key to true for log in user.
                //     UDSettings.isUserLogin = true
                return true
            } catch {
                return false
            }
        }
        return false
    }

    // MARK: - Public Methods

    /// This method will update the Authentication token of the logged in user in the local
    ///
    ///     UserManager.shared.updateAuthToken("YOUR NEW AUTH TOKEN")
    ///
    /// - Parameter token: New Authentication token which you wanted to replaced for the logged in user.
    /// - Returns: `true` if the token is updated successfully otherwise `false`
    @discardableResult
    public func updateAuthToken(_ token: String) -> Bool {
        if let aModel = currentUser {

            // Update the token in UDsettings
            UDSettings.accessToken = token

            // sync the local user in the stored database.
            return syncCurrentUser(with: aModel)
        } else {
            return false
        }
    }

    /// This function will remove the existing user data from the keychain.
    ///
    ///     UserManager.shared.removeUser()
    public func removeUser() {

        // remove the UserDefault key for login
        UDSettings.isUserLogin = false

        // remove the local stored object
        currentUser = nil

        // remove the data from keychain
        removeUserFromKeychain()

        let domain = Bundle.main.bundleIdentifier ?? ""
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }

}

extension UserManager {

    // MARK: - Private Methods

    /// This function will get the data stored in the keychain for the logged in user.
    ///
    ///     self.getUserData()
    ///
    /// - Returns: Object of the user which is stored in the keychain
    private func getUserData() -> [String: Any]? {

        // Check if user is logged in or not.
        if !UDSettings.isUserLogin { return nil }
        do {
            // Get the data stored in keychain.
            guard let data: Data = try keyChain.getData(SerializationKeys.userData) else { return nil }
            if let dictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: Any] {
                return dictionary
            }
        } catch {
            return nil
        }
        return nil

    }

    // MARK: - Private Methods

    /// This function will get the data stored in the keychain for the current apple user
    ///
    ///     self.getAppleUserData()
    ///
    /// - Returns: Object of the user which is stored in the keychain

    //    private func getAppleUserData() -> AppleUser? {
    //
    //        do {
    //            // Get the data stored in keychain.
    //            guard let data: Data = try keyChain.getData(SerializationKeys.appleUserData) else { return nil }
    //
    //            // Create a model object from the data fetched and returns the user object.
    //            if let aUser = try? JSONDecoder().decode(AppleUser.self, from: data) {
    //                return aUser
    //            }
    //
    //        } catch {
    //            return nil
    //        }
    //
    //        return nil
    //
    //    }

    /// This function will remove the stored user's data from keychain.
    ///
    ///     self.removeUserFromKeychain()
    ///
    private func removeUserFromKeychain() {
        try? keyChain.remove(SerializationKeys.userData)
    }

    /// This function will remove the stored apple  user's data from keychain.
    ///
    ///     self.removeAppleUserFromKeychain()
    ///
    //    private func removeAppleUserFromKeychain() {
    //        try? keyChain.remove(SerializationKeys.appleUserData)
    //    }

}
