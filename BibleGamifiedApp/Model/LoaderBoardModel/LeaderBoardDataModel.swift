//
//  Data.swift
//
//  Created by indianic on 03/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class LeaderBoardDataModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let rating = "rating"
    static let id = "id"
    static let fullName = "full_name"
    static let rank = "rank"
      static let avatar = "avatar"
  }

  // MARK: Properties
  public var avatar: String?
  public var rating: Int?
  public var id: Int?
  public var fullName: String?
  public var rank: Int?

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
    rating = json[SerializationKeys.rating].int
    id = json[SerializationKeys.id].int
    fullName = json[SerializationKeys.fullName].string
    rank = json[SerializationKeys.rank].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
      if let value = avatar { dictionary[SerializationKeys.avatar] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = fullName { dictionary[SerializationKeys.fullName] = value }
    if let value = rank { dictionary[SerializationKeys.rank] = value }
    return dictionary
  }

}
