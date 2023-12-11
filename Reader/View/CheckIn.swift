//
//  CheckIn.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import SwiftUI
import MapKit

struct CheckIn: View {
    //接收环境中的数据
    @EnvironmentObject var locationManager: LocationManager
    
//    @StateObject var locationManager = LocationManager()  在页面中创建实例，会造成卡顿，建议在ReaderApp中完成实例化
    
    //从环境中拿到viewContext来读取数据库；viewContext是数据库中介，负责数据的增删
    @Environment(\.managedObjectContext) var viewContext
    
    //1、 ！自动！向数据库发送请求（有数据变化立马返回），将返回的结果赋值给FetchedResults（下面的变量checkIns）
    @FetchRequest(
        //将返回的数据按时间（timestamp）降序（ascending）排序
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.timestamp, ascending: false)],
        animation: .default
    )
    //2、 该变量存储签到数据Entity
    var checkIns: FetchedResults<Entity>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(checkIns) { checkIn in
                    NavigationLink {
                        CheckInDetail(region: MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: checkIn.latitude,
                                longitude: checkIn.longitude
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        ))
                    } label: {
                        CheckInRow(
                            region: MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: checkIn.latitude,
                                    longitude: checkIn.longitude
                                ),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.01,
                                    longitudeDelta: 0.01
                                )
                            ),
                            date: displayDate(checkIn.timestamp!),
                            city: checkIn.city ?? ""
                        )
                    }
                }
                .onDelete(perform: removeCheckIn)
            }
            .navigationTitle("打卡签到")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Vibration.selection.vibration()
                        newCheckIn()
                    } label: {
                        Text("签到")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        
    }
    
    //新增签到
    func newCheckIn() {
        //新的数据实体
        let new = Entity(context: viewContext)
        //赋值
        new.timestamp = Date()
        new.longitude = locationManager.region.center.longitude
        new.latitude = locationManager.region.center.latitude
        locationManager.lookUpCurrentLocation(
            location: CLLocation(
                latitude: locationManager.region.center.latitude,
                longitude: locationManager.region.center.longitude)
        ) { placemark in
            new.city = placemark?.locality ?? ""
        }
        try? viewContext.save()
//        print(locationManager.region.center.longitude)
//        print(new)
    }
    
    //删除签到
    func removeCheckIn(atOffSets: IndexSet) {
        atOffSets.map { checkIns[$0] }.forEach(viewContext.delete(_:))
        try? viewContext.save()
    }
    
    //定义时间显示格式
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            formatter.locale = Locale(identifier: "zh_Hans")
            formatter.setLocalizedDateFormatFromTemplate("MMMMdd")
            return formatter
    }()
    
    //将时间转换为文本的函数
    func displayDate(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    
    
    
}

struct CheckIn_Previews: PreviewProvider {
    static var previews: some View {
        CheckIn()
    }
}
