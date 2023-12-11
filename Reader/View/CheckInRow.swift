//
//  CheckInRow.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import SwiftUI
import MapKit


struct CheckInRow: View {
    
    @State var region: MKCoordinateRegion
    var date: String
    
    @EnvironmentObject var locationManager: LocationManager
    @State var city: String = ""
    
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
                Text(date)
                    .font(.title3)
            }
        }
        .onAppear {
            locationManager.lookUpCurrentLocation(
                //将坐标转为CLLocation类型
                location: CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
            )
            { placemark in
                //将获得的城市信息赋值给city
                city = placemark?.locality ?? ""
            }
        }
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
            date: "日期")
    }
}
