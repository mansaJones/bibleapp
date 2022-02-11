//
//  UDSettings.swift
//  StructureApp
//
//  Created by indianic on 29/11/18.
//  Copyright © 2018 IndiaNIC Infotech Ltd. All rights reserved.
//

// Define all your userDefault data in this class which will help you to store the information in the userdefault
//
// By using this class you do not have to manage the keys for your userDefault objects. The name by which you create a property over here will the key for your userDefault object.

import Foundation
import UIKit

enum AppTheme: Int {
    case light
    case dark
    case none
}

class UDSettings {

    /// This will store the value of Device Token in the userDefault.
    /// You can also set it to `nil`.
    ///
    /// To SET the values
    ///
    ///     UDSettings.deviceToken = "YOUR DEVICE TOKEN"
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.deviceToken)
    ///
    class var deviceToken: String? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                UserDefaults.standard[#function] = newValue
            }
        }
    }

    /// This will store the value of Username in the userDefault.
    ///
    /// To SET the values
    ///
    ///     UDSettings.username = "indianic123"
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.username)
    ///
    class var username: String {
        get {
            return UserDefaults.standard[#function] ?? ""
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    /// This will store the value in UD that if user is logged in or not.
    ///
    /// To SET the values
    ///
    ///     UDSettings.isUserLogin = true
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.isUserLogin)
    ///
    class var isUserLogin: Bool {
        get {
            return UserDefaults.standard[#function] ?? false
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    /// This will store the value in UD that user has enabled for the Notification or not.
    ///
    /// To SET the values
    ///
    ///     UDSettings.isNotificationsEnabled = true
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.isNotificationsEnabled)
    ///
    class var isNotificationsEnabled: Bool {
        get {
            return UserDefaults.standard[#function] ?? false
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    /// This will store the current app theme enum in the UD.
    ///
    /// To SET the values
    ///
    ///     UDSettings.appTheme = .dark
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.appTheme)
    ///
    class var appTheme: AppTheme {
        get {
            return UserDefaults.standard[#function] ?? .none
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    class var accessToken: String? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                UserDefaults.standard[#function] = newValue
            }
        }
    }

    class var isSoundPlaying: Bool {
        get {
            return UserDefaults.standard[#function] ?? false
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    /// This how you can store the object of your own model. Currently it will store the object of the User.
    ///
    /// To SET the values
    ///
    ///     UDSettings.currentUser = objUser
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.currentUser)
    ///
//    class var currentUser: User? {
//        get {
//
//            let decoded = UserDefaults.standard[#function] ?? Data()
//            return (decoded.count > 0) ? NSKeyedUnarchiver.unarchiveObject(with: decoded) as? User: nil
//
//        }
//        set {
//
//            if newValue == nil {
//                UserDefaults.standard.removeObject(forKey: #function)
//            } else {
//                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue!)
//                UserDefaults.standard[#function] = encodedData
//            }
//
//        }
//    }

}

extension UserDefaults {

    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }

    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }

}
