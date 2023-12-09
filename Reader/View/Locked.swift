//
//  Locked.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/5.
//

import SwiftUI

struct Locked: View {
    //跨视图传递方法时，只需写明类型即可；与传递变量一样
    //用于接收父视图传递来的函数
    var authorize: () ->()
    
    var body: some View {
        Button {
            Vibration.light.vibration()
            authorize()
        } label: {
            VStack {
                Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 10)
                Text("轻点解锁")
                    .font(.headline)
            }
            .foregroundColor(.secondary)
        }
    }
}

struct Locked_Previews: PreviewProvider {
    static var previews: some View {
        Locked(authorize: test)
    }
    
    //仅供测试
    static func test() {
        print("test")
    }
}
