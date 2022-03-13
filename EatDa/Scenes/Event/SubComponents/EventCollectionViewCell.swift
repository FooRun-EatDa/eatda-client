//
//  EventCollectionViewCell.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/13.
//

import UIKit
import SnapKit

final class EventCollectionViewCell: UICollectionViewCell {
    static var width: CGFloat { 162.0 }
    static var height: CGFloat { 225.0 }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "res"))
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)

        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 테마"
        label.font = .myBoldSystemFont(ofSize: 16.0)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = .myMediumSystemFont(ofSize: 12.0)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.01.01"
        label.font = .mySystemFont(ofSize: 12.0)
        label.textColor = .darkGray
        
        return label
    }()
    
    func setup(){
        setupLayout()
    }
}

private extension EventCollectionViewCell{
    func setupLayout() {
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.32
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = 12.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

        [imageView, titleLabel, descriptionLabel, dateLabel]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(162.34)
            $0.height.equalTo(152.02)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.82)
            $0.top.equalTo(imageView.snp.bottom).offset(8.73)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(11.88)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2.04)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(2.04)
        }
        
    }
}
