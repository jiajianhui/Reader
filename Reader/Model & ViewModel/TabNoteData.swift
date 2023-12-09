//
//  TabNoteData.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/7.
//

import Foundation
import SwiftUI


//MARK: - model
//数据需要在存取过程中进行 JSON 编码与解码，因此标注为遵守 Codable；此数据需要在 SwiftUI 中以列表的方式显示给用户，因此标注遵守 Identifiable
struct Note: Identifiable, Codable {
    var id: UUID
    var title: String
    var content: String
    
    //图片名称与扩展名
    var imageURLAppendix: String?  //这里只存着图片的名称及后缀
    
}

//MARK: - viewmodel
class TabNoteData: ObservableObject {
    
    @Published var notes: [Note] = []
    
    
    // 01- 获取该应用的默认沙盒地址；使用static将其变为类型属性，方便后面调用
        //for查找存储文件的沙盒地址、in指的是用户可存储空间
        //返回为地址数组，用[0]从数组中提取该地址；通常情况下，一个应用程序只有一个文档目录（存储文件的沙盒地址），因此我们只需要获取第一个URL即可
    static let sandboxURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    
    // 02- 拼接路径，作为json数据的存取地址
    let notesURL = sandboxURL.appendingPathComponent("notes.json") //将沙盒地址与notes.json连接在一起
    
    
    
    init() {
        //启动时先从本地拿数据，若有则赋值给notes
        notes = getNotes()
    }
    
    
    
    //读取本地json数据
    func getNotes() -> [Note] {
        
        //1、准备空数组
        var result:[Note] = []
        
        //2、如果文件中存在该应用的json数据，则读取该文件，并将解码数据赋值给result并返回
        if FileManager.default.fileExists(atPath: notesURL.path) {
            let data = try! Data(contentsOf: notesURL) //读取指定URL的数据并将其转换为Data对象
            result = try! JSONDecoder().decode([Note].self, from: data)  //解码并赋值
        }
        
        //3、返回
        return result
    }
    
    
    
    //存储用户数据，将用户数据转为json，然后保存至本地
    func saveNotes() {
        
        //存储过程较为耗时，将该任务放在后台线程中进行，.userInitiated指的是用户发起的后台任务，系统会优先完成
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? JSONEncoder().encode(self.notes)  //尝试将notes编码为json、
            try? data?.write(to: self.notesURL)  //2、尝试将json数据写入存放json的文件里
        }
    }
    
    //MARK: 单独处理图片类型，图片信息不存储在json中
    //读取图片
    func getImage(_ imageURLAppendix: String) -> UIImage {  //参数为图片名称及扩展名
        
        let url = TabNoteData.sandboxURL.appendingPathComponent(imageURLAppendix) //该图片的地址（将图片名称及后缀（参数）与沙盒地址拼接）
        
        //Data(contentsOf: url)用于读取指定URL的数据并将其转换为Data对象；适用于读取本地文件，获取网络时，推荐使用URLSession
        let imageData = try! Data(contentsOf: url)  //判断链接中是否有数据
        
        return UIImage(data: imageData, scale: 1)! //通过UIImage自带的初始化器创建图片，scale指的是缩放倍率（必须大于等于1）
    }
    
    //存储图片
    func saveImage(id: UUID, data: Data) {  //id作为图片的唯一名称
        DispatchQueue.global(qos: .userInitiated).async {
            let url = TabNoteData.sandboxURL.appendingPathComponent("\(id).png")  //生成图片地址
            try? data.write(to: url) //将图片信息写入该地址
        }
    }
}
