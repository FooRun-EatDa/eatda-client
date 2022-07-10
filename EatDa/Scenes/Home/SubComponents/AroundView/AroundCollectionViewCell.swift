//
//  RestaurantCollectionViewCell.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/29.
//

import UIKit
import SnapKit

final class AroundCollectionViewCell: UICollectionViewCell{
    static var width: CGFloat { 180.0 }
    static var height: CGFloat { 250.0 }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "res"))
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)

        return image
    }()
    
    private lazy var likeView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "heart"))
        image.layer.borderColor = UIColor.separator.cgColor
        
        return image
    }()

    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.font = .myBoldSystemFont(ofSize: 16.0)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "소개글"
        label.font = .myMediumSystemFont(ofSize: 13.0)
        label.textColor = .darkGray
        
        return label
    }()
    
    private lazy var hashTagLabel: UILabel = {
        let label = UILabel()
        label.text = "해시태그"
        label.font = .mySystemFont(ofSize: 13.0)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    func setData(_ data: RestaurantListModel){
        self.titleLabel.text = data.name ?? ""
        self.descriptionLabel.text = data.explanation ?? ""
        //self.hashTagLabel.text = data.hashTags ?? ""
    }
}


private extension AroundCollectionViewCell {
    func setupLayout(){

        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 10, height: 0.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath


   
        [imageView, titleLabel, descriptionLabel, hashTagLabel]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12.0)
            $0.top.equalTo(imageView.snp.bottom).offset(12.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10.0)
        }
        
    }

}
