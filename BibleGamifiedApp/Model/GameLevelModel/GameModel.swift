//
//  Data.swift
//
//  Created by indianic on 03/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class GameModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let currentLevel = "current_level"
    static let games = "games"
    static let totalRatting = "total_ratting"
  }

  // MARK: Properties
  public var currentLevel: Int?
  public var games: [GamesDataModel]?
  public var totalRatting: Int?

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
    currentLevel = json[SerializationKeys.currentLevel].int
    if let items = json[SerializationKeys.games].array { games = items.map { GamesDataModel(json: $0) } }
    totalRatting = json[SerializationKeys.totalRatting].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = currentLevel { dictionary[SerializationKeys.currentLevel] = value }
    if let value = games { dictionary[SerializationKeys.games] = value.map { $0.dictionaryRepresentation() } }
    if let value = totalRatting { dictionary[SerializationKeys.totalRatting] = value }
    return dictionary
  }

}
