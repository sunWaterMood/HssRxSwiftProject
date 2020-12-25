//
//  HomeViewModel.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import SwiftDate


class HomeViewModel: ViewModel, ViewModelType{
    struct Input {
        
    }
    struct Output {
        let responseResult: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let responseSubject = ReplaySubject<String>.create(bufferSize: 1)
        
        
        
        self.request().startWith(queryDb()).subscribe { (response) in
            responseSubject.onNext(response)
        }.disposed(by: rx.disposeBag)
        
        let responseSubjectDriver = responseSubject.asDriver(onErrorJustReturn: "")
        
        responseSubjectDriver.drive(onNext: {[weak self] (result) in
            self?.saveDb(result: result)
        }).disposed(by: rx.disposeBag)
        
        return Output(responseResult: responseSubjectDriver)
    }
    
    override init(provider: Api) {
        super.init(provider: provider)
    }
    
    func queryDb() -> String{
        let dbResults = DataBaseManager.shared.qureyFromDb(fromTable: Configs.Keys.dbTable, cls: RequestInvokeModel.self)
        if let last = dbResults?.last,let  invokeResult = last.invokeResult {
            return invokeResult
        }
        return ""
    }
    func saveDb(result: String){
        var invokeModel = RequestInvokeModel()
        invokeModel.invokeResult = result
        invokeModel.invokeTime = Date().toFormat("yyyy-MM-dd HH:mm:ss", locale: Locale.init(identifier: "zh_CN"))
        DataBaseManager.shared.insertToDb(objects: [invokeModel], intoTable: Configs.Keys.dbTable)
    }
    
    func request() -> Observable<String>{
        return Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: SerialDispatchQueueScheduler.init(qos: .default))
            .flatMap({ (event) -> Observable<String> in
                return self.provider.apiGithub()
                    .trackActivity(self.loading)
                    .trackError(self.error)
            })
    }
}
