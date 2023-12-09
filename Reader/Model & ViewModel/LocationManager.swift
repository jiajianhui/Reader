//
//  LocationManager.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/9.
//

import Foundation
import CoreLocation  //提供地理位置
import Combine  //负责推送数据更新
import MapKit  //让位置信息通过SwiftUI显示出来


//遵循NSObject是基于历史原因
//遵循ObservableObject作为SwiftUI的数据源
//遵循CLLocationManagerDelegate让数据保持更新，该协议包括一个数据更新时需要做什么的函数 locationManager(_: didUpdateLocations:)
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //1、 框架中介
    let locationManager = CLLocationManager()  //中介——CLLocationManager
    
    //2、 经纬度；由MapKit接管
    @Published var region = MKCoordinateRegion(  //MKCoordinateRegion来源于MapKit，作用是指明区域，包含经纬度
        center: CLLocationCoordinate2D(  //经纬度
            latitude: 39.9055,
            longitude: 116.3937
        ),
        span: MKCoordinateSpan(  //显示范围，数值越小，显示范围越小（放大地图）
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )
    
    
    //3、 启动方法
    override init() {
        super.init()
        locationManager.delegate = self  //中介为我们服务
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //告诉中介提供准确位置信息
        locationManager.requestWhenInUseAuthorization()  //当用户未授权时，弹出授权弹窗
        locationManager.startUpdatingLocation()  //开始更新位置信息
    }
    
    //4、 数据更新时进行赋值
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //4.1、 判断是否有值，每次地理位置变化时，locations.last会传递出最新数据
        guard let location = locations.last else {return}
        
        //4.2 赋值
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    }
}


