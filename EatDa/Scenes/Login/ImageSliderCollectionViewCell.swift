//
//  ImageSliderCollectionViewCell.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/01.
//

import Foundation
import UIKit

class ImageSliderCollectionViewCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mainGuideLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 20)
        label.textColor = .mainTextColor
        return label
    }()
    
    lazy var subGuideLabel: UILabel = {
        let label = UILabel()
        label.font = .mySystemFont(ofSize: 12)
        label.textColor = .subTextColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        [image, mainGuideLabel, subGuideLabel].forEach { contentView.addSubview($0) }
    }

    private func configure() {
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        subGuideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        mainGuideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(subGuideLabel.snp.top).offset(-10)
        }

    }
}
