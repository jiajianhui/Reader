//
//  Row.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/4.
//

import SwiftUI

struct Row: View {
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.custom("H-SiuNiu-Regular", size: 28))
                .fontWeight(.bold)
                .padding(.bottom, 6)
            Text(article.body)
//                .font(.custom("H-SiuNiu-Regular", size: 20))
                .foregroundColor(.gray)
                .lineLimit(3)
//                .lineSpacing(10)
        }
        .padding(.vertical, 6)
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(article: Article(id: 0, title: "你好", body: "世界"))
    }
}
