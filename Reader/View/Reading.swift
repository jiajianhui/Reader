//
//  ContentView.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/4.
//

import SwiftUI

struct Reading: View {
    
    //初始化Data并交由SwiftUI管理存储，将model与视图绑定起来
    //Data 遵循 ObservableObject 协议，可以在视图中用 articles 来读取这些数据。
    @StateObject var data = TabReadData()
    
    //主题切换
    //将该变量永久存储，"darkModel"作为应用存储的钥匙，darkModel是获取该钥匙的变量名
    @AppStorage("darkModel") var darkModel = false
    
    var body: some View {
        NavigationView {
            List(data.articles) { article in
                NavigationLink {
                    ReadingDetail(article: article)
                } label: {
                    ReadingRow(article: article)
                }
            }
            .listStyle(.plain)
            .navigationTitle("编辑推荐")
            .toolbar {
                ColorTheme(darkModel: $darkModel)
            }
        }
        //环境修改器的快捷写法
        .preferredColorScheme(darkModel ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Reading()
    }
}


