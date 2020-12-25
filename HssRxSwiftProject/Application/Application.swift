//
//  Application.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import UIKit

final class Application: NSObject {
    
    static let shared = Application()
    
    var window: UIWindow?
    
    var provider: Api?
    let navigator: Navigator
    private override init() {
        navigator = Navigator.default
        super.init()
        updateProvider()
    }
    func updateProvider(){
        let githubProvider = GithubNetworking.defaultNetworking()
        let restApi = RestApi.init(githubProvider: githubProvider)
        self.provider = restApi
        
    }
    
    func presentInitialScreen(in window: UIWindow?){
        updateProvider()
        guard let window = window else { return }
        self.window = window
        
        let viewModel = HomeViewModel.init(provider: provider!)
        self.navigator.show(segue: .home(viewModel: viewModel), sender: nil, transition: .root(in: window))
        
    }
}
