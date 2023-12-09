//
//  AddNoteAndNoteList.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/7.
//

import SwiftUI

struct AddNoteAndNoteList: View {
    
    //初始化数据
    @StateObject var noteData = TabNoteData()
    
    @State var titleValue = ""
    @State var contentValue = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            //存储数据
            VStack {
                VStack(spacing: 20) {
                    TextField("请输入标题", text: $titleValue)
                    TextField("请输入内容", text: $contentValue)
                }
                .textFieldStyle(.roundedBorder)
                
                Button {
                    print(noteData.notes)
                    //01- 生成必要id
                    let id = UUID()
                    
                    //02- 将输入内容封装为Note类型
                    let newNote = Note(id: id, title: titleValue, content: contentValue)
                    
                    //03- 将新数据放入已发布的数组中
                    noteData.notes.append(newNote)
                    
                    //04- 保存数据
                    noteData.saveNotes()
                    
                    //05- 清空输入框
                    titleValue = ""
                    contentValue = ""
                    
                } label: {
                    RoundButton(text: "添加笔记", image: "heart.fill", minHeight: 50, minWidth: 260, shadowOpacity: 0)
                }
            }
            
            
            //读取本地数据
            List {
                ForEach(noteData.notes) { note in
                    VStack {
                        Text(note.title)
                            .font(.title)
                        Text(note.content)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: delete)
            }
//            List(noteData.notes) { note in
//                VStack {
//                    Text(note.title)
//                        .font(.title)
//                    Text(note.content)
//                        .foregroundColor(.secondary)
//                }
//
//            }
//            .listStyle(.plain)
        }
//        .frame(maxWidth: 260)
//        .padding(30)
//        .background(
//            Color.white
//                .cornerRadius(20)
//                .shadow(color: .black.opacity(0.07), radius: 20, x: 0, y: 10)
//        )
        
    }
    
    func delete(at offsets: IndexSet) {
        noteData.notes.remove(atOffsets: offsets)
        noteData.saveNotes()
    }
}

struct AddNoteAndNoteList_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteAndNoteList()
    }
}
