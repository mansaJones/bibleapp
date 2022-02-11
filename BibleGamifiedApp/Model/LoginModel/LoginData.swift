//
//  LoginData.swift
//
//  Created by indianic on 29/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftUI

public final class LoginData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let email = "email"
    static let id = "id"
    static let createdAt = "created_at"
    static let userName = "user_name"
    static let isSocialUser = "is_social_user"
    static let full_name = "full_name"
    static let birthdate = "birth_date"
    static let parentEmail = "parent_email_id"
      static let referralCode = "referral_code"
      static let avatar = "avatar"

  }

  // MARK: Properties
    public var avatar: String?
    public var referralCode: String?
    public var parentEmail: String?
    public var birthdate: String?
  public var full_name: String?
  public var status: String?
  public var email: String?
  public var id: Int?
  public var createdAt: String?
  public var userName: String?
  public var isSocialUser: Bool? = false

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
      avatar = json[SerializationKeys.avatar].string
      referralCode = json[SerializationKeys.referralCode].string
      parentEmail = json[SerializationKeys.parentEmail].string
      birthdate = json[SerializationKeys.birthdate].string
    status = json[SerializationKeys.status].string
      full_name = json[SerializationKeys.full_name].string
    email = json[SerializationKeys.email].string
    id = json[SerializationKeys.id].int
    createdAt = json[SerializationKeys.createdAt].string
    userName = json[SerializationKeys.userName].string
    isSocialUser = json[SerializationKeys.isSocialUser].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
      if let value = avatar { dictionary[SerializationKeys.avatar] = value }
      if let value = referralCode { dictionary[SerializationKeys.referralCode] = value }
      if let value = parentEmail { dictionary[SerializationKeys.parentEmail] = value }
      if let value = birthdate { dictionary[SerializationKeys.birthdate] = value }
      if let value = full_name { dictionary[SerializationKeys.full_name] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = userName { dictionary[SerializationKeys.userName] = value }
    dictionary[SerializationKeys.isSocialUser] = isSocialUser
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
      self.avatar = aDecoder.decodeObject(forKey: SerializationKeys.avatar) as? String
      self.referralCode = aDecoder.decodeObject(forKey: SerializationKeys.referralCode) as? String
      self.parentEmail = aDecoder.decodeObject(forKey: SerializationKeys.parentEmail) as? String
      self.birthdate = aDecoder.decodeObject(forKey: SerializationKeys.birthdate) as? String
      self.full_name = aDecoder.decodeObject(forKey: SerializationKeys.full_name) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.userName = aDecoder.decodeObject(forKey: SerializationKeys.userName) as? String
    self.isSocialUser = aDecoder.decodeBool(forKey: SerializationKeys.isSocialUser)
  }

  public func encode(with aCoder: NSCoder) {
      aCoder.encode(avatar, forKey: SerializationKeys.avatar)
      aCoder.encode(referralCode, forKey: SerializationKeys.referralCode)
      aCoder.encode(parentEmail, forKey: SerializationKeys.parentEmail)
      aCoder.encode(birthdate, forKey: SerializationKeys.birthdate)
      aCoder.encode(full_name, forKey: SerializationKeys.full_name)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(userName, forKey: SerializationKeys.userName)
    aCoder.encode(isSocialUser, forKey: SerializationKeys.isSocialUser)
  }

}
