//
//  HomeViewController.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import UIKit
import NSObject_Rx
import SnapKit
import RxSwift
import RxCocoa
import Hero

class HomeViewController: ViewController {
    
    lazy var rightBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationTitle = "主页"
        
    }
    
    
    // MARK: private method
    
    override func makeUI(){
        super.makeUI()
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        self.view.addSubview(self.responseTextView)
        self.responseTextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel(){
        super.bindViewModel()
        
        guard let viewModel = viewModel as? HomeViewModel else { return }
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input: input)
        output.responseResult.drive(onNext: {[weak self] (result) in
            self?.responseTextView.attributedText = result.attributedString(font: UIFont.systemFont(ofSize: 14), textColor: UIColor.black, lineSpaceing: 1.5, wordSpaceing: 1.5)
        }).disposed(by: rx.disposeBag)
        
        rightBarButton.rx.tap.subscribe { [weak self](_) in
            self?.navigator.show(segue: .invokeHistory(viewModel: InvokeHistoryViewModel(provider: viewModel.provider)), sender: self, transition: .navigation(type: .fade))
        }.disposed(by: rx.disposeBag)
    }
    
    // MARK: getter
    
    lazy var responseTextView: UITextView = {
        let tv = UITextView.init()
        tv.allowsEditingTextAttributes = false
        return tv
    }()
    
    
    
}
