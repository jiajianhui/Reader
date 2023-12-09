//
//  ReaderApp.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/4.
//

import SwiftUI

//导入本地身份识别模块
import LocalAuthentication

@main
struct ReaderApp: App {
    
    //判断是否显示页面
    @State var locked = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if locked {
                    //将函数传递下去，传函数名即可，无需加括号
                    Locked(authorize: authorize)
                } else {
                    TabView {
                        Master()
                            .environmentObject(MotionManager())
                            .tabItem {
                                Image(systemName: "list.star")
                                Text("编辑推荐")
                            }
                        Reading()
                            .tabItem {
                                Image(systemName: "pencil.and.outline")
                                Text("阅读笔记")
                            }
                        CheckIn()
                            .tabItem {
                                Image(systemName: "location")
                                Text("签到")
                            }
                    }
                    .background(Material.ultraThick)
                }
            }
            .onAppear {
                authorize()
            }
        }
    }
    
    //验证函数
    func authorize() {
        let context = LAContext()  //开发者与LocalAuthentication框架之间的中介
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {  //判断设备是否具备硬件支持
            //判断验证是否通过，结果存储在result中
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "解锁应用") { result, _ in
                //验证通过后执行该代码
                if result {
                    locked = false
                }
            }
        }
    }
}
