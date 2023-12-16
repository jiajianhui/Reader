//
//  CheckInDetail.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/10.
//

import SwiftUI
import MapKit

struct CheckInDetail: View {
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.top)
    }
}

struct CheckInDetail_Previews: PreviewProvider {
    static var previews: some View {
        CheckInDetail(region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 39.9055,
                longitude: 116.3937
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        ))
    }
}
