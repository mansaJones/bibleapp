//
//  MainDashboardItem.swift
//  BibleGamifiedApp
//
//  Created by indianic on 23/11/21.
//

import UIKit
import Foundation

class MainDashboardItem: NSObject {

    var dashboardItemName = ""
    var dashboardItemImage = UIImage()

    init(name: String, image: UIImage) {
        self.dashboardItemName = name
        self.dashboardItemImage = image
    }
}

class MainDashboardItemModel {

    static var shared = MainDashboardItemModel()

    func fetchMainDashboardList() -> [MainDashboardItem] {

        let aMainDashboardItemList: [MainDashboardItem] = [
            MainDashboardItem(name: R.string.localizable.kGames(), image: R.image.ic_games_icon()!),
            MainDashboardItem(name: R.string.localizable.kVideos(), image: R.image.ic_vidoes_icon()!),
            MainDashboardItem(name: R.string.localizable.kEvents(), image: R.image.ic_events_icon()!),
            MainDashboardItem(name: R.string.localizable.kLeadershipBoard(), image: R.image.ic_leadership_icon()!),
            MainDashboardItem(name: R.string.localizable.kChallenges(), image: R.image.ic_challenges_icon()!),
            MainDashboardItem(name: R.string.localizable.kReferFriend(), image: R.image.ic_refer_friend_icon()!)
        ]

        return aMainDashboardItemList
    }
}
