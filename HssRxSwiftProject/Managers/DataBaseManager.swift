//
//  DataBaseManager.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/25.
//

import UIKit
import WCDBSwift

class DataBaseManager: NSObject {
    
    static let shared = DataBaseManager()
    
    let dataBasePathUrl = URL.init(fileURLWithPath: Configs.Path.dbPath)
    
    var dataBase: Database?
    
    private override init() {
        super.init()
        dataBase = createDb()
        if let canOpen = dataBase?.canOpen, canOpen == true{
            self.createTable(table: Configs.Keys.dbTable, of: RequestInvokeModel.self)
        }
    }
    
    //创建db
    private func createDb() -> Database{
        return Database(withFileURL: dataBasePathUrl)
    }
    
    //创建表
    func createTable<T: TableDecodable>(table: String, of ttype:T.Type){
        do {
            try dataBase?.create(table: table, of: ttype)
        } catch let error {
            logDebug("create table error \(error.localizedDescription)")
        }
    }
    
    // 插入数据
    func insertToDb<T: TableEncodable>(objects: [T], intoTable table: String){
        do {
            try dataBase?.insert(objects: objects, intoTable: table)
        } catch let error {
            logDebug("insertToDb error \(error.localizedDescription)")
        }
    }
    // 修改
    func updateToDb<T: TableEncodable>(table: String, on propertys: [PropertyConvertible], with object:T,where condition: Condition? = nil){
        do {
            try dataBase?.update(table: table, on: propertys, with: object,where: condition)
        } catch let error {
            logDebug("updateToDb error \(error.localizedDescription)")
        }
    }
    //删除
    func deleteFromDb(fromTable: String, where condition: Condition? = nil){
        do {
            try dataBase?.delete(fromTable: fromTable, where: condition)
        } catch let error {
            logDebug("deleteFromDb error \(error.localizedDescription)")
        }
    }
    //查询
    func qureyFromDb<T: TableDecodable>(fromTable: String, cls cName: T.Type, where condition: Condition? = nil, orderBy orderList:[OrderBy]? = nil) -> [T]? {
        do {
            let allObjects: [T] = try (dataBase?.getObjects(fromTable: fromTable, where:condition, orderBy:orderList))!
            logDebug(" qureyFromDb \(allObjects)");
            return allObjects
        } catch let error {
            logDebug("qureyFromDb error \(error.localizedDescription)")
        }
        return nil
    }
    //删除数据表
    func dropTable(table: String) -> Void {
        do {
            try dataBase?.drop(table: table)
        } catch let error {
            logDebug("dropTable error \(error)")
        }
    }
        
    // 删除所有与该数据库相关的文件
    func removeDbFile() -> Void {
        do {
            try dataBase?.close(onClosed: {
                try dataBase?.removeFiles()
            })
        } catch let error {
            logDebug("removeDbFile error \(error)")
        }
        
    }
}
