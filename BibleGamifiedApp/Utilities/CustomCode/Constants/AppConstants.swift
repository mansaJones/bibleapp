//
//  AppConstants.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 13/11/17 10:46 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation

struct Encryption {
    /// Password which will be used to Encrypt and Decrypt the data. Key length is required 32
    static let password = "2Dt0Ky12mAvNFsdAB4pdewkew9vhdcfb2323asd1"
}
struct APIKey {

    struct googleAPI {
//        static let clientID = "935997751064-slgn4rq0b835o241qg4ukqs56nlunjme.apps.googleusercontent.com" // Google clientID Key
        static let clientID = "80851461072-a65nr47g8sooi6q72neju007sjjo7s52.apps.googleusercontent.com" // Google clientID Key

    }
}

struct IAP {
    ///
    static let oneTimePurchaseID = "com.biblegamifiedapp.onetime"
}

enum ValidationState {
    case valid
    case invalid(String)
}
