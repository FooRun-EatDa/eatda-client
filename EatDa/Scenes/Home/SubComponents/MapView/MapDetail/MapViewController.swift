//
//  MapViewController.swift
//  EatDa
//
//  Created by 김나희 on 5/17/22.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa
import SnapKit

class MapViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let mapView = MapView()
    let initialCoordinate = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525)
    let initialCoordinate2 = CLLocationCoordinate2D(latitude: 37.23296, longitude: 127.0800525)
    let locationManager = CLLocationManager()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization() //권한 요청
        mapView.map.setRegion(MKCoordinateRegion(center: initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        mapView.map.setRegion(MKCoordinateRegion(center: initialCoordinate2, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)

                
        mapView.map.delegate = self
        locationManager.delegate = self
        
        addCustomPin()
        buttonActions()
        
    }

    private func addCustomPin() {
        let pin = CustomAnnotation(coordinate: initialCoordinate, categoryId: 0)
        let pin2 = CustomAnnotation(coordinate: initialCoordinate2, categoryId: 1)
        mapView.map.addAnnotations([pin, pin2])
    }
    
    @objc func findMyLocation() {
        
        guard locationManager.location != nil else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        mapView.map.showsUserLocation = true
        mapView.map.setUserTrackingMode(.followWithHeading, animated: true)
        
    }
    
    
    func buttonActions() {
        mapView.currentLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)


    }

}

// MARK: CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    //권한 설정을 위한 코드들
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            print("restricted")
            goSetting()
        case .denied:
            print("denided")
            goSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("unknown")
        }
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }

}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil  // 현위치 그냥 기본 파란색 annotation
        }
        
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: "Custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
            
            let mapDetailModel = MapDetailModel(placeName: "주호식당", address: "경기 수원시", discription: "경희대 주점", likeCount: 22)
            let detailView = MapDetailView(mapDetailModel)
            annotationView?.detailCalloutAccessoryView = detailView
            
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
        } else {
            annotationView?.annotation = annotation
        }
        
        
        // 상황에 따라 다른 annotationView를 리턴
        
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        //view.image = UIImage(named: "click_annotation")
        
    }

}

// MARK: private
private extension MapViewController {
    func goSetting() {
        let alert = UIAlertController(title: "위치 권한 요청", message: "현 위치 정보를 불러오려면 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
    }
}
