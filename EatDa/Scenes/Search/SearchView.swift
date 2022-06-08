//
//  SearchView.swift
//  EatDa
//
//  Created by 김나희 on 5/30/22.
//

import Foundation
import UIKit

final class SearhView: UIView {
    
    // MARK: UIComponents
    private lazy var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.font = .myBoldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var recentSearchTerms: UIStackView = {
        // text 수정 필요 -> api 생성 시 수정
        let first = setRecentSearchButton("한식")
        let second = setRecentSearchButton("분식")
        let third = setRecentSearchButton("디저트, 커피")
        let fourth = setRecentSearchButton("디저트, 커피")

        let stackView = UIStackView(arrangedSubviews: [first, second, third, fourth])
        stackView.axis = .horizontal
        stackView.spacing = 13.0
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let seperatorView = SeperatorView(frame: .zero)

    private lazy var topSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의\n핫 키워드 !"
        label.numberOfLines = 2
        label.font = .myBoldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var standardTimeLabel: UILabel = {
        let label = UILabel()
        // 수정 필요
        label.text = "2.28 17:00 기준"
        label.font = .myMediumSystemFont(ofSize: 12.0)
        label.textColor = UIColor.grayTextColor
        return label
    }()
    
    private lazy var topSearchTerms: UIStackView = {
        // label - text 수정 필요
        let first = setTopSearchButton("1  ", "맥주", true)
        let second = setTopSearchButton("2  ", "맥주", true)
        let third = setTopSearchButton("3  ", "맥주", true)

        let stackView1 = UIStackView(arrangedSubviews: [first, second, third])
        stackView1.axis = .vertical
        stackView1.contentMode = .scaleToFill
        stackView1.distribution = .fillEqually
        stackView1.snp.makeConstraints {
            $0.width.equalTo(140.0)
        }
        
        let fourth = setTopSearchButton("4  ", "맥주", false)
        let fifth = setTopSearchButton("5  ", "맥주", false)
        let sixth = setTopSearchButton("6  ", "맥주", false)

        let stackView2 = UIStackView(arrangedSubviews: [fourth, fifth, sixth])
        stackView2.axis = .vertical
        stackView2.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [stackView1, stackView2])
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fill
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearhView {
    func setLayout() {
        [recentSearchLabel, recentSearchTerms, seperatorView, topSearchLabel, standardTimeLabel, topSearchTerms]
            .forEach { addSubview($0) }
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27.09)
            $0.leading.equalToSuperview().inset(25.85)
        }
        
        recentSearchTerms.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().inset(23.84)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(recentSearchTerms.snp.bottom).offset(23.46)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10.0)
        }
        
        topSearchLabel.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom).offset(23.82)
            $0.leading.equalToSuperview().inset(25.79)
        }
        
        standardTimeLabel.snp.makeConstraints {
            $0.top.equalTo(topSearchLabel.snp.bottom).offset(5.51)
            $0.leading.equalTo(topSearchLabel.snp.leading)
        }
        
        topSearchTerms.snp.makeConstraints {
            $0.top.equalTo(standardTimeLabel.snp.bottom).offset(35.15)
            $0.leading.equalToSuperview().inset(23.94)
        }
        
    }
    
    func setTopSearchButton(_ number: String, _ text: String, _ isFirstStack: Bool ) -> UIButton {
        let button = UIButton()
        
        button.setTitle(number + text, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        
        if isFirstStack {
            let attributedString = NSMutableAttributedString(string: button.currentTitle ?? "")
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.hashTagTextColor,
                range: (button.currentTitle! as NSString).range(of: number)
            )
            attributedString.addAttribute(
                .font,
                value: UIFont.myMediumSystemFont(ofSize: 16),
                range: (button.currentTitle! as NSString).range(of: text)
            )
            button.setImage(UIImage(named: "polygon"), for: .normal)
            button.semanticContentAttribute = .forceRightToLeft
            button.imageEdgeInsets = .init(top: 0.0, left: 79.79, bottom: 0.0, right: 0.0)
            
            button.setAttributedTitle(attributedString, for: .normal)
            
            return button
        } else {
            let attributedString = NSMutableAttributedString(string: button.currentTitle ?? "")
            attributedString.addAttribute(
                .font,
                value: UIFont.myMediumSystemFont(ofSize: 16),
                range: (button.currentTitle! as NSString).range(of: text)
            )
            
            button.setAttributedTitle(attributedString, for: .normal)

            return button
        }
    }
    
    func setRecentSearchButton(_ text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 13)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.lightGrayBorderColor.cgColor
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        

        return button
    }
}
