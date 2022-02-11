//
//  SeperatorView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/29.
//

import UIKit
import SnapKit

final class SeperatorView: UIView {
    private lazy var seperator: UIView = {
        let seperator = UIView()
        seperator.backgroundColor = .seperatorColor
        
        return seperator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(seperator)
        seperator.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
