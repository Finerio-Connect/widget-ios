//
//  Log.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

func >= (levelA: LogLevel, levelB: LogLevel) -> Bool {
    return levelA.rawValue >= levelB.rawValue
}

func log(_ log: String) {
    print("FinerioConnectWidget :: " + log)
}

func logInfo(_ message: String) {
    guard Configuration.shared.logLevel >= .info else { return }

    log(message)
}

func logWarn(_ message: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard Configuration.shared.logLevel >= .error else { return }

    let caller = "\(filename.lastPathComponent)(\(line)) \(funcname)"
    log("⚠️⚠️⚠️ WARNING: " + message)
    log("⚠️⚠️⚠️ ⤷ FROM CALLER: " + caller + "\n")
}

func logError(_ error: NSError?, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard
        Configuration.shared.logLevel >= .error,
        let err = error
    else { return }

    if let code = error?.code, code == 401 || code == 402 {
        log("Invalid credentials!!")
        return
    }

    let caller = "\(filename.lastPathComponent)(\(line)) \(funcname)"
    log("‼️‼️‼️ ERROR: " + err.localizedDescription)
    log("‼️‼️‼️ ⤷ FROM CALLER: " + caller)
    log("‼️‼️‼️ ⤷ USER INFO: \(err.userInfo)\n")
}
