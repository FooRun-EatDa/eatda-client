//
//  RecommendCollectionViewCell.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/18.
//

import UIKit
import SnapKit

final class RecommendCollectionViewCell: UICollectionViewCell{
    static var width: CGFloat { 126.84 }
    static var height: CGFloat { 220.0 }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "res"))
        image.layer.cornerRadius = 15
        image.clipsToBounds = true

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
        label.font = .mySystemFont(ofSize: 13.0)
        label.textColor = .darkGray
        
        return label
    }()
    
    private lazy var hashTagLabel: UILabel = {
        let label = UILabel()
        label.text = "#정건"
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 12
        label.layer.borderColor = UIColor.hashTagBackgroundColor.cgColor
        label.layer.masksToBounds = true
        label.backgroundColor = .hashTagBackgroundColor
        label.font = .mySystemFont(ofSize: 12.0)
        label.textColor = .hashTagTextColor
        label.textAlignment = .center
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
}


extension RecommendCollectionViewCell {
    func setupLayout(){
        [imageView, titleLabel, descriptionLabel, hashTagLabel]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(126.84)
            $0.height.equalTo(123.75)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8.0)
            $0.top.equalTo(imageView.snp.bottom).offset(10.13)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(3.36)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10.0)
            $0.width.equalTo(50.0)
            $0.height.equalTo(26.0)
        }
        
    }
    
    func setData(_ data: RestaurantListModel){
        self.titleLabel.text = data.name ?? ""
        self.descriptionLabel.text = data.explanation ?? ""
        //self.hashTagLabel.text = data.hashTags ?? ""
    }

}
