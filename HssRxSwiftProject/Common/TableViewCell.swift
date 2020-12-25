//
//  TableViewCell.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeUI(){
        selectionStyle = .none
        
    }
    
    func bind(to viewModel: TableViewCellViewModel){
        
    }

}
