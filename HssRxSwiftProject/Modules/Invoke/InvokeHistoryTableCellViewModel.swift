//
//  InvokeHistoryTableViewModel.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/25.
//

import UIKit
import RxSwift
import RxCocoa


class InvokeHistoryTableCellViewModel: TableViewCellViewModel {
    
    let time = BehaviorRelay<String?>(value: nil)
    
    let invokeHistory: RequestInvokeModel
    
    init(with invokeHistory: RequestInvokeModel) {
        self.invokeHistory = invokeHistory
        super.init()
        time.accept(invokeHistory.invokeTime)
    }
}
