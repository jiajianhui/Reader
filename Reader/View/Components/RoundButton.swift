//
//  RoundButton.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/6.
//

import SwiftUI

struct RoundButton: View {
    
    var text: String
    var image: String = ""
    
    var minHeight: CGFloat = 60
    var minWidth: CGFloat = 300
    
    var shadowOpacity: CGFloat = 0.3
    
    
    var body: some View {
        HStack {
            Text(text)
                .bold()
            Image(systemName: image)
        }
        .font(.title2)
        .foregroundColor(.white)
        .frame(minWidth: minWidth, minHeight: minHeight)
        .background(Color.orange.cornerRadius(10))
        .shadow(color: .orange.opacity(shadowOpacity), radius: 20, x: 0, y: 10)
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton(text: "hello", image: "heart")
    }
}
