//
//  RequestInvokeModel.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/25.
//

import Foundation
import WCDBSwift

struct RequestInvokeModel: TableDecodable,TableEncodable {
    
    var invokeTime: String? = nil
    var invokeResult: String? = nil
        
    enum CodingKeys: String, CodingTableKey {
        typealias Root = RequestInvokeModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case invokeTime
        case invokeResult
    }

    var isAutoIncrement: Bool = true // 用于定义是否使用自增的方式插入
    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
}
