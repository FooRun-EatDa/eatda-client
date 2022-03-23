//
//  EventTableViewCell.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/23.
//

import Foundation
import UIKit

final class NoticeTableViewCell: UITableViewCell {
    private lazy var tabTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탭 타이틀"
        label.font = .myBoldSystemFont(ofSize: 13)
        label.textColor = .mainTextColor
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 내용"
        label.font = .myMediumSystemFont(ofSize: 13)
        label.textColor = .mainTextColor
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "06/04 11:11"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .dateGrayColor
        
        return label
    }()

    
}

extension NoticeTableViewCell {
    func setup(){
        [tabTitleLabel, contentLabel, dateLabel]
            .forEach { contentView.addSubview($0) }
        
        self.backgroundColor = .noticeCellBackgroundColor // 상태에 따른 background로 변경 예정
        
        tabTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.5)
            $0.leading.equalToSuperview().inset(26)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(tabTitleLabel.snp.bottom).offset(0.7)
            $0.leading.equalTo(tabTitleLabel.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(1.0)
            $0.leading.equalTo(tabTitleLabel.snp.leading)
            $0.bottom.equalToSuperview().offset(-13)
        }
        
    }
    
}
