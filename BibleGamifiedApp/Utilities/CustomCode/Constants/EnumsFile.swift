//
//  Created by BibleGamifiedApp
//  Copyright © BibleGamifiedApp All rights reserved.
//  Created on 02/11/20

import Foundation
import UIKit
import MachO

enum DateTimeFormat: String {
    case wholeWithZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case time = "h:mm a"
    case yyyyMMdd = "yyyy/MM/dd"
    case dateTime = "dd MMM \n h:mm a"
    case dd_MM_yyyy = "dd/MM/yyyy"
    case MM_dd_yy = "MM/dd/yy"
    case wholedateTime = "yyyy-MM-dd HH:mm:ss"
    case yyyy_MM_dd = "yyyy-MM-dd"
    case dd = "dd"
    case EEEMMMdd = "EEE. MMM dd"
    case MM_dd_yyyy = "MM / dd / yyyy"
    case dd_MMMM_yyyy = "dd MMMM yyyy"
    case hh_mm_ss = "HH:mm:ss"
    case hh_mm_a = "hh/mm a"
    case MMMM_dd_yyyy = "MMMM dd yyyy"

    case MMM_yyyy = "MMMM, yyyy"
    case MM_DD_YYYY = "MM/dd/yyyy"

    case MM_yyyy = "MM/yyyy"

    case MMM_dd_yyyy = "MMM dd, yyyy"
    case MMMM_yyyy = "MMMM yyyy"
    case yyyy = "yyyy"
}

public enum RegistationType: String {

    case normal
    case facebook
    case apple

}

/// for button actioin
enum ActionType: String {
    case timeEnd = "timeEnd"
    case timeStart = "timeStart"
}

/// Random Game Need to display 
enum AllGames: Int {
    case dragDrop = 0
    case cardMatch = 1
}

enum DashboardItems: Int {
    case game = 0
    case videos = 1
    case events = 2
    case leadershipboard = 3
    case challanges = 4
    case refer = 5

}
/// Game Rating total -1 ,2 ,3 ,4
enum GameRating: Int {
    case zero = 0 // unclock
    case one = 1 // unclock
    case two = 2// unclock
    case three = 3 // unclock

    func getTitle() -> String {
        switch self {
        case .zero:
            return "BETTER LUCK"

        case .one:
            return "GOOD"

        case .two:
            return "EXCELLENT"

        case .three:
            return "OUTSTANDING"

        }
    }
}

enum Gametype: String {
    case dragDrop = "drag_drop"
    case cardMatch = "match_card"
}

enum CharLimit: Int {
    case fullName  = 20
    case fullNameMin  = 3
}

enum PurcaseType: String {
    case Star = "Star"
    case Paid = "Paid"

}
