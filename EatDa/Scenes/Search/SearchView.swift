//
//  SearchView.swift
//  EatDa
//
//  Created by 김나희 on 5/30/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class SearhView: UIView {
    let disposeBag = DisposeBag()

    // MARK: UIComponents
    private lazy var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.font = .myBoldSystemFont(ofSize: 16.0)
        return label
    }()
    
    public lazy var searchLogCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 13.41)

        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchLogCell.self, forCellWithReuseIdentifier: "SearchLogCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
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
    

    func bind(_ viewModel: SearchViewModel) {
        viewModel.searchLogData
            .drive(searchLogCollectionView.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchLogCell", for: indexPath) as! SearchLogCell
                cell.setData(data.searchText ?? "")

                return cell
            }
            .disposed(by: disposeBag)
        
        searchLogCollectionView.rx.modelSelected(SearchLogModel.self)
            .bind(to: viewModel.selectedLogData)
            .disposed(by: disposeBag)

    }
}

extension SearhView {
    func setLayout() {
        [recentSearchLabel, searchLogCollectionView, seperatorView, topSearchLabel, standardTimeLabel, topSearchTerms]
            .forEach { addSubview($0) }
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27.09)
            $0.leading.equalToSuperview().inset(25.85)
        }
        
        searchLogCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(searchLogCollectionView.snp.bottom).offset(10)
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

}

