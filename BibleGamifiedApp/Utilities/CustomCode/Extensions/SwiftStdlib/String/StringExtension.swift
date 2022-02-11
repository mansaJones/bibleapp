//
//  StringExtension.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 3:20 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation
import UIKit

extension String {

    /// This method will check that if the string is Empty / Blank or not.
    ///
    ///     "This is your String!".isBlank      // Returns false
    ///
    var isBlank: Bool {
        return self.trimmed.isEmpty
    }

    /// Remove Whitespace from string.
    ///
    ///     " This is your String! ".trimWhitespace     // Returns This is your String!
    ///
    var trimWhitespace: String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }

    /// String with no spaces or new lines in beginning and end.
    ///
    ///     "This is your String!\n ".isBlank      // Returns This is your String!
    ///
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// String decoded from base64  (if applicable).
    var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }

    /// String encoded in base64 (if applicable).
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }

    /// This method will replace the string with other string.
    ///
    /// - Parameters:
    ///   - string: String which you wanted to replace.
    ///   - withString: String by which you want to replace 1st string.
    /// - Returns: Returns new string by replacing string
    func replace(string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }

    /// Array with unicodes for all characters in a string.
    var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }

    /// Readable string from a URL string.
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }

    /// URL escaped string.
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }

    /// Bool value from string (if applicable).
    var bool: Bool? {
        let selfLowercased = self.trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" || selfLowercased == "yes" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" || selfLowercased == "no" {
            return false
        } else {
            return nil
        }
    }

    /// Double value from string (if applicable).
    var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }

    /// Float value from string (if applicable).
    var float: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }

    /// Float32 value from string (if applicable).
    var float32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }

    /// Float64 value from string (if applicable).
    var float64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }

    /// Integer value from string (if applicable).
    var int: Int? {
        return Int(self)
    }

    /// Int16 value from string (if applicable).
    var int16: Int16? {
        return Int16(self)
    }

    /// Int32 value from string (if applicable).
    var int32: Int32? {
        return Int32(self)
    }

    /// Int64 value from string (if applicable).
    var int64: Int64? {
        return Int64(self)
    }

    /// Int8 value from string (if applicable).
    var int8: Int8? {
        return Int8(self)
    }

    /// URL from string (if applicable).
    var url: URL? {
        return URL(string: self)
    }

    /// First character of string (if applicable).
    var firstCharacter: String? {
        guard let aFirst = self.first else {
            return nil
        }
        return String(aFirst)
    }

    /// Last character of string (if applicable).
    var lastCharacter: String? {
        guard let aLast = self.last else {
            return nil
        }
        return String(aLast)
    }

    /// This will remove all the other Characters except the numbers.
    var removeExceptDigits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }

    /// Get length of string
    ///
    ///     let phrase = "The rain in Spain"
    ///     print(phrase.length)
    ///
    var length: Int {
        get {
            return count
        }
    }

    /// To count the number of words from the string.
    ///
    ///     let phrase = "The rain in Spain"
    ///     print(phrase.wordCount)  // returns 4
    ///
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }

    /// Check string text in main string
    ///
    ///
    ///     let phrase = "The rain in Spain"
    ///     print(phrase.contains("The"))  // returns true
    ///
    /// - Parameter s: Text which we need to check
    /// - Returns: Bool
    func contains(_ string: String) -> Bool {
        return (self.rangeOfCharacter(from: CharacterSet(charactersIn: string)) != nil) ? true: false
    }

    /// Replace text
    ///
    /// - Parameters:
    ///   - target: Source of text to which we need to replace
    ///   - withString: Text through wich we need to replace source text
    /// - Returns: Converted string
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: String.CompareOptions.literal, range: nil)
    }

    /// Method will replace the fixed number of words from the string.
    ///
    ///     let phrase = "The rain in Spain"
    ///     print(phrase.contains("The"))  // returns true
    ///
    /// let phrase = "How much wood would a woodchuck chuck if a woodchuck would chuck wood?"
    /// print(phrase.replacingOccurrences(of: "would", with: "should", count: 1))
    /// - Parameters:
    ///   - search: text which you wanted to replace
    ///   - replacement: text by which it replaced
    ///   - maxReplacements: number of replacement couont
    /// - Returns: New String after the replacements.
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }

        return returnValue
    }

    func intIndex (at: Int) -> Index? {
        if at < 0 || at >= self.length {
            return nil
        }

        return self.index(self.startIndex, offsetBy: at)
    }

    /// Get character from index
    ///
    /// - Parameter target: Pass character on which we need to get index
    /// - Returns: Index of character
    func indexOf (target: Character) -> Int? {
        var index: Int?
        var current = 0

        for char in self {
            if char == target {
                index = current
                break
            }
            current += 1
        }
        return index
    }

    /// Get last index from character
    ///
    /// - Parameter target: Pass character on which we need to get index
    /// - Returns: Index of character
    func lastIndexOf(target: Character) -> Int? {
        var index: Int?

        for aIndex in (0...self.length-1).reversed() {
            if self[aIndex] == target {
                index = aIndex
                break
            }
        }
        return index
    }

    /// Get substring from range
    ///
    /// - Parameters:
    ///   - from: index from which we need substring
    ///   - to: index till we nned substring
    /// - Returns: Substring
    func substring(from: Int, to: Int) -> String? {
        if from > to || from < 0 || to < 0 {
            return nil
        }

        return String(self[intIndex(at: from)!..<self.intIndex(at: to)!])
    }

    /// Seperated by characters
    ///
    /// - Parameter separator: Pass test by which we need to seperated string array
    /// - Returns: String array
    func split(separator: String) -> [String] {
        return self.components(separatedBy: separator)
    }

    /// Replace text by with text
    ///
    /// - Parameters:
    ///   - this: Text to be replaced
    ///   - with: Text through which text replaced
    /// - Returns: Updated text
    func replace(this: String, with: String) -> String {
        return self.replacingOccurrences(of: this, with: with)
    }

    /// Leading and Tralling from spaces from string
    ///
    /// - Returns: Update trimmed string
    func trim () -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// To triming / removing particular character
    ///
    /// - Parameter char: Character to trim
    /// - Returns: Updated string
    func trim (char: Character) -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "\(char)"))
    }

    /// To triming / removing string
    ///
    /// - Parameter charsInString: String to trim
    /// - Returns: Updated string
    func trim (charsInString: String) -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: charsInString))
    }

    /// Remove specific character at index
    ///
    /// - Parameter at: index from which we need to remove character
    mutating func remove(at: Int) {
        self.remove(at: self.intIndex(at: at)!)
    }

    /// Remove all specific character
    ///
    /// - Parameter target: pass character which is removed
    /// - Returns: Updated string
    func removeAllChar(target: Character) -> String {
        return self.replace(this: "\(target)", with: "")
    }

    /// This method will get the width for the string based on the width and font.
    ///
    /// - Parameters:
    ///   - height: Height which is static
    ///   - font: UIFont which you have used.
    /// - Returns: Width of the string based on the data input.
    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }

    /// This method will get the height for the string based on the width and font.
    ///
    /// - Parameters:
    ///   - height: Height which is static
    ///   - font: UIFont which you have used.
    /// - Returns: Width of the string based on the data input.
    func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }

    func getButtonAttributedTitle() -> NSAttributedString {
        let attrStringButtonTitle = NSAttributedString(
            string: self,
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: R.color.afff6D9()!,
                NSAttributedString.Key.strokeWidth: -0.5,
                NSAttributedString.Key.font: R.font.magraBold(size: 25)!
            ]
        )
        return attrStringButtonTitle
    }

    func safelyLimitedTo(length n: Int) -> String {
        if self.count <= n {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }

    func safelyLimitedFrom(length n: Int) -> String {
        if self.count <= n {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }

//    /// Check if string is valid Password or not.
//    var isValidPassword: Bool {
//        // length > >8-16
//        // The password must contain at least three character categories among the following
//        // Uppercase characters (A-Z)
//        // Lowercase characters (a-z)
//        // Digits (0-9)
//        // Special characters (~!@#$%^&*_-+=`|(){}[]:;"'<>,.?/)
//        
//        let password = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[\\-_+={}<>\\[\\]().,;:\"'_~^`@$|/!%*#?&])([a-zA-Z0-9\\-_+={}<>\\[\\]().,;:\"'_~^`@$|/!%*#?&]{8,16})$"
//        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
//    }

    /// isValidPassword: This will return whether the string is valid password or not
    var isValidPassword: Bool {

        if self.containsWhiteSpace() {
            return false
        } else if self.containsEmoji {
            return false
        } else {
//            let regexPwd = "^(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&+=])(?=\\S+$).{6,20}$" // Regex with one character, number, special characters(@#$%^&+=) and length between 6 - 20
            let regexPwd = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^A-Za-z0-9].*)(?=\\S+$).{8,50}$" // Regex with one character, number, any special characters and min length 8 - 50

            return NSPredicate(format: "SELF MATCHES %@", regexPwd).evaluate(with: self)

        }
    }

    // containsWhiteSpace: Call this method to check the whitespace
    /// - Returns: Bool
    func containsWhiteSpace() -> Bool {

        // check if there's a range for a whitespace
        let range = self.rangeOfCharacter(from: .whitespacesAndNewlines)

        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }

    func isUserAdult() -> Bool {

        let aUserDOB = getDateFromString(DateTimeFormat.dd_MM_yyyy.rawValue, dateString: self)
        let timeInterval = aUserDOB.timeIntervalSinceNow
        let age = abs(Int(timeInterval / 31556926.0))
        if age >= 18 {
            return true
        }
        return false
    }
}

extension String {

    /// Get character from index
    ///
    /// - Parameter i: Pass index from which we needed character
    subscript (index: Int) -> Character {
        return self[self.intIndex(at: index)!]
    }
}

extension String {

    /// This will return the MD5 string of the string which is used to call this property. To use this add #import <CommonCrypto/CommonCrypto.h> in your header file
    //    var MD5: String {
    //        get{
    //            let messageData = self.data(using:.utf8)!
    //            var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    //
    //            _ = digestData.withUnsafeMutableBytes {digestBytes in
    //                messageData.withUnsafeBytes {messageBytes in
    //                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
    //                }
    //            }
    //
    //            return digestData.map { String(format: "%02hhx", $0) }.joined()
    //        }
    //    }

}
