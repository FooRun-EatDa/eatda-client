//
//  RestaurantMenuTVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/02/07.
//

import Foundation
import UIKit

class RestaurantMenuTVC: UITableViewCell {
    
    let menuImage = UIImageView()
    let menuTitle = UILabel()
    let menuDetail = UILabel()
    let menuPrice = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _ = [menuImage, menuTitle, menuDetail, menuPrice].map{ contentView.addSubview($0)}

        
        menuImage.image = UIImage(named: "menu_datail")
        menuImage.layer.cornerRadius = 15
        menuImage.clipsToBounds = true
        menuImage.contentMode = .scaleAspectFill
        menuImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(104)
        }
        
        menuTitle.font = .boldSystemFont(ofSize: 15)
        menuTitle.textColor = UIColor.mainTextColor
        menuTitle.text = "대패삼겹살 전골"
        menuTitle.snp.makeConstraints {
            $0.top.equalTo(menuImage.snp.top)
            $0.leading.equalTo(menuImage.snp.trailing).offset(18)
        }
        
        menuDetail.font = .boldSystemFont(ofSize: 13)
        menuDetail.textColor = UIColor.subTextColor
        menuDetail.text = "주호식당 시그니처 메뉴\n대패 삼겹살 전골입니다"
        menuDetail.numberOfLines = 2
        menuDetail.setLineHeight(lineHeight: 20, numberOfLines: 2)
        menuDetail.snp.makeConstraints {
            $0.top.equalTo(menuTitle.snp.bottom).offset(12)
            $0.leading.equalTo(menuImage.snp.trailing).offset(18)
        }

        menuPrice.font = .boldSystemFont(ofSize: 15)
        menuPrice.textColor = UIColor.mainTextColor
        menuPrice.text = "14,000원"
        menuPrice.snp.makeConstraints {
            $0.bottom.equalTo(menuImage.snp.bottom)
            $0.leading.equalTo(menuImage.snp.trailing).offset(18)
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
