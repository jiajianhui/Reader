//
//  Detail.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/5.
//

import SwiftUI

struct ReadingDetail: View {
    
    var article: Article
    
    var body: some View {
        ScrollView {
            Text(article.body)
                .lineSpacing(10)
                .padding(.horizontal)
        }
        .navigationTitle(article.title)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        ReadingDetail(article: Article(id: 0, title: "你好", body: "世界"))
    }
}
