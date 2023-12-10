//
//  CloudData.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import Foundation

//1、 引入CoreData框架
import CoreData

struct CloudData {

    //2、 自身初始化
    static let shared = CloudData()

    //3、 定义新变量，支持本地和网络存储的数据容器
    let container: NSPersistentContainer  //默认类型为私密，每个用户存取自己放入的数据，同一应用不同用户间数据不共享

    //4、 初始化container
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Reader")  //创建容器，名称必须为数据模型的名字!!!

        //以下为模版代码
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _,_ in })
    }
}



