//
//  TimeView.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import SwiftUI

struct TimeView: View {
    
    //从环境中拿到viewContext
    @Environment(\.managedObjectContext)  var viewContext
    
    //1、 从数据库中读取数据
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestate, ascending: true)], animation: .default)
    //2、 将提取到的数据赋值给times
    var times: FetchedResults<Item>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(times) { time in
                    Text("\(time.timestate!, formatter: itemFormatter)")
                }
            }
            .navigationTitle("时间")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addTime()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
    
    //新增时间函数
    func addTime() {
        //1、新建数据实体
        let newTime = Item(context: viewContext)
        
        //2、 赋值
        newTime.timestate = Date()
        
        //3、 保存
        try? viewContext.save()
    }
    
    //时间格式化
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView()
    }
}
