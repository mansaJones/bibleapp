//
//  APIConstant.swift
//  BibleGamifiedApp
//
//  Created by BibleGamifiedApp on 31/03/21.
//  Copyright © 2021 BibleGamifiedApp. All rights reserved.
//

//
//   Define all your API related constant in this file.
//   Do not add any other constant if it is not related to the API.
//
//   All the data are structured in the form so that it can be easily understandable by any person.
//

import Foundation

/// This is the Structure for API
// swiftlint:disable superfluous_disable_command type_name

internal struct API {

    // MARK: - API URL

    /// Structure for URL. This will have the API end point for the server.
    // swiftlint:disable superfluous_disable_command type_name
    struct URL {

        static let live                         = ""
        static let local                        = ""
        static let development                  = ""
        static let staging                      = ""
        static let baselive                         = ""

        static var baseEnvURL                         = ""
        static var baseEnvEndPoint                    = ""

        static let BASEURL                      = API.URL.staging

        /// Firebase dynamic uri details...
        static let domain                       = "https://biblegamifiedapplication.page.link"
        static let firebaseDomainURIPrefix      = "https://biblegamifiedapplication.page.link"
//        static let domain                       = "https://biblegamifiedapp.page.link"
//        static let firebaseDomainURIPrefix      = "https://biblegamifiedapp.page.link"

    }

    struct AppConstants {
        static let privacyPolicy                        = ""
        static let termsServices                        = ""

    }

    // MARK: - Basic Response keys

    /// Structure for API Response Keys. This will use to get the data or anything based on the key from the repsonse. Do not directly use the key rather define here and use it.
    struct Response {

        /// API Base
        ///
        /// 
        static let settings                     = "settings"
        static let status                       = "status"
        static let message                    = "message"
        static let error                    = "error"

        static let meta                         = "meta"

        static let extra_meta                         = "extra_meta"
        static let data                         = "data"
        static let verificationCode             = "verificationCode"
        static let profilePicture               = "profile_picture"

        static let accessPointResourceName = "accessPointResourceName"
        static let transaction_id = "transaction_id"
        static let payload = "payload"
        static let entropy = "entropy"
        static let count = "count"
        static let step_index = "step_index"
        static let total_step_count = "total_step_count"
        static let kSUCCESS = "SUCCESS"

        static let kcommand = "command"
        static let kseqNum = "seqNum"
        static let ksvrCmds = "svrCmds"

    }

    // MARK: - Request end points

    /// Structure for API Request/Method. Define any of your API endpoint/method here.
    struct Request {

        static let propertyId = "propertyId"
        static let opaqueID = "opaqueID"

        // User
        static let mobileNo                     = "mobileNo"
        static let device                       = "device"
        static let deviceToken                  = "device_token"
        static let fname                        = "firstname"
        static let first_name                        = "first_name"
        static let last_name                        = "last_name"

        static let lname                        = "lastname"
        static let cusomerpicture                        = "cusomer_picture"
        static let email                        = "email"
        static let mobileNumber                 = "mobile_number"
        static let type                         = "type"
        static let value                        = "value"
        static let customer                     = "customer"
        static let customerInfo                 = "customerInfo"
        static let customAttributes             = "custom_attributes"
        static let name                         = "name"
        static let time                         = "time"
        static let appleid                        = "appleid"

        static let id                      = "Id"

        static let emailId                      = "emailId"
        static let social_id                      = "social_id"
        static let username                     = "username"
        static let password                     = "password"
        static let countryCode                  = "countryCode"
        static let userId                       = "userId"
        static let verificationCode             = "verificationCode"
        static let confirmPassword              = "password_confirmation"

        static let deviceType = "device_type"

        static let deviceTypeiOS = "ios"

        static let transactionId = "transactionId"

        static let success = "success"
        static let sequenceNumber = "sequenceNumber"

        // register

        static let full_name = "full_name"
        static let user_name = "user_name"
        static let birth_date = "birth_date"
        static let parent_email_id = "parent_email_id"
        static let referral_code = "referral_code"
        static let password_confirmation = "password_confirmation"
        static let avatar = "avatar"
        static let isSocialUser = "is_social_user"

        // leader board
        static let perPage = "perPage"
        static let page = "page"

        // game level progress

        static let gameId = "game_id"
        static let level = "level"
        static let timer = "timer"
        static let ratting = "ratting"

        // level buy
        static let transactionid = "transaction_id"
        static let receipt = "receipt"
        static let currency = "currency"
        static let paymenttype = "payment_type"
        static let starredeemed = "star_redeemed"
        static let amount = "amount"

    }
}
