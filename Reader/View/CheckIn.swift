//
//  CheckIn.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import SwiftUI
import MapKit

struct CheckIn: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $locationManager.region)
//            .edgesIgnoringSafeArea(.all)
    }
}

struct CheckIn_Previews: PreviewProvider {
    static var previews: some View {
        CheckIn()
    }
}
