//
//  Drums.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/13.
//

import SwiftUI
import CoreHaptics

struct Drums: View {
    
    //1、创建负责与UI交互的中介变量
    @State var engine: CHHapticEngine?
    
    var body: some View {
        Button {
            creatHaptics()
            playHapticsFile(filename: "AHAP/Drums")
            
        } label: {
            Image(systemName: "wand.and.stars")
        }

    }
    
    //2、检测设备是否支持线性马达，然后初始化、启动
    func creatHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do {
            self.engine = try CHHapticEngine()  //初始化
            try engine?.start()  //启动
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    //3、获取并播放对应AHAP文件
    func playHapticsFile(filename: String) {
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {return} //获取本地AHAP文件
        
        do {
            try engine?.playPattern(from: URL(fileURLWithPath: path))  //播放震动
        } catch  {
            print(error.localizedDescription)
        }
    }
}

struct Drums_Previews: PreviewProvider {
    static var previews: some View {
        Drums()
    }
}
