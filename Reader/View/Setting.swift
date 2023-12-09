//
//  Setting.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/5.
//

import SwiftUI

struct Setting: View {
    
    //接收父视图中传递来的值，无需赋值，因为该绑定变量（darkModel）的实质就是父视图中的变量（darkModel）
    @Binding var darkModel: Bool
    
    //接收环境中的数据
    @EnvironmentObject var motionManager: MotionManager
    
    var body: some View {
        Button {
            //震动模块
            Vibration.selection.vibration()
            darkModel.toggle()
        } label: {
            Image(systemName: darkModel ? "sun.max.fill" : "moon.fill")
                .rotation3DEffect(.degrees(Double(motionManager.x * 100)), axis: (x: 0, y: 0, z: 1))
                .rotation3DEffect(.degrees(Double(motionManager.y * 100)), axis: (x: 0, y: 0, z: 1))
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting(darkModel: .constant(false))
            //无实际意义，仅用于画布展示
            .environmentObject(MotionManager())
    }
}
