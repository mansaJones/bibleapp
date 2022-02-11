//
//  GameViewModel.swift
//  BibleGamifiedApp
//
//  Created by indianic on 03/12/21.
//

import Foundation

import UIKit

class GameInfo {

    var gameid: Int = 0
    var level: Int = 0
    var timer: Int = 0
    var ratting: Int = 0
    var transactionid: String = ""
    var receipt: String = ""
    var currency: String = ""
    var paymenttype: String = ""
    var starredeemed: Int = 0
    var amount: Double = 0.0

}

class GameViewModel: NSObject {

   public var objGameLevelModel: GameModel?
    public var objGameModel: GamesDataModel?

    var objGameInfo = GameInfo()

    /// Game Levele Progress API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func getGameLevelProgressAPI(isShowLoader: Bool = true, completion: @escaping (Bool) -> Void) {

        Network.request(target: Service.getGameLevelProgress, isShowLoader: isShowLoader, success: { (_, json, _) in
            if let data = (json?[API.Response.data].dictionary) {
                self.objGameLevelModel =  GameModel(object: data)
                self.sortGameOrder(arrGames: self.objGameLevelModel?.games ?? []) { isSorted, arrTemps in
                    self.objGameLevelModel?.games = arrTemps
                    completion(isSorted)
                }
                completion(true)
            } else {
                completion(false)
            }

        }) { (_) in
            completion(false)
        }
    }

    /// Game Levele Progress Update API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func callLevelProgressUpdateAPI(completion: @escaping (Bool) -> Void) {
        var dictParam: [String: Any] = [:]
        dictParam[API.Request.gameId]  = objGameInfo.gameid
        dictParam[API.Request.level]  = objGameInfo.level
        dictParam[API.Request.timer]  = objGameInfo.timer
        dictParam[API.Request.ratting]  = objGameInfo.ratting
        Network.request(target: Service.updateLevel(param: dictParam), isShowLoader: false, success: { (_, json, _) in
                if let dict = json?[API.Response.data].dictionary {
                    self.objGameModel =  GamesDataModel(object: dict)
                    completion(true)
                } else {
                    completion(false)
                }
        }) { (_) in
            completion(false)
        }
    }

    /// Level buy API call
    /// - Parameter completion: Completion block
    /// - Returns: Void
    public func callLevelPurchaseAPI(completion: @escaping (Bool) -> Void) {
        var dictParam: [String: Any] = [:]
        dictParam[API.Request.gameId]  = objGameInfo.gameid
        dictParam[API.Request.level]  = objGameInfo.level
        dictParam[API.Request.transactionid]  = objGameInfo.transactionid
        dictParam[API.Request.receipt]  = objGameInfo.receipt
        dictParam[API.Request.currency]  = objGameInfo.currency
        dictParam[API.Request.paymenttype]  = objGameInfo.paymenttype
        dictParam[API.Request.starredeemed]  = objGameInfo.starredeemed

        dictParam[API.Request.amount]  = objGameInfo.amount

        Network.request(target: Service.levelBuy(param: dictParam), success: { (_, json, _) in
            if let settings = json?.dictionary {
                if let dict = settings[API.Response.extra_meta]?.dictionary {
                    if let successMsg = dict[API.Response.message]?.string {
                        AlertMesage.show(.info, message: successMsg)
                    }
                    completion(true)

                } else if let dict = settings[API.Response.error]?.dictionary {
                    if let errorMsg = dict[API.Response.message]?.string {
                        AlertMesage.show(.error, message: errorMsg)
                    }
                    completion(false)
                }
            } else {
                completion(false)
            }
        }) { (_) in
            completion(false)
        }
    }

}

extension GameViewModel {

    /// Update Level Info
    func setGameLevelInfo(_ gameid: Int, _ level: Int, _ timer: Int, _ ratting: Int) {
        objGameInfo.gameid = gameid
        objGameInfo.level = level
        objGameInfo.timer = timer
        objGameInfo.ratting = ratting
    }

    func sortGameOrder(arrGames: [GamesDataModel], completion: @escaping (Bool, [GamesDataModel]) -> Void) {
        let constGroupLength = 8
        let constSetLength = 4

        var tempArrGames: [GamesDataModel] = []

        let grpOne = arrGames.filter({ ($0.level ?? 0) < (constGroupLength + 1) })
        let grpTwo = arrGames.filter({ ($0.level ?? 0) > constGroupLength })

        var setOne: [GamesDataModel] = []
        var setTwo: [GamesDataModel] = []

        for indexI in 1 ..< (constSetLength + 1) {
            if indexI == constSetLength {
                let tempSetOne = grpOne.filter({ (($0.level ?? 0) % constSetLength) == 0 })
                let tempSetTwo = grpTwo.filter({ (($0.level ?? 0) % constSetLength) == 0 })

                setOne.append(contentsOf: tempSetOne)
                setTwo.append(contentsOf: tempSetTwo)
            } else {
                let tempSetOne = grpOne.filter({ (($0.level ?? 0) % constSetLength) == indexI })
                let tempSetTwo = grpTwo.filter({ (($0.level ?? 0) % constSetLength) == indexI })

                setOne.append(contentsOf: tempSetOne)
                setTwo.append(contentsOf: tempSetTwo)
            }
        }

        tempArrGames.append(contentsOf: setOne)
        tempArrGames.append(contentsOf: setTwo)

        completion(true, tempArrGames)
    }
}
