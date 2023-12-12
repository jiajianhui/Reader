//
//  CheckInRow.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import SwiftUI
import MapKit


struct CheckInRow: View {
    
    @State var region: MKCoordinateRegion  //因为Map需要绑定的参数。所以要用State
    var date: String
    var city: String
    var subCity: String
    
    @Binding var pickerValue: Int //接受父级传来的数据
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        HStack {
            Map(coordinateRegion: $region)
                .frame(width: 100, height: 100)
                .cornerRadius(100)
                .padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 10) {
                Text(city)
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Text(date)
                        .font(.title3)
                    if pickerValue == 1 {
                        Text(subCity)
                            .foregroundColor(.orange)
                    }
                }
            }
        }
        //使用该方法后，快速滚动签到列表时会导致API请求过于频繁，导致API限流；将city数据存储在CoreData数据库中解决此问题
//        .onAppear {
//            locationManager.lookUpCurrentLocation(
//                //将坐标转为CLLocation类型
//                location: CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
//            )
//            { placemark in
//                //将获得的城市信息赋值给city
//                city = placemark?.locality ?? ""
//            }
//        }
    }
}

struct CheckInRow_Previews: PreviewProvider {
    static var previews: some View {
        CheckInRow(
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 39.9055,
                    longitude: 116.3937
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            ),
            date: "日期",
            city: "北京",
            subCity: "name",
            pickerValue: .constant(0))
    }
}
