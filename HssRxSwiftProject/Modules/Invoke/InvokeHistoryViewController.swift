

import UIKit
import RxSwift
import LYEmptyView

class InvokeHistoryViewController: ViewController {
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        table.register(InvokeHistoryTableViewCell.self, forCellReuseIdentifier: "InvokeHistoryTableViewCell")
        table.rowHeight = 44
        table.tableFooterView = UIView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitle = "调用历史记录"
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        
        
        let emptyView: LYEmptyView  = LYEmptyView.empty(withImageStr: "暂无内容", titleStr: "没有相关内容哦", detailStr: "")
        emptyView.titleLabTextColor = UIColor.gray
        emptyView.titleLabFont = UIFont.systemFont(ofSize: 13)
        tableView.ly_emptyView = emptyView
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? InvokeHistoryViewModel else { return }
        
        let output = viewModel.transform(input: InvokeHistoryViewModel.Input())
        output.items.drive(tableView.rx.items(cellIdentifier: "InvokeHistoryTableViewCell", cellType: InvokeHistoryTableViewCell.self)){
            tableView, viewModel, cell in
            cell.bind(to: viewModel)
        }.disposed(by: rx.disposeBag)
    }


}
