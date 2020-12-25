//
//  RestApi.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import Foundation
import Moya
import RxSwift
import RxCocoa


typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case serverError(response: ErrorResponse)

    var title: String {
        switch self {
        case .serverError(let response): return response.message ?? ""
        }
    }

    var description: String {
        switch self {
        case .serverError(let response): return response.detail()
        }
    }
}

class RestApi: Api {
    let githubProvider: GithubNetworking
    
    init(githubProvider: GithubNetworking){
        self.githubProvider = githubProvider
    }
}


extension RestApi{
    func apiGithub() -> Observable<String>{
        return githubProvider.request(.apiGithub)
            .mapString()
    }
}
