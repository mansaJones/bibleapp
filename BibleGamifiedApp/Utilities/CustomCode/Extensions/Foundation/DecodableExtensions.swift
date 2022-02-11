//
//  DecodableExtensions.swift
//  StructureApp
//
//  Created by indianic on 27/08/19.
//  Copyright © 2019 IndiaNIC Infotech Ltd. All rights reserved.
//

import Foundation
import UIKit

// struct UserStoriesModel: Codable {
//
//    public var name: String
//    public var title: String
//    public var rating: String
//    public var description: String
//    public var date: String
//
// }
//
// struct UserReviews: Codable {
//
//    public var reviews: [UserStoriesModel]
//
// }

// HOW TO USE:: let result: UserReviews? = try UserReviews.fromJSON("user_stories")

extension Decodable {

    static func fromJSON<T: Decodable>(_ fileName: String, fileExtension: String = "json", bundle: Bundle = .main) throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorResourceUnavailable)
        }

        let data = try Data(contentsOf: url)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print(error.localizedDescription)
            print(error)
            throw error
        }
    }

    static func fromJSONURL<T: Decodable>(_ fileURL: URL) throws -> T {

        let data = try Data(contentsOf: fileURL)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print(error.localizedDescription)
            print(error)
            throw error
        }
    }

}
