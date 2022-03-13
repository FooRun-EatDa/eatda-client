//
//  BestBoardTVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/03/13.
//

import Foundation
import UIKit

class BestBoardTVC: UITableViewCell {
                
    let profileImage = UIImageView()
    let profileName = UILabel()
    let writtenAt = UILabel()
    let reviewBody = UILabel()

    let heartButton = UIButton()
    let commentButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _ = [profileImage, profileName, writtenAt, reviewBody, heartButton, commentButton].map{ contentView.addSubview($0)}

        profileImage.image = UIImage(named: "menu_datail")
        profileImage.layer.cornerRadius = 17.5
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(22)
            $0.width.height.equalTo(35)
        }
        
        profileName.font = .boldSystemFont(ofSize: 14)
        profileName.textColor = UIColor.mainTextColor
        profileName.text = "지원"
        profileName.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(13)
        }
        
        reviewBody.font = .myMediumSystemFont(ofSize: 14)
        reviewBody.textColor = UIColor.mainTextColor
        reviewBody.numberOfLines = 0
        reviewBody.text = "경희대 앞에 짠 먹어보신 분 후기 부탁드려용!경희대 앞에 짠 먹어보신 분 후기 부탁드려용!"
        reviewBody.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(22)
        }
        
        writtenAt.font = .mySystemFont(ofSize: 12)
        writtenAt.textColor = UIColor.init(hex: 0xBABABC)
        writtenAt.text = "2022.01.23"
        writtenAt.snp.makeConstraints {
            $0.top.equalTo(reviewBody.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(22)
            $0.bottom.equalToSuperview().inset(13)
        }

        commentButton.setImage(UIImage(named: "small_comment"), for: .normal)
        commentButton.setTitle(" 0", for: .normal)
        commentButton.setTitleColor(UIColor.init(hex: 0x4AA2AD), for: .normal)
        commentButton.titleLabel?.font = .mySystemFont(ofSize: 13)
        commentButton.snp.makeConstraints {
            $0.centerY.equalTo(writtenAt)
            $0.trailing.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(13)
        }

        heartButton.setImage(UIImage(named: "small_heart"), for: .normal)
        heartButton.setTitle(" 5", for: .normal)
        heartButton.setTitleColor(.red, for: .normal)
        heartButton.titleLabel?.font = .mySystemFont(ofSize: 13)
        heartButton.snp.makeConstraints {
            $0.centerY.equalTo(writtenAt)
            $0.trailing.equalTo(commentButton.snp.leading).offset(-13)
            $0.bottom.equalToSuperview().inset(13)
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
