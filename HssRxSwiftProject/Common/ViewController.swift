//
//  ViewController.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import UIKit
import RxSwift


class ViewController: UIViewController,Navigatable {

    var viewModel: ViewModel?
    var navigator: Navigator!
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.makeUI()
        self.bindViewModel()
    }
    
    // MARK: private method

    func makeUI() {
        
    }

    func bindViewModel(){
        
    }
}
