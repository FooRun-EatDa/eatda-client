//
//  AroundSectionView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/31.
//

import UIKit
import SnapKit

final class AroundSectionView: UIView {

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "같이 가자 🍽"

        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 19)
        label.textColor = .label
        label.text = "주변 맛집을 찾아보세요"
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.homeTitleColor, range: (label.text! as NSString).range(of:"주변 맛집"))
        label.attributedText = attributedString
        
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "refresh"), for: .normal)
        
        return button
    }()

    lazy var showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 보기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 14)
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
        collectionView.register(AroundRestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "RestaurantCollectionViewCell")
        
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


extension AroundSectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: AroundRestaurantCollectionViewCell.width , height: AroundRestaurantCollectionViewCell.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 14.68, bottom: 0.0, right: 16.0)
    }
    

}

extension AroundSectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as? AroundRestaurantCollectionViewCell

        
        cell?.setup()
        
        return cell ?? UICollectionViewCell()
    }
}


private extension AroundSectionView {
    func setupViews(){
        
        [
            subTitleLabel,
            titleLabel,
            refreshButton,
            showAllButton,
            collectionView,
            seperatorView
        ].forEach { addSubview($0) }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17.15)
            $0.leading.equalToSuperview().inset(23.1)
            //$0.height.equalTo(20.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(2.41)
            $0.leading.equalTo(subTitleLabel.snp.leading)
            //$0.height.equalTo(28.0)
        }
        
        refreshButton.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.height.width.equalTo(24.0)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4.0)
        }
        
        showAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(23.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17.41)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(AroundRestaurantCollectionViewCell.height + 10)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(17.12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10.0)
            $0.bottom.equalToSuperview()

        }
    }
}
