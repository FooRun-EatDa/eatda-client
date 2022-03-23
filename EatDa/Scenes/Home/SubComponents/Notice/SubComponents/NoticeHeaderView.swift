//
//  NoticeHeaderView.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/23.
//

import UIKit
import SnapKit

final class NoticeHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UIComponent
    private lazy var tapTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = .myBoldSystemFont(ofSize: 25)
        label.textColor = .mainTextColor
        
        return label
    }()
    
    private lazy var noticeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "12" // 수정 필요
        label.font = .myBoldSystemFont(ofSize: 25)
        label.textColor = UIColor.hashTagTextColor
        
        return label
    }()
    
   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: private
private extension NoticeHeaderView {

    func setupLayout() {
        [tapTitleLabel, noticeCountLabel]
            .forEach { addSubview($0) }
        
        tapTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().inset(22.54)
        }
        
        noticeCountLabel.snp.makeConstraints {
            $0.top.equalTo(tapTitleLabel.snp.top)
            $0.leading.equalTo(tapTitleLabel.snp.trailing).offset(8.0)
        }

    }
}
