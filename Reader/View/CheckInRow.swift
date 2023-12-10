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
    
    var body: some View {
        HStack {
            Map(coordinateRegion: $region)
                .frame(width: 100, height: 100)
                .cornerRadius(100)
                .padding(.trailing, 10)
            Text(date)
                .font(.title)
                .fontWeight(.semibold)
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
