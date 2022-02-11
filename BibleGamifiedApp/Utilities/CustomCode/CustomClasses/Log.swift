//
//  Log.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 3:44 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  

import Foundation

/// This is the default print function
internal func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        var index = items.startIndex
        repeat {
            Swift.print(items[index], separator: separator, terminator: index == (items.endIndex - 1) ? terminator: separator)
            index += 1
        } while index < items.endIndex
    #endif

}

/// Log
public struct Log {

    /// This method will print the console log.
    ///
    /// - Parameter data: Data which you wanted to Print.
    static func console(_ data: Any) {
        #if DEBUG
            print(data)
        #endif
    }

}

class Logger {

    //    @discardableResult
    //    init() {
    //
    //        // add log destinations. at least one is needed!
    //        let console = ConsoleDestination()  // log to Xcode Console
    //
    //        #if DEBUG
    //        // debug only code
    //
    //        #else
    //        // release only code
    //
    //
    //        console.minLevel = .warning // just log  .warning & .error
    //
    //        let file = FileDestination()  // log to default swiftybeaver.log file
    //
    //        if var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    //            url.appendPathComponent("respa_yoga_application.log")
    //            print("url:: ", url)
    //            file.logFileURL = url
    //        }
    //
    //        log.addDestination(file)
    //
    //        #endif
    //
    //
    //        // add the destinations to SwiftyBeaver
    //        log.addDestination(console)
    //
    //    }

    class func log(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line) {

        #if DEBUG

        let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
        //        let queue = Thread.isMainThread ? "UI": "BG"
        let gFormatter = DateFormatter()
        gFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS Z"
        let timestamp = gFormatter.string(from: Date())

        items.forEach { item in
            //            Swift.print(">>> \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(item)", separator: separator, terminator: terminator)
            Swift.print("\(timestamp) | \(fileURL) > \(function)[\(line)]: \(item)", separator: separator, terminator: terminator)
        }

        #endif

    }

}
