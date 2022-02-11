//
//  Localizable.swift
//  BibleGamifiedApp
//
//  Created by indianic on 26/11/21.
//

import Foundation
import UIKit

struct Localizable {

        struct validation {

            /// login
            static let emailUsername = "Enter email / username to continue!"
            static let password = "Enter password to continue!"
            static let confirmpassword = "Enter confirm password to continue!"
            static let passowordnotsame = "Password and confirm password should be same!"

            // forogot password
            static let email = "Enter valid email to continue!"

            /// register
            ///
            static let fullname = "Enter full name to continue!"
            static let userName = "Enter user name to continue!"
            static let birthdate = "Select Birthdate to continue!"
            static let parentsemail = "Enter valid parents email to continue!"
            static let birthdateValid = "Age Must be between 18 and 100 years old"

            // passowrd
            static let passwordValid = "Your password  must be 8 to 16 characters long including 1 uppercase letter, 1 special character, and alphanumeric characters Ex. Test@123."

        }

}
