//
//  MapSection.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/13.
//

import UIKit
import SnapKit
import MapKit

final class MapSectionView: UIView {

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "우리 학교 맛집 🏫"

        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 19)
        label.textColor = .homeTitleColor
        label.text = "TOP 50"
        
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "refresh"), for: .normal)
        
        return button
    }()
    
    lazy var mapView: MKMapView = {
        let view  = MKMapView()
        let initialCoordinate = CLLocationCoordinate2D(latitude: 37.24, longitude: 127.08)
        view.setRegion(MKCoordinateRegion(center: initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: false)
        view.isScrollEnabled = false
        
        let image = UIImageView(image: UIImage(named: "map_logo"))

        view.addSubview(image)
        image.snp.makeConstraints {
            $0.width.height.equalTo(51)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


private extension MapSectionView {
    func setupViews(){
        
        [
            subTitleLabel,
            titleLabel,
            mapView
        ].forEach { addSubview($0) }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.15)
            $0.leading.equalToSuperview().inset(23.1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(3.0)
            $0.leading.equalTo(subTitleLabel.snp.leading)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(230.0)
            $0.width.equalTo(343.0)
        }
        
    }
}
