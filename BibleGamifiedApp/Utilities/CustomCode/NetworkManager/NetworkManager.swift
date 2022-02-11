//
//  NetworkManager.swift
//  XMPPDemo
//
//  Created by BibleGamifiedApp on 29/01/21.
//  Copyright © 2021 BibleGamifiedApp. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

extension NSNotification.Name {
    /// Time Out Interaction
    public static let TimeOutUserInteraction: NSNotification.Name = NSNotification.Name(rawValue: "TimeOutUserInteraction")

    public static let NetworkAvailable: NSNotification.Name = NSNotification.Name(rawValue: "NetwrokAvailable")

    public static let DownloadFilesupdated: NSNotification.Name = NSNotification.Name(rawValue: "DownloadFilesupdated")

    public static let bleDisconnectedState: NSNotification.Name = Notification.Name("bleDisconnectedState")

}

class NetworkManager {

    static let shared = NetworkManager()
    var emptyCartView: UIView?
    var isNoInternetPresented = false

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
                if !self.isNoInternetPresented {

                }
            case .unknown :
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                self.networkRechable()
                print("The network is reachable over the WiFi connection")

            case .reachable(.cellular):
                self.networkRechable()
                print("The network is reachable over the cellular connection")

            }
        })
    }
    func networkRechable() {
        self.isNoInternetPresented = false

        NotificationCenter.default.post(name: .NetworkAvailable, object: nil)
    }

}
