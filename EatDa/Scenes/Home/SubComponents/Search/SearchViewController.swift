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
    
    
    
    private let seperatorView = SeperatorView(frame: .zero)

    private lazy var topSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "가장 많이\n검색하고 있어요!"
        label.numberOfLines = 2
        label.font = .myBoldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var standardTimeLabel: UILabel = {
        let label = UILabel()
        // 수정 필요
        label.text = "2.28 17:00 기준"
        label.font = .myMediumSystemFont(ofSize: 12.0)
        label.textColor = .gray
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
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = searchBarButton
        
    }
    
    func setLayout() {
        [recentSearchLabel, seperatorView, topSearchLabel, standardTimeLabel, topSearchTerms]
            .forEach { view.addSubview($0) }
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27.09)
            $0.leading.equalToSuperview().inset(25.85)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(23.46)
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
