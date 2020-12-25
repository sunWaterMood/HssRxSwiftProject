//
//  InvokeHistoryViewModel.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/25.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import WCDBSwift

class InvokeHistoryViewModel: ViewModel, ViewModelType {

    struct Input {
        
    }
    struct Output {
        let items: Driver<[InvokeHistoryTableCellViewModel]>
    }
    
    func transform(input: Input) -> Output {
        
        let elements = BehaviorRelay<[InvokeHistoryTableCellViewModel]>(value: [])
        
        self.queryInvokeHistoryList()
            .map { $0.map({ (res) -> InvokeHistoryTableCellViewModel in
                    let viewModel = InvokeHistoryTableCellViewModel(with: res)
                    return viewModel
                })
            }.subscribe(onNext: { (items) in
                elements.accept(items)
            }).disposed(by: rx.disposeBag)
        
        return Output(items: elements.asDriver(onErrorJustReturn: []))
    }
    
    override init(provider: Api) {
        super.init(provider: provider)
    }
    
    func queryInvokeHistoryList() -> Observable<[RequestInvokeModel]>{
        return Observable<[RequestInvokeModel]>.create { observer -> Disposable in
            if let results = DataBaseManager.shared.qureyFromDb(fromTable: Configs.Keys.dbTable, cls: RequestInvokeModel.self){
                observer.onNext(results.reversed())
            }else{
                observer.onNext([])
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
