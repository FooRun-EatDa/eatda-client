//
//  RestaurantReviewTVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/02/10.
//

import Foundation
import UIKit

class RestaurantReviewTVC: UITableViewCell {
            
    let profileImage = UIImageView()
    let profileName = UILabel()
    let writtenAt = UILabel()
    let reviewImage = UIImageView()
    let restaurantName = UILabel()
    let reviewBody = UILabel()
    
    let ratingLable = UILabel()
    let ratingimage = UIImageView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _ = [profileImage, profileName, writtenAt, reviewImage, restaurantName, reviewBody, ratingLable, ratingimage].map{ contentView.addSubview($0)}

        profileImage.image = UIImage(named: "menu_datail")
        profileImage.layer.cornerRadius = 27
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(54)
            $0.top.equalToSuperview().offset(16)
        }
        
        profileName.font = .mySystemFont(ofSize: 13)
        profileName.textColor = UIColor.init(hex: 0xBABABC)
        profileName.text = "강지영 ∙"
        profileName.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.top).offset(5)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        writtenAt.font = .mySystemFont(ofSize: 13)
        writtenAt.textColor = UIColor.init(hex: 0xBABABC)
        writtenAt.text = "2022.01.23"
        writtenAt.snp.makeConstraints {
            $0.top.equalTo(profileName)
            $0.leading.equalTo(profileName.snp.trailing)
        }

        restaurantName.font = .mySystemFont(ofSize: 14)
        restaurantName.textColor = .mainTextColor
        restaurantName.text = "주호식당"
        restaurantName.snp.makeConstraints {
            $0.top.equalTo(writtenAt.snp.bottom).offset(4)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        reviewBody.font = .mySystemFont(ofSize: 14)
        reviewBody.textColor = .mainTextColor
        reviewBody.text = "이번에도 역시나 실망시키지 않네요! 잘 먹었습니다"
        reviewBody.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(15)
            $0.leading.equalTo(profileImage.snp.leading)
            $0.bottom.equalToSuperview().inset(19)
        }

        ratingLable.font = .myBoldSystemFont(ofSize: 14)
        ratingLable.textColor = .pointTextColor
        ratingLable.text = "꿀맛"
        ratingLable.snp.makeConstraints {
            $0.top.equalTo(profileName)
            $0.trailing.equalToSuperview().inset(23)
        }
        
        ratingimage.image = UIImage(named: "GGoul_mat")
        ratingimage.snp.makeConstraints {
            $0.centerY.equalTo(ratingLable)
            $0.trailing.equalTo(ratingLable.snp.leading).offset(-6)
        }

    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
    }

             
}
