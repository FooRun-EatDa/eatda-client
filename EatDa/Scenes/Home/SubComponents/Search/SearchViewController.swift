//
//  SearchViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/05.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    // MARK: - UIComponent
    private lazy var  searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 12)
        searchBar.searchTextField.backgroundColor = UIColor.searchBarBackgroundColor
        searchBar.placeholder = "지역, 매장명, 메뉴 검색"
        return searchBar
    }()
    
    private lazy var searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
    
    private lazy var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.font = .myBoldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var recentSearchTerms: UIStackView = {
        // text 수정 필요
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationBar()
        setLayout()
    }
    
    func bind(_ viewModel: SearchViewModel) {
        
    }
}

private extension SearchViewController {
    func setNavigationBar() {
        let backButtonImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = searchBarButton
    }
    
    func setLayout() {
        [recentSearchLabel, recentSearchTerms, seperatorView, topSearchLabel, standardTimeLabel, topSearchTerms]
            .forEach { view.addSubview($0) }
        
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
