//
//  LeadeBoardViewModel.swift
//  BibleGamifiedApp
//
//  Created by indianic on 03/12/21.
//

import Foundation
import UIKit
import Moya

struct LeadeBoardInfoModel {

    var page: Int = 1

}

class LeadeBoardViewModel: NSObject {

    // MARK: - Private Properties
    private var objLeaderBoardInfo = LeadeBoardInfoModel()

    private var isAPICalling = false

    public private(set) var objLeaderBoardModel: LeaderBoardModel?

    public var objLeaderBoardDataModel: LeaderBoardDataModel?

    public var apiRequest: Cancellable?

    /// Leader Board API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func getLeadeBoard(_ isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {

        if isAPICalling { return }

        var dictParam: [String: Any] = [:]
        dictParam[API.Request.perPage] = 10
        dictParam[API.Request.page] = objLeaderBoardInfo.page
        isAPICalling = true

        let aService = Service.getLeaderBoard(param: dictParam)

        Network.request(target: aService, isShowLoader: isShowLoader, success: { (_, json, _) in

            self.isAPICalling = false
            if let aResponse = json {

                if let aDictMetaData = aResponse[API.Response.meta].dictionary, !aDictMetaData.isEmpty {
                    let aTempModel = LeaderBoardModel(object: aResponse)

                    if self.objLeaderBoardInfo.page == 1 {
                        self.objLeaderBoardModel = nil
                    }

                    // Manage the received data for Pagination.
                    if let aExistingData = self.objLeaderBoardModel {
                        // Current model has the data available.

                        // Append new data with the previous pagination data.
                        if aExistingData.data?.isEmpty ?? true {
                            // Previous data is not available.
                            aExistingData.data = aTempModel.data
                        } else {
                            // Previous data is available. Append the data.
                            aExistingData.data?.append(contentsOf: aTempModel.data ?? [])
                        }
                        // Replace the Pagination Model.
                        aExistingData.meta = aTempModel.meta

                    } else {
                        // Current model do not have the data available.
                        // Store the current received data directly.
                        self.objLeaderBoardModel = aTempModel
                    }
                    completion(true)
                }

            } else {
                completion(false)

            }
        }) { (_) in
            completion(false)
        }
    }

    /// get My Ranking API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func getMyRanking(completion: @escaping (Bool) -> Void) {

        Network.request(target: Service.getMyRanking, isShowLoader: false, success: { (_, json, _) in
            if let data =  (json?[API.Response.data].dictionary) {
                self.objLeaderBoardDataModel = LeaderBoardDataModel(object: data)
                completion(true)
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

    func reset() {
        objLeaderBoardModel = nil
        objLeaderBoardInfo.page = 1
        isAPICalling = false
    }
}

extension LeadeBoardViewModel {

    /// Function to update page info
    /// - Parameter page: pass pass number
    func updatePageInfo(_ page: Int) {
        objLeaderBoardInfo.page = page
    }
}
