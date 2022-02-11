//
//  Meta.swift
//
//  Created by indianic on 03/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Meta {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let path = "path"
    static let from = "from"
    static let total = "total"
    static let lastPage = "last_page"
    static let perPage = "per_page"
    static let to = "to"
    static let currentPage = "current_page"
  }

  // MARK: Properties
  public var path: String?
  public var from: Int?
  public var total: Int?
  public var lastPage: Int?
  public var perPage: String?
  public var to: Int?
  public var currentPage: Int?

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
    path = json[SerializationKeys.path].string
    from = json[SerializationKeys.from].int
    total = json[SerializationKeys.total].int
    lastPage = json[SerializationKeys.lastPage].int
    perPage = json[SerializationKeys.perPage].string
    to = json[SerializationKeys.to].int
    currentPage = json[SerializationKeys.currentPage].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = path { dictionary[SerializationKeys.path] = value }
    if let value = from { dictionary[SerializationKeys.from] = value }
    if let value = total { dictionary[SerializationKeys.total] = value }
    if let value = lastPage { dictionary[SerializationKeys.lastPage] = value }
    if let value = perPage { dictionary[SerializationKeys.perPage] = value }
    if let value = to { dictionary[SerializationKeys.to] = value }
    if let value = currentPage { dictionary[SerializationKeys.currentPage] = value }
    return dictionary
  }

}
