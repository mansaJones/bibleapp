//
//  Encryptor.swift
//  Encryption
//
//  Created by Encryptor on 25/12/19.
//

import Foundation
import UIKit
import CryptoSwift

@objc class KPEncryptor: NSObject {

    @objc class func sample() {
        print("")
    }

    /// Encrypt text
    /// - Parameters:
    ///   - withKey: Encryption key
    ///   - iv: iv key
    ///   - plainText: text which needs to be converted
    /// - Returns: Converted string
    @objc class func encrypt(withKey: String, iv: String, plainText: String) -> String {
        var result = ""
        do {
            let aes = try AES(key: withKey, iv: iv) // aes128
            let ciphertext2 = try aes.encrypt(Array(plainText.utf8))
            let strrr = ciphertext2.toBase64()
            result = strrr ?? ""
//            result = ciphertext2.toHexString() // working // kp
//            print("AES Encryption Result: \(result)")
        } catch {
            print("Error: \(error)")
        }
        return result
    }

    /// Decrypt text
    /// - Parameters:
    ///   - withKey: Decrypt key same as Encryption
    ///   - iv: iv key
    ///   - cypherText: Encrtypted string
    /// - Returns: Plain text
    @objc class func decrypt(withKey: String, iv: String, cypherText: String) -> String {
        var result = ""
        do {
            let encrypted = cypherText
            let aes = try AES(key: withKey, iv: iv) // aes128
            let decrypted = try aes.decrypt(Array(base64: encrypted))
//            let decrypted = try aes.decrypt(Array(hex: encrypted))
            result = String(data: Data(decrypted), encoding: .utf8) ?? ""
            print("AES Decryption Result: \(result)")
        } catch {
            print("Error: \(error)")
        }
        return result
    }

//    class func base64ToByteArray(base64String: String) -> [UInt8]? {
//          if let nsdata = NSData(base64EncodedString: base64String, options: nil) {
//              var bytes = [UInt8](count: nsdata.length, repeatedValue: 0)
//              nsdata.getBytes(&bytes)
//              return bytes
//          }
//          return nil // Invalid input
//    }

}
