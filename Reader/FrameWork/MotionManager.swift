//
//  MotionManager.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/5.
//

import Foundation
import SwiftUI
import CoreMotion

//遵循ObservableObject协议，SwiftUI将这个类当作数据来源，这样当传感器数据变化时，发布出的内容会自动更新
class MotionManager: ObservableObject {
    //从Core Motion获取信息需要经过一个中介CMMotionManager()，即Core Motion框架管理员
    let motionManager = CMMotionManager()
    
    @Published var x: CGFloat = 0
    @Published var y: CGFloat = 0
    @Published var z: CGFloat = 0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { data, _ in
            guard let tilt = data?.gravity else {return}
            
            self.x = CGFloat(tilt.x)
            self.y = CGFloat(tilt.y)
            self.z = CGFloat(tilt.z)
        }
    }
    
}
