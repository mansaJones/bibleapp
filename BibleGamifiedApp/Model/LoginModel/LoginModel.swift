//
//  LoginModel.swift
//
//  Created by indianic on 29/11/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LoginModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let data = "data"
    static let extraMeta = "extra_meta"
  }

  // MARK: Properties
  public var data: LoginData?
  public var extraMeta: LoginExtraMeta?

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
    data = LoginData(json: json[SerializationKeys.data])
    extraMeta = LoginExtraMeta(json: json[SerializationKeys.extraMeta])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = data { dictionary[SerializationKeys.data] = value.dictionaryRepresentation() }
    if let value = extraMeta { dictionary[SerializationKeys.extraMeta] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? LoginData
    self.extraMeta = aDecoder.decodeObject(forKey: SerializationKeys.extraMeta) as? LoginExtraMeta
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(extraMeta, forKey: SerializationKeys.extraMeta)
  }

}
