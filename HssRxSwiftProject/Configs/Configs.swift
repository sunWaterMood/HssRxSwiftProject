//
//  Configs.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import Foundation

struct Configs {
    struct Network {
        static let loggingEnabled = false
        static let githubBaseUrl = "https://api.github.com"
    }
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let dbPath = Documents + "/HDB/HDB.db"
    }
    struct Keys {
        static let dbTable = "request_log"
    }
}

