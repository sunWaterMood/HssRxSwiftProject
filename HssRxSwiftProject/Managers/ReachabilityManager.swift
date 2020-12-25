//
//  ReachabilityManager.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import Foundation
import RxSwift
import Alamofire

func connectedToInternet() -> Observable<Bool> {
    return ReachabilityManager.shared.reach
}

class ReachabilityManager: NSObject{
    static let shared = ReachabilityManager()
    
    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    var reach: Observable<Bool>{
        return reachSubject.asObserver()
    }
    
    override init() {
        super.init()
        
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
            switch status{
                case .notReachable:
                    self.reachSubject.onNext(false)
                case .reachable:
                    self.reachSubject.onNext(true)
                case .unknown:
                    self.reachSubject.onNext(false)
            }
        })
    }
}
