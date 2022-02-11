//
//  Games.swift
//
//  Created by indianic on 03/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class GamesDataModel {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let ratting = "ratting"
        static let level = "level"
        static let id = "id"
        static let gameId = "game_id"
        static let timer = "timer"
        static let gameName = "game_name"
        static let totallevel = "total_level"
        static let transactionId = "transaction_id"
        static let isPurchased = "is_purchased"
        static let currency = "currency"
        static let amount = "amount"
        static let isPaid = "is_paid"
        static let starrequiretounlock = "star_require_to_unlock"

    }

    // MARK: Properties

    public var starrequiretounlock: Int?
    public var totallevel: Int?
    public var ratting: Int?
    public var level: Int?
    public var id: Int?
    public var gameId: Int?
    public var timer: Int?
    public var gameName: String?
    public var transactionId: String?
    public var isPurchased: Bool?
    public var amount: String?
    public var isPaid: Bool?
    public var currency: String?

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

        starrequiretounlock = json[SerializationKeys.starrequiretounlock].int
        totallevel = json[SerializationKeys.totallevel].int
        ratting = json[SerializationKeys.ratting].int
        level = json[SerializationKeys.level].int
        id = json[SerializationKeys.id].int
        gameId = json[SerializationKeys.gameId].int
        timer = json[SerializationKeys.timer].int
        gameName = json[SerializationKeys.gameName].string
        transactionId = json[SerializationKeys.transactionId].string
        isPurchased = json[SerializationKeys.isPurchased].bool
        amount = json[SerializationKeys.amount].string
        isPaid = json[SerializationKeys.isPaid].bool
        currency = json[SerializationKeys.currency].string

    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]

        if let value = starrequiretounlock { dictionary[SerializationKeys.starrequiretounlock] = value }
        if let value = totallevel { dictionary[SerializationKeys.totallevel] = value }
        if let value = ratting { dictionary[SerializationKeys.ratting] = value }
        if let value = level { dictionary[SerializationKeys.level] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = gameId { dictionary[SerializationKeys.gameId] = value }
        if let value = timer { dictionary[SerializationKeys.timer] = value }
        if let value = gameName { dictionary[SerializationKeys.gameName] = value }
        if let value = transactionId { dictionary[SerializationKeys.transactionId] = value }
        if let value = amount { dictionary[SerializationKeys.amount] = value }
        if let value = isPaid { dictionary[SerializationKeys.isPaid] = value }
        if let value = currency { dictionary[SerializationKeys.currency] = value }
        if let value = isPurchased { dictionary[SerializationKeys.isPurchased] = value }
        return dictionary
    }

}
