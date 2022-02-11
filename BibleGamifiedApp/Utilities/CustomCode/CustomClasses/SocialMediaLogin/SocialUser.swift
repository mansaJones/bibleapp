//
//  GoogleUser.swift
//  BibleGamifiedApp
//
//  Created by indianic on 10/09/20.
//  Copyright © 2020 IndiaNIC Infotech Ltd. All rights reserved.
//

import Foundation
import UIKit
// import Firebase

public class SocialUser: NSObject {

    public private(set) var socialID: String? // Actual Social Media Id of the User.

    public private(set) var idToken: String?
    public private(set) var firstName: String?
    public private(set) var fullName: String?
    public private(set) var country: String?
    public private(set) var lastName: String?
    public private(set) var email: String?
    public private(set) var imageURL: URL?
    public private(set) var type: RegistationType = .facebook

    internal convenience init(facebookUser: [String: Any]) {
        self.init()

        self.socialID = facebookUser["id"] as? String
        self.idToken = ""
        self.firstName = facebookUser["first_name"] as? String
        self.fullName = facebookUser["name"] as? String
        self.lastName = facebookUser["last_name"] as? String
        self.email = facebookUser["email"] as? String
        self.type = .facebook

    }

    internal convenience init(appleUser: [String: String?]) {
        self.init()

        self.socialID = appleUser["userID"] as? String
        self.idToken = appleUser["identityToken"] as? String
        self.firstName = appleUser["givenName"] as? String
        self.fullName = appleUser["name"] as? String
        self.lastName = appleUser["familyName"] as? String
        self.email = appleUser["email"] as? String
        self.type = .apple
    }
}
