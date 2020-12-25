//
//  InvokeHistoryTableViewCell.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/25.
//

import UIKit


class InvokeHistoryTableViewCell: TableViewCell {
    
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.black
        return lab
    }()

    override func makeUI() {
        super.makeUI()
        
        self.contentView.addSubview(timeLab)
        timeLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(16)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(16)
        }
        
    }
    
    override func bind(to viewModel: TableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? InvokeHistoryTableCellViewModel else { return }
        viewModel.time.asDriver().drive(timeLab.rx.text).disposed(by: rx.disposeBag)
    }

}
