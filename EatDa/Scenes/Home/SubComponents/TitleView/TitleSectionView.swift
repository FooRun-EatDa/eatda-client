//
//  TitleSectionView.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/10.
//

import UIKit
import SnapKit

final class TitleSectionView: UIView {
    
    private lazy var schoolTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("경희대학교(국제)", for: .normal)
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 25.0)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        // 눌렀을때 학교 검색 -> rx로
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(schoolTitleButton)
        schoolTitleButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.91)
            $0.leading.equalToSuperview().inset(22.94)
            $0.height.equalTo(34.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
