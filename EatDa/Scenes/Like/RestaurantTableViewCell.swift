//
//  LikeRestaurantCell.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/28.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {
    
    let thumnailImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "res"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 17
        image.clipsToBounds = true

        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀명"
        label.font = .myBoldSystemFont(ofSize: 14)
        label.numberOfLines = 1

        return label
    }()
    
    private lazy var districtLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .mySystemFont(ofSize: 14)

        return label
    }()
    
    private lazy var hashtagLabel1: UILabel = {
        let label = UILabel()
        label.text = "#정건"
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.hashTagBackgroundColor.cgColor
        label.layer.masksToBounds = true
        label.backgroundColor = .hashTagBackgroundColor
        label.font = .mySystemFont(ofSize: 12.0)
        label.textColor = .hashTagTextColor
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var hashtagLabel2: UILabel = {
        let label = UILabel()
        label.text = "#정건"
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.hashTagBackgroundColor.cgColor
        label.layer.masksToBounds = true
        label.backgroundColor = .hashTagBackgroundColor
        label.font = .mySystemFont(ofSize: 12.0)
        label.textColor = .hashTagTextColor
        label.textAlignment = .center
        
        return label
    }()
    
    let likeImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "like_fill"))
        // 눌렀을때 event 추가 필요

        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
}

extension RestaurantTableViewCell {
    func setupLayout(){
        [thumnailImageView, titleLabel, districtLabel, hashtagLabel1, hashtagLabel2, likeImageView]
            .forEach { contentView.addSubview($0) }
        
        thumnailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(22.54)
            $0.width.height.equalTo(76.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15.2)
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(15.27)
        }
        
        districtLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        hashtagLabel1.snp.makeConstraints {
            $0.top.equalTo(districtLabel.snp.bottom).offset(4.28)
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(10.69)
            $0.width.equalTo(53.0)
            $0.height.equalTo(27.0)
        }
        
        hashtagLabel2.snp.makeConstraints {
            $0.top.equalTo(hashtagLabel1.snp.top)
            $0.leading.equalTo(hashtagLabel1.snp.trailing).offset(6.4)
            $0.width.equalTo(53.0)
            $0.height.equalTo(27.0)
        }
        
        likeImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25.34)
            $0.centerY.equalToSuperview()
        }
    }
}
