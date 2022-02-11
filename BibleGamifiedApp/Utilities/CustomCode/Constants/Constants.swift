//
//  Constants.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 4:00 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import UIKit
import KeychainAccess

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum APIBASEURL {
    static var baseURL: URL {
        return try! URL(string: "https://" + Configuration.value(for: "BackendURL") + "/") ?? URL(string: "https://heroesofbibledev.inic.cloud/laravel-api/public/")!
    }
}

/// General object of Application Delegate
let APPDELEGATE: AppDelegate                   =   UIApplication.shared.delegate as! AppDelegate

let KEY_WINDOW                                  =  UIApplication.shared.windows.filter {$0.isKeyWindow}.first

/// General object of NotificationCenter
let NOTIFICATION_CENTER                         =   NotificationCenter.default

/// General object of FileManager
let FILEMANAGER                                =   FileManager.default

/// General object of Main Bundle
let MAINBUNDLE                                 =   Bundle.main

/// General object of Main Thread
let MAINTHREAD                                 =   Thread.main

/// General object of Main Screen
let MAINSCREEN                                 =   UIScreen.main

/// General object of UserDefaults
let USERDEFAULTS                               =   UserDefaults.standard

/// General object of UIApplication
let APPLICATION                                 =  UIApplication.shared

/// General object of Current Device
let CURRENTDEVICE                              =   UIDevice.current

/// General object of Current Landuage
let CURRENTLANGUAGE                            =   NSLocale.current.languageCode

/// General object of Network Activity Indicator
let NETWORKACTIVITY                            =   APPLICATION.isNetworkActivityIndicatorVisible

#if DEBUG
//    func debugPrint(items: Any..., separator: String = " ", terminator: String = "\n") {}
//    func print(items: Any..., separator: String = " ", terminator: String = "\n") {}
//    func print() {}
//    func print(_: Any) {}
#elseif STAGING
    func debugPrint(items: Any..., separator: String = " ", terminator: String = "\n") {}
    func print(items: Any..., separator: String = " ", terminator: String = "\n") {}
    func print() {}
    func print(_: Any) {}
#else
    func debugPrint(items: Any..., separator: String = " ", terminator: String = "\n") {}
    func print(items: Any..., separator: String = " ", terminator: String = "\n") {}
    func print() {}
    func print(_: Any) {}
#endif

#if DEBUG
// APPSTORE version
let keychain = Keychain(service: "com.BibleGamifiedApp.keychain.development")

#elseif STAGING
// INDIANIC ENTERPRISE version
let keychain = Keychain(service: "com.BibleGamifiedApp.keychain.staging")

#elseif RELEASE
// INDIANIC ENTERPRISE DEMO version
let keychain = Keychain(service: "com.BibleGamifiedApp.keychain")

#else
// INDIANIC DEVELOPMENT version
let keychain = Keychain(service: "com.BibleGamifiedApp.keychain.development")

#endif

class Constant {

    // --------------------------------------------------------------------------
    // MARK: Default Values
    // --------------------------------------------------------------------------
    static let DEVICE_SCREEN_WIDTH =  MAINSCREEN.bounds.width
    static let DEVICE_SCREEN_HEIGHT =  MAINSCREEN.bounds.height

    static let kFacebookPersmission =  ["fields": "id, name, email, last_name, first_name"]

    static let kCelebrationAnimation =  "celebration_1"
    static let kZoomIn =  "ZoomIn"
    static let kAppleIDUserInfo = "kAppleIDUserInfo"

    static let BUNDLEID = Bundle.main.bundleIdentifier ?? "com.biblegamifiedapp"
    static let AppStoreID = "1532076222"
    static let kBibleGamifiedAppStoreLink = "https://apps.apple.com/us/app/dothat/id1532076222"
}

// MARK: - Avatar Module
struct AvatarSteps {
    var strTitle: String = ""
    var strSubTitle: String = ""
    var isFirstStep: Bool = false
    var isLastStep: Bool = false
    var type: AvatarStepType = .typeSkinTone
}

/// Avatar Model info
struct AvtarInfoModel {
    var title: String = ""
    var avatarSkinTone: String = "" // BodySkintoneStyle.styleOne.skinTone
    var avatarFaceStyle: String = "" // BodyStyle.styleOne.faceStyleMale
    var avatarHairStyle: String = "" // BodyStyle.styleOne.hairStyleMale
    var avatarGlasses: String = "" // AvatarBodyInfo.slim.maleBody
    var isFemale: Bool = false
}

enum AppGenderType {
    case typeMale
    case typeFemale

    var strIdentifier: String {
        switch self {
        case .typeMale:
            return "M"
        case .typeFemale:
            return "F"
        }
    }

    var strDisplayValue: String {
        switch self {
        case .typeMale:
            return R.string.localizable.kmale()
        case .typeFemale:
            return R.string.localizable.kfemale()
        }
    }

    var strImageName: String {
        switch self {
        case .typeMale:
            return "MaleAvatar"
        case .typeFemale:
            return "FemaleAvatar"
        }
    }
}

extension AppGenderType {
    init(strValue: String) {
        switch strValue.lowercased() {
        case "m":
            self = .typeMale
        case "f":
            self = .typeFemale
        case "male":
            self = .typeMale
        case "female":
            self = .typeFemale
        default:
            self = .typeMale
        }
    }
}

enum AvatarStepType {
    case typeSkinTone
    case typeFaceStyle
    case typeHairStyle
    case typeGlasses
}

enum AvatarSkinTone {
    case typeTone1
    case typeTone2
    case typeTone3
    case typeTone4
    case typeTone5
    case typeTone6
    case typeTone7
    case typeTone8
    case typeTone9
    case typeTone10
    case typeTone11

    var strColorCode: String {
        switch self {
        case .typeTone1:
            return "FFD6B8"
        case .typeTone2:
            return "F2B665"
        case .typeTone3:
            return "DFB173"
        case .typeTone4:
            return "8C6D50"
        case .typeTone5:
            return "975214"
        case .typeTone6:
            return "7D4821"
        case .typeTone7:
            return "8A6A4B"
        case .typeTone8:
            return "9A6649"
        case .typeTone9:
            return "AE694B"
        case .typeTone10:
            return "906240"
        case .typeTone11:
            return "AB725B"
        }
    }

    func getSkinTones() -> [AvatarSkinTone] {
        var tempTones: [AvatarSkinTone] = []
        let firstType: AvatarSkinTone = .typeTone1

        switch firstType {

        case .typeTone1:
            tempTones.append(.typeTone1)
            fallthrough
        case .typeTone2:
            tempTones.append(.typeTone2)
            fallthrough
        case .typeTone3:
            tempTones.append(.typeTone3)
            fallthrough
        case .typeTone4:
            tempTones.append(.typeTone4)
            fallthrough
        case .typeTone5:
            tempTones.append(.typeTone5)
            fallthrough
        case .typeTone6:
            tempTones.append(.typeTone6)
            fallthrough
        case .typeTone7:
            tempTones.append(.typeTone7)
            fallthrough
        case .typeTone8:
            tempTones.append(.typeTone8)
            fallthrough
        case .typeTone9:
            tempTones.append(.typeTone9)
            fallthrough
        case .typeTone10:
            tempTones.append(.typeTone10)
            fallthrough
        case .typeTone11:
            tempTones.append(.typeTone11)
        }

        return tempTones
    }
}

enum AvatarMaleFace {
    case typeMaleFace1
    case typeMaleFace2
    case typeMaleFace3
    case typeMaleFace4
    case typeMaleFace5
    case typeMaleFace6
    case typeMaleFace7

    var strImageName: String {
        switch self {
        case .typeMaleFace1:
            return "MaleFace1"
        case .typeMaleFace2:
            return "MaleFace2"
        case .typeMaleFace3:
            return "MaleFace3"
        case .typeMaleFace4:
            return "MaleFace4"
        case .typeMaleFace5:
            return "MaleFace5"
        case .typeMaleFace6:
            return "MaleFace6"
        case .typeMaleFace7:
            return "MaleFace7"
        }
    }

    var strThumbImageName: String {
        switch self {
        case .typeMaleFace1:
            return "MaleFaceThumb1"
        case .typeMaleFace2:
            return "MaleFaceThumb2"
        case .typeMaleFace3:
            return "MaleFaceThumb3"
        case .typeMaleFace4:
            return "MaleFaceThumb4"
        case .typeMaleFace5:
            return "MaleFaceThumb5"
        case .typeMaleFace6:
            return "MaleFaceThumb6"
        case .typeMaleFace7:
            return "MaleFaceThumb7"
        }
    }

    func getMaleFaces() -> [AvatarMaleFace] {
        var tempFaces: [AvatarMaleFace] = []
        let firstType: AvatarMaleFace = .typeMaleFace1
        switch firstType {
        case .typeMaleFace1:
            tempFaces.append(.typeMaleFace1)
            fallthrough
        case .typeMaleFace2:
            tempFaces.append(.typeMaleFace2)
            fallthrough
        case .typeMaleFace3:
            tempFaces.append(.typeMaleFace3)
            fallthrough
        case .typeMaleFace4:
            tempFaces.append(.typeMaleFace4)
            fallthrough
        case .typeMaleFace5:
            tempFaces.append(.typeMaleFace5)
            fallthrough
        case .typeMaleFace6:
            tempFaces.append(.typeMaleFace6)
            fallthrough
        case .typeMaleFace7:
            tempFaces.append(.typeMaleFace7)
        }
        return tempFaces
    }
}

enum AvatarMaleHairStyle {
    case typeMaleHair1
    case typeMaleHair2
    case typeMaleHair3
    case typeMaleHair4
    case typeMaleHair5
    case typeMaleHair6
    case typeMaleHair7
    case typeMaleHair8
    case typeMaleHair9
    case typeMaleHair10
    case typeMaleHair11
    case typeMaleHair12
    case typeMaleHair13
    case typeMaleHair14
    case typeMaleHair15
    case typeMaleHair16
    case typeEmptyOption

    var strImageName: String {
        switch self {
        case .typeMaleHair1:
            return "MaleHair1"
        case .typeMaleHair2:
            return "MaleHair2"
        case .typeMaleHair3:
            return "MaleHair3"
        case .typeMaleHair4:
            return "MaleHair4"
        case .typeMaleHair5:
            return "MaleHair5"
        case .typeMaleHair6:
            return "MaleHair6"
        case .typeMaleHair7:
            return "MaleHair7"
        case .typeMaleHair8:
            return "MaleHair8"
        case .typeMaleHair9:
            return "MaleHair9"
        case .typeMaleHair10:
            return "MaleHair10"
        case .typeMaleHair11:
            return "MaleHair11"
        case .typeMaleHair12:
            return "MaleHair12"
        case .typeMaleHair13:
            return "MaleHair13"
        case .typeMaleHair14:
            return "MaleHair14"
        case .typeMaleHair15:
            return "MaleHair15"
        case .typeMaleHair16:
            return "MaleHair16"
        case .typeEmptyOption:
            return "EmptyOption"
        }
    }

    var strThumbImageName: String {
        switch self {
        case .typeMaleHair1:
            return "MaleHairThumb1"
        case .typeMaleHair2:
            return "MaleHairThumb2"
        case .typeMaleHair3:
            return "MaleHairThumb3"
        case .typeMaleHair4:
            return "MaleHairThumb4"
        case .typeMaleHair5:
            return "MaleHairThumb5"
        case .typeMaleHair6:
            return "MaleHairThumb6"
        case .typeMaleHair7:
            return "MaleHairThumb7"
        case .typeMaleHair8:
            return "MaleHairThumb8"
        case .typeMaleHair9:
            return "MaleHairThumb9"
        case .typeMaleHair10:
            return "MaleHairThumb10"
        case .typeMaleHair11:
            return "MaleHairThumb11"
        case .typeMaleHair12:
            return "MaleHairThumb12"
        case .typeMaleHair13:
            return "MaleHairThumb13"
        case .typeMaleHair14:
            return "MaleHairThumb14"
        case .typeMaleHair15:
            return "MaleHairThumb15"
        case .typeMaleHair16:
            return "MaleHairThumb16"
        case .typeEmptyOption:
            return "EmptyOption"
        }
    }

    func getMaleHairStyles() -> [AvatarMaleHairStyle] {
        var arrTempHair: [AvatarMaleHairStyle] = []
        let firstType: AvatarMaleHairStyle = .typeMaleHair1
        switch firstType {
        case .typeMaleHair1:
            arrTempHair.append(.typeMaleHair1)
            fallthrough
        case .typeMaleHair2:
            arrTempHair.append(.typeMaleHair2)
            fallthrough
        case .typeMaleHair3:
            arrTempHair.append(.typeMaleHair3)
            fallthrough
        case .typeMaleHair4:
            arrTempHair.append(.typeMaleHair4)
            fallthrough
        case .typeMaleHair5:
            arrTempHair.append(.typeMaleHair5)
            fallthrough
        case .typeMaleHair6:
            arrTempHair.append(.typeMaleHair6)
            fallthrough
        case .typeMaleHair7:
            arrTempHair.append(.typeMaleHair7)
            fallthrough
        case .typeMaleHair8:
            arrTempHair.append(.typeMaleHair8)
            fallthrough
        case .typeMaleHair9:
            arrTempHair.append(.typeMaleHair9)
            fallthrough
        case .typeMaleHair10:
            arrTempHair.append(.typeMaleHair10)
            fallthrough
        case .typeMaleHair11:
            arrTempHair.append(.typeMaleHair11)
            fallthrough
        case .typeMaleHair12:
            arrTempHair.append(.typeMaleHair12)
            fallthrough
        case .typeMaleHair13:
            arrTempHair.append(.typeMaleHair13)
            fallthrough
        case .typeMaleHair14:
            arrTempHair.append(.typeMaleHair14)
            fallthrough
        case .typeMaleHair15:
            arrTempHair.append(.typeMaleHair15)
            fallthrough
        case .typeMaleHair16:
            arrTempHair.append(.typeMaleHair16)
            fallthrough
        case .typeEmptyOption:
            arrTempHair.append(.typeEmptyOption)
        }
        return arrTempHair
    }
}

enum AvatarMaleEyewear {
    case typeMaleEyewear1
    case typeMaleEyewear2
    case typeMaleEyewear3
    case typeMaleEyewear4
    case typeMaleEyewear5
    case typeEmptyOption

    var strImageName: String {
        switch self {
        case .typeMaleEyewear1:
            return "MaleEyewear1"
        case .typeMaleEyewear2:
            return "MaleEyewear2"
        case .typeMaleEyewear3:
            return "MaleEyewear3"
        case .typeMaleEyewear4:
            return "MaleEyewear4"
        case .typeMaleEyewear5:
            return "MaleEyewear5"
        case .typeEmptyOption:
            return "EmptyOption"
        }
    }

    var strThumbImageName: String {
        switch self {
        case .typeMaleEyewear1:
            return "MaleEyewearThumb1"
        case .typeMaleEyewear2:
            return "MaleEyewearThumb2"
        case .typeMaleEyewear3:
            return "MaleEyewearThumb3"
        case .typeMaleEyewear4:
            return "MaleEyewearThumb4"
        case .typeMaleEyewear5:
            return "MaleEyewearThumb5"
        case .typeEmptyOption:
            return "EmptyOption"
        }
    }

    func getMaleEyewears() -> [AvatarMaleEyewear] {
        var arrTempEyewears: [AvatarMaleEyewear] = []
        let firstType: AvatarMaleEyewear = .typeMaleEyewear1

        switch firstType {
        case .typeMaleEyewear1:
            arrTempEyewears.append(.typeMaleEyewear1)
            fallthrough
        case .typeMaleEyewear2:
            arrTempEyewears.append(.typeMaleEyewear2)
            fallthrough
        case .typeMaleEyewear3:
            arrTempEyewears.append(.typeMaleEyewear3)
            fallthrough
        case .typeMaleEyewear4:
            arrTempEyewears.append(.typeMaleEyewear4)
            fallthrough
        case .typeMaleEyewear5:
            arrTempEyewears.append(.typeMaleEyewear5)
            fallthrough
        case .typeEmptyOption:
            arrTempEyewears.append(.typeEmptyOption)
        }

        return arrTempEyewears
    }
}

enum AvatarFemaleFace {
    case typeFemaleFace1
    case typeFemaleFace2
    case typeFemaleFace3
    case typeFemaleFace4
    case typeFemaleFace5
    case typeFemaleFace6
    case typeFemaleFace7

    var strImageName: String {
        switch self {
        case .typeFemaleFace1:
            return "FemaleFace1"
        case .typeFemaleFace2:
            return "FemaleFace2"
        case .typeFemaleFace3:
            return "FemaleFace3"
        case .typeFemaleFace4:
            return "FemaleFace4"
        case .typeFemaleFace5:
            return "FemaleFace5"
        case .typeFemaleFace6:
            return "FemaleFace6"
        case .typeFemaleFace7:
            return "FemaleFace7"
        }
    }

    var strThumbImageName: String {
        switch self {
        case .typeFemaleFace1:
            return "FemaleFaceThumb1"
        case .typeFemaleFace2:
            return "FemaleFaceThumb2"
        case .typeFemaleFace3:
            return "FemaleFaceThumb3"
        case .typeFemaleFace4:
            return "FemaleFaceThumb4"
        case .typeFemaleFace5:
            return "FemaleFaceThumb5"
        case .typeFemaleFace6:
            return "FemaleFaceThumb6"
        case .typeFemaleFace7:
            return "FemaleFaceThumb7"
        }
    }

    func getFemaleFaces() -> [AvatarFemaleFace] {
        var arrFaces: [AvatarFemaleFace] = []
        let firstType: AvatarFemaleFace = .typeFemaleFace1

        switch firstType {
        case .typeFemaleFace1:
            arrFaces.append(.typeFemaleFace1)
            fallthrough
        case .typeFemaleFace2:
            arrFaces.append(.typeFemaleFace2)
            fallthrough
        case .typeFemaleFace3:
            arrFaces.append(.typeFemaleFace3)
            fallthrough
        case .typeFemaleFace4:
            arrFaces.append(.typeFemaleFace4)
            fallthrough
        case .typeFemaleFace5:
            arrFaces.append(.typeFemaleFace5)
            fallthrough
        case .typeFemaleFace6:
            arrFaces.append(.typeFemaleFace6)
            fallthrough
        case .typeFemaleFace7:
            arrFaces.append(.typeFemaleFace7)
        }

        return arrFaces
    }
}

enum AvatarFemaleHairStyle {
    case typeFemaleHair1
    case typeFemaleHair2
    case typeFemaleHair3
    case typeFemaleHair4
    case typeFemaleHair5
    case typeFemaleHair6
    case typeFemaleHair7
    case typeFemaleHair8
    case typeFemaleHair9
    case typeFemaleHair10
    case typeFemaleHair11
    case typeFemaleHair12
    case typeFemaleHair13
    case typeFemaleHair14
    case typeFemaleHair15
    case typeFemaleHair16

    var strImageName: String {
        switch self {
        case .typeFemaleHair1:
            return "FemaleHair1"
        case .typeFemaleHair2:
            return "FemaleHair2"
        case .typeFemaleHair3:
            return "FemaleHair3"
        case .typeFemaleHair4:
            return "FemaleHair4"
        case .typeFemaleHair5:
            return "FemaleHair5"
        case .typeFemaleHair6:
            return "FemaleHair6"
        case .typeFemaleHair7:
            return "FemaleHair7"
        case .typeFemaleHair8:
            return "FemaleHair8"
        case .typeFemaleHair9:
            return "FemaleHair9"
        case .typeFemaleHair10:
            return "FemaleHair10"
        case .typeFemaleHair11:
            return "FemaleHair11"
        case .typeFemaleHair12:
            return "FemaleHair12"
        case .typeFemaleHair13:
            return "FemaleHair13"
        case .typeFemaleHair14:
            return "FemaleHair14"
        case .typeFemaleHair15:
            return "FemaleHair15"
        case .typeFemaleHair16:
            return "FemaleHair16"
        }
    }

    var strThumbImageName: String {
        switch self {
        case .typeFemaleHair1:
            return "FemaleHairThumb1"
        case .typeFemaleHair2:
            return "FemaleHairThumb2"
        case .typeFemaleHair3:
            return "FemaleHairThumb3"
        case .typeFemaleHair4:
            return "FemaleHairThumb4"
        case .typeFemaleHair5:
            return "FemaleHairThumb5"
        case .typeFemaleHair6:
            return "FemaleHairThumb6"
        case .typeFemaleHair7:
            return "FemaleHairThumb7"
        case .typeFemaleHair8:
            return "FemaleHairThumb8"
        case .typeFemaleHair9:
            return "FemaleHairThumb9"
        case .typeFemaleHair10:
            return "FemaleHairThumb10"
        case .typeFemaleHair11:
            return "FemaleHairThumb11"
        case .typeFemaleHair12:
            return "FemaleHairThumb12"
        case .typeFemaleHair13:
            return "FemaleHairThumb13"
        case .typeFemaleHair14:
            return "FemaleHairThumb14"
        case .typeFemaleHair15:
            return "FemaleHairThumb15"
        case .typeFemaleHair16:
            return "FemaleHairThumb16"
        }
    }

    func getFemaleHairStyles() -> [AvatarFemaleHairStyle] {
        var arrHairs: [AvatarFemaleHairStyle] = []
        let firstType: AvatarFemaleHairStyle = .typeFemaleHair1

        switch firstType {

        case .typeFemaleHair1:
            arrHairs.append(.typeFemaleHair1)
            fallthrough
        case .typeFemaleHair2:
            arrHairs.append(.typeFemaleHair2)
            fallthrough
        case .typeFemaleHair3:
            arrHairs.append(.typeFemaleHair3)
            fallthrough
        case .typeFemaleHair4:
            arrHairs.append(.typeFemaleHair4)
            fallthrough
        case .typeFemaleHair5:
            arrHairs.append(.typeFemaleHair5)
            fallthrough
        case .typeFemaleHair6:
            arrHairs.append(.typeFemaleHair6)
            fallthrough
        case .typeFemaleHair7:
            arrHairs.append(.typeFemaleHair7)
            fallthrough
        case .typeFemaleHair8:
            arrHairs.append(.typeFemaleHair8)
            fallthrough
        case .typeFemaleHair9:
            arrHairs.append(.typeFemaleHair9)
            fallthrough
        case .typeFemaleHair10:
            arrHairs.append(.typeFemaleHair10)
            fallthrough
        case .typeFemaleHair11:
            arrHairs.append(.typeFemaleHair11)
            fallthrough
        case .typeFemaleHair12:
            arrHairs.append(.typeFemaleHair12)
            fallthrough
        case .typeFemaleHair13:
            arrHairs.append(.typeFemaleHair13)
            fallthrough
        case .typeFemaleHair14:
            arrHairs.append(.typeFemaleHair14)
            fallthrough
        case .typeFemaleHair15:
            arrHairs.append(.typeFemaleHair15)
            fallthrough
        case .typeFemaleHair16:
            arrHairs.append(.typeFemaleHair16)
        }

        return arrHairs
    }
}

enum AvatarFemaleEyewear {
    case typeFemaleEyewear1
    case typeFemaleEyewear2
    case typeFemaleEyewear3
    case typeFemaleEyewear4
    case typeFemaleEyewear5
    case typeFemaleEyewear6
    case typeFemaleEyewear7
    case typeFemaleEyewear8
    case typeEmptyOption

    var strImageName: String {
        switch self {
        case .typeFemaleEyewear1:
            return "FemaleEyewear1"
        case .typeFemaleEyewear2:
            return "FemaleEyewear2"
        case .typeFemaleEyewear3:
            return "FemaleEyewear3"
        case .typeFemaleEyewear4:
            return "FemaleEyewear4"
        case .typeFemaleEyewear5:
            return "FemaleEyewear5"
        case .typeFemaleEyewear6:
            return "FemaleEyewear6"
        case .typeFemaleEyewear7:
            return "FemaleEyewear7"
        case .typeFemaleEyewear8:
            return "FemaleEyewear8"
        case .typeEmptyOption:
            return "EmptyOption"
        }
    }

    var strThumbImageName: String {
        switch self {
        case .typeFemaleEyewear1:
            return "FemaleEyewearThumb1"
        case .typeFemaleEyewear2:
            return "FemaleEyewearThumb2"
        case .typeFemaleEyewear3:
            return "FemaleEyewearThumb3"
        case .typeFemaleEyewear4:
            return "FemaleEyewearThumb4"
        case .typeFemaleEyewear5:
            return "FemaleEyewearThumb5"
        case .typeFemaleEyewear6:
            return "FemaleEyewearThumb6"
        case .typeFemaleEyewear7:
            return "FemaleEyewearThumb7"
        case .typeFemaleEyewear8:
            return "FemaleEyewearThumb8"
        case .typeEmptyOption:
            return "EmptyOption"
        }
    }

    func getFemaleEyewears() -> [AvatarFemaleEyewear] {
        var arrTempEyewears: [AvatarFemaleEyewear] = []
        let firstType: AvatarFemaleEyewear = .typeFemaleEyewear1

        switch firstType {
        case .typeFemaleEyewear1:
            arrTempEyewears.append(.typeFemaleEyewear1)
            fallthrough
        case .typeFemaleEyewear2:
            arrTempEyewears.append(.typeFemaleEyewear2)
            fallthrough
        case .typeFemaleEyewear3:
            arrTempEyewears.append(.typeFemaleEyewear3)
            fallthrough
        case .typeFemaleEyewear4:
            arrTempEyewears.append(.typeFemaleEyewear4)
            fallthrough
        case .typeFemaleEyewear5:
            arrTempEyewears.append(.typeFemaleEyewear5)
            fallthrough
        case .typeFemaleEyewear6:
            arrTempEyewears.append(.typeFemaleEyewear6)
            fallthrough
        case .typeFemaleEyewear7:
            arrTempEyewears.append(.typeFemaleEyewear7)
            fallthrough
        case .typeFemaleEyewear8:
            arrTempEyewears.append(.typeFemaleEyewear8)
            fallthrough
        case .typeEmptyOption:
            arrTempEyewears.append(.typeEmptyOption)
        }

        return arrTempEyewears
    }
}
