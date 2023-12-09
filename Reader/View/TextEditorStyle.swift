//
//  tesss.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/7.
//

import SwiftUI

struct TextEditorStyle: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 300, height: 300)
            TextEditor(text: .constant("Home"))
                .transparentScrolling()
                .padding()
                .background(Color.black.opacity(0.08).cornerRadius(10))
            Rectangle()
                .frame(width: 300, height: 300)
        }
        .padding()
            
    }
}

public extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}

struct tesss_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorStyle()
    }
}
