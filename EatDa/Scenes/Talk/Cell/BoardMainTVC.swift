//
//  BoardMainTVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/03/13.
//

import Foundation
import UIKit

class BoardMainTVC: UITableViewCell {
                
    let writtenTxt = UILabel()
    let writtenAt = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [writtenTxt, writtenAt].forEach{ contentView.addSubview($0) }

        writtenTxt.font = .myMediumSystemFont(ofSize: 14.0)
        writtenTxt.textColor = UIColor.mainTextColor
        writtenTxt.text = "경희대 앞에 짠 먹어보신 분 후기 부탁드려용!"
        writtenTxt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.height.equalTo(20)
        }

        writtenAt.font = .mySystemFont(ofSize: 12.0)
        writtenAt.textColor = UIColor.timeTextColor
        writtenAt.text = "2022.01.23"
        writtenAt.snp.makeConstraints {
            $0.top.equalTo(writtenTxt.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.height.equalTo(18)
            $0.bottom.equalToSuperview().offset(-7)
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
