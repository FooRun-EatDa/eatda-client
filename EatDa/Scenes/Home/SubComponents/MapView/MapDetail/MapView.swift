//
//  MapView.swift
//  EatDa
//
//  Created by 김나희 on 5/17/22.
//

import UIKit
import SnapKit
import MapKit

class MapView: UIView{

    let currentLocationButton = UIButton()
    let map = MKMapView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(map)
        self.addSubview(currentLocationButton)
        configure()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        currentLocationButton.setImage(UIImage(named: "map_refresh"), for: .normal)
        
    }
    
    func setupLayout() {
        map.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.width.height.equalTo(60)
        }
        
    }
    
    
}
