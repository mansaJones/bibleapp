//
//  MainDashboardItem.swift
//  BibleGamifiedApp
//
//  Created by indianic on 23/11/21.
//
import Foundation
import SwiftyJSON

public final class FileUploadData {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {

        static let avatar = "avatar"
    }

    // MARK: Properties
    public var avatar: String?

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

    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = avatar { dictionary[SerializationKeys.avatar] = value }

        return dictionary
    }
}
