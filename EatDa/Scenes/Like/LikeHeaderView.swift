//
//  LikeHeaderView.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/28.
//

import UIKit
import SnapKit

final class LikeHeaderView: UITableViewHeaderFooterView {
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "찜한 맛집"
        label.textColor = .label
        label.font = .myBoldSystemFont(ofSize: 25.0)
        
        
        return label
    }()
    
    private lazy var totalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12.0)
        
        return label
    }()
    
   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(_ dataCount: Int) {
        totalCountLabel.text = "총 \(dataCount)개"
    }
}

// MARK: private
private extension LikeHeaderView {
    
    func setupLayout() {
        [headerTitleLabel, totalCountLabel]
            .forEach { addSubview($0) }
        
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21.2)
            $0.leading.equalToSuperview().inset(22.54)
        }
        
        totalCountLabel.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(12.74)
            $0.leading.equalToSuperview().inset(25.13)
        }

    }
}
