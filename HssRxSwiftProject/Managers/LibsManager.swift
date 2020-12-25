//
//  LibsManager.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import UIKit
import CocoaLumberjack

class LibsManager: NSObject {
    
    static let shared = LibsManager()
    
    private override init() {
        super.init()
        
    }
    
    
    func setupLibs(with window: UIWindow? = nil){
        self.setupCocoaLumberjack()
        
    }
    
    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
}
