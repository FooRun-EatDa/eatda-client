//
//  RestaurantDetailTVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/02/01.
//

import Foundation
import UIKit

class RestaurantDetailTVC: UITableViewCell {

    let cellTitleLabel = UILabel()
    let cellDetailTitleLabel = UILabel()

    let cellDetailButton = UIButton()
    let cellDetailOpenedLabeView = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [cellTitleLabel, cellDetailTitleLabel, cellDetailButton, cellDetailOpenedLabeView].forEach{ contentView.addSubview($0) }
        cellTitleLabel.textColor = .subTextColor
        cellTitleLabel.font = .mySystemFont(ofSize: 13)
        cellTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(20)
        }
        
        cellDetailTitleLabel.textColor = .mainTextColor
        cellDetailTitleLabel.font = .mySystemFont(ofSize: 13)
        cellDetailTitleLabel.textAlignment = .right
        cellDetailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(20)
        }
        
        cellDetailButton.setImage(UIImage(named: "call"), for: .normal)
        cellDetailButton.setTitleColor(.mainTextColor, for: .normal)
        cellDetailButton.titleLabel?.font = .mySystemFont(ofSize: 13)
        cellDetailButton.semanticContentAttribute = .forceRightToLeft
        cellDetailButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(24)
        }
        
        cellDetailOpenedLabeView.textColor = .mainTextColor
        cellDetailOpenedLabeView.font = .mySystemFont(ofSize: 12)
        cellDetailOpenedLabeView.textAlignment = .right
        cellDetailOpenedLabeView.snp.makeConstraints {
            $0.top.equalTo(cellDetailButton.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-24)
//            $0.bottom.equalToSuperview().offset(-5)
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
