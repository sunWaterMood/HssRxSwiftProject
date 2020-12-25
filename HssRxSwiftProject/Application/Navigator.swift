//
//  Navigator.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/23.
//

import UIKit
import Hero

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {

    static var `default` = Navigator()
    
    // MARK: - segues list, all app scenes
    
    enum Scene {
        case home(viewModel: HomeViewModel)
        case invokeHistory(viewModel: InvokeHistoryViewModel)
    }
    
    enum Transition{
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
    }
    
    func get(segue: Scene) -> UIViewController?{
        switch segue {
        case .home(let viewModel):
            return HomeNavigationController(rootViewController: HomeViewController(viewModel: viewModel, navigator: self))
        case .invokeHistory(let viewModel):
            return InvokeHistoryViewController(viewModel: viewModel, navigator: self)
        }
    }
    
    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        default: break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }

        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        default: break
        }
    }
}
