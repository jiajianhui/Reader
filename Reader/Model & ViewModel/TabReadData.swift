//
//  Data.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/4.
//

import Foundation

// MARK: - model
//文章列表的数据结构
struct Article: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
}


// MARK: - viewmodel
//遵循ObservableObject协议，使其变为数据来源
class TabReadData: ObservableObject {
    //将获取的数据发布出去
    @Published var articles: [Article] = []
    
    init () {
        let url = URL(string: "https://www.legolas.me/s/articles.json")!
        
        //因为网速有快有慢，所以URLSession在其它线程中运行
        URLSession.shared.dataTask(with: url) { data, response, error in
            //数据下载完成后，手动将任务放回主队列
            DispatchQueue.main.async {
//                self.articles = try! JSONDecoder().decode([Article].self, from: data!)
            }
        }.resume()
    }
    
}
