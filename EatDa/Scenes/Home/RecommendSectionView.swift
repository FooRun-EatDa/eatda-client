//
//  RecommendSectionView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/29.
//

import UIKit
import SnapKit

final class RecommendSectionView: UIView {
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .mainColor
        label.text = "인기 힙플레이스!"
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .label
        label.text = "추천 맛집을 찾아보세요!"
        
        return label
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 보기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.setImage(UIImage(imageLiteralResourceName: "right_arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "RestaurantCollectionViewCell")
        
        return collectionView
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

extension RecommendSectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: RestaurantCollectionViewCell.width , height: RestaurantCollectionViewCell.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 16.0)
    }
    

}

extension RecommendSectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as? RestaurantCollectionViewCell

        
        cell?.setup()
        
        return cell ?? UICollectionViewCell()
    }
}


private extension RecommendSectionView {
    func setupViews(){
        [
            subTitleLabel,
            titleLabel,
            showAllButton,
            collectionView,
            seperatorView
        ].forEach { addSubview($0) }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(23.1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(3.0)
            $0.leading.equalTo(subTitleLabel.snp.leading)
        }
        
        showAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(RestaurantCollectionViewCell.height + 50)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10.0)
        }

    }
}
