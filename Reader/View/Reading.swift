//
//  Reading.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/6.
//

import SwiftUI

struct Reading: View {
    //展示sheet
    @State var showSheet = false
    
    //初始化数据
    @StateObject var noteData = TabNoteData()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(noteData.notes) { note in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.title)
                            Text(note.content)
                                .lineLimit(2)
                                .foregroundColor(Color(uiColor: .gray))
                        }
                        Spacer()
                        
                        if note.imageURLAppendix != nil {
                            Image(uiImage: noteData.getImage(note.imageURLAppendix!))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 44, height: 44)
                                .cornerRadius(10)
                        }
                    }
                    
                }
                
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("阅读笔记")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Drums()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Vibration.selection.vibration()
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddNote(noteData: noteData)
            }
        }
    }
    
    //删除函数
    private func delete(atOffsets: IndexSet) {
        noteData.notes.remove(atOffsets: atOffsets)
        noteData.saveNotes()
    }
}

struct Reading_Previews: PreviewProvider {
    static var previews: some View {
        Reading()
    }
}
