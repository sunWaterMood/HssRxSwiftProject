//
//  GithubAPI.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import Foundation
import Moya
import RxSwift

enum GithubAPI {
    case apiGithub
}

extension GithubAPI: TargetType{
    var baseURL: URL {
        return URL.init(string: Configs.Network.githubBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .apiGithub:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var parameters: [String: Any]? {
        let params: [String: Any] = [:]
        return params
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    

}
