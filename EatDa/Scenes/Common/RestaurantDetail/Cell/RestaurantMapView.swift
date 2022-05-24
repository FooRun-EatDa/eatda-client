//
//  RestaurantMapView.swift
//  EatDa
//
//  Created by 김나희 on 5/24/22.
//

import UIKit
import SnapKit
import MapKit

class RestaurantMapView: UIView, MKMapViewDelegate {
    let mapView = MKMapView()
    var coordinate = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525)
    var categoryID = 0

    
    init(restaurantCoordinate: CLLocationCoordinate2D, categoryID: Int) {
        super.init(frame: .zero)
        self.addSubview(mapView)

        self.coordinate = restaurantCoordinate
        self.categoryID = categoryID
        mapView.delegate = self
        
        setupLayout()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        let pin = CustomAnnotation(coordinate: coordinate, categoryId: categoryID)
        mapView.addAnnotation(pin)
    }
    
    func setupLayout() {
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")

            if annotation is CustomAnnotation {
                let annotation = annotation as! CustomAnnotation
                switch (annotation.getCategoryId()) {
                case 0:
                    annotationView?.image = UIImage(named: "yellow_annotation")
                    break
                case 1:
                    annotationView?.image = UIImage(named: "red_annotation")
                    break
                default:
                    break
                }
            }
        }
        return annotationView
    }
}
