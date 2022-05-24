//
//  CustomAnnotation.swift
//  EatDa
//
//  Created by 김나희 on 5/20/22.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525)
    var categoryId: Int = 0
    
    override init() {
        super.init()
    }
    
    init(coordinate: CLLocationCoordinate2D, categoryId: Int) {
        self.coordinate = coordinate
        self.categoryId = categoryId
    }
    
    func getCategoryId() -> Int {
        return categoryId
    }
}
