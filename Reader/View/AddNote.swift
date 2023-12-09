//
//  AddNote.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/7.
//

import SwiftUI
import ImagePickerView  //第三方库

struct AddNote: View {
    
    //用户数据
    @State var titleValue = ""
    @State var contentValue = ""
    
    //viewmodel，唯一真值
    @State var noteData: TabNoteData
    
    //警告
    @State var showAlert = false
    
    //环境变量，关闭当前弹窗
    @Environment(\.dismiss) private var dismiss
    
    
    @State var image: UIImage?
    
    //是否展示photopicker
    @State var showPhotoPicker = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("请输入标题", text: $titleValue)
                    .padding()
                    .background(Color(uiColor: .systemGray6).cornerRadius(12))
                
                //添加图片按钮
                Button {
                    showPhotoPicker.toggle()
                } label: {
                    RoundButton(text: "添加图片", image: "photo")
                        .padding(.vertical)
                        .padding(.bottom, 40)
                }
                .sheet(isPresented: $showPhotoPicker) {
                    ImagePickerView(sourceType: .photoLibrary) { image in
                        self.image = image  //将用户选择的图片赋值给image
                    }
                }

                //显示图片
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .cornerRadius(16)
                }
                
                
                TextEditor(text: $contentValue)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(Color(uiColor: .systemGray6).cornerRadius(12))
            }
            .navigationTitle("新增笔记")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        add()
                    } label: {
                        Text("添加")
                            .bold()
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("取消")
                    }

                }
            }
            //警告弹窗
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("注意"),
                    message: Text("标题和内容不能为空"),
                    dismissButton: .default(Text("知道了"))
                )
            }
            .padding()
        }
        
    }
    
    //添加按钮函数
    private func add() {
        
        //0、如果标题为空或为空格，弹窗警告
        if titleValue.isEmpty {
            
            showAlert.toggle()
            return
        }
        
        //1、生成必要的id
        let id = UUID()
        
        //1.1、存储图片数据
        if let data = image?.pngData() {  //若有图片，将其转为png数据
            noteData.saveImage(id: id, data: data)
        }
        
        
        //2、将数据转为Note结构
        let newNote = Note(
            id: id,
            title: titleValue,
            content: contentValue,
            imageURLAppendix: image == nil ? nil : "\(id).png"  //防止用户不添加图片的情况，否则会crash
        )
        
        //3、写入数据
        noteData.notes.append(newNote)
        
        //4、保存数据
        noteData.saveNotes()
        
        //5、清空已输入内容
        titleValue = ""
        contentValue = ""
        image = nil
        
        //6、关闭sheet
        dismiss()
    }
}

struct Sheet_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(noteData: TabNoteData())
    }
}
