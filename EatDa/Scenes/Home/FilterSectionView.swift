//
//  FilterSectionView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/29.
//

import UIKit
import SnapKit

final class FilterSectionView: UIView {
    
    private let categoryView = FilterButtonView(title: "종류별", imageTitle: "category", isSeleted: false)
    private let districtView = FilterButtonView(title: "지역별", imageTitle: "district", isSeleted: false)
    private let priceView = FilterButtonView(title: "가격별", imageTitle: "price", isSeleted: false)
    private let hashtagView = FilterButtonView(title: "해시태그", imageTitle: "hashtag", isSeleted: false)
        
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("조회하기", for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 15.0)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "logo"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()

    private let seperatorView = SeperatorView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FilterSectionView {
    func setupViews(){
        let filterButtonStackView = UIStackView(arrangedSubviews: [categoryView, districtView, priceView, hashtagView])
        filterButtonStackView.spacing = 14.0
        filterButtonStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [filterButtonStackView,
                                                       applyButton,
                                                       seperatorView])

        filterButtonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(22.0)
            $0.height.equalTo(86.0)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(filterButtonStackView.snp.bottom).offset(25.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.width.equalTo(315.0)
            $0.height.equalTo(52.0)
        }
        
        seperatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10.0)
        }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
