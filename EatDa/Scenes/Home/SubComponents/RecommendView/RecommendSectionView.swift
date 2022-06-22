//
//  RecommendSectionView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/29.
//

import UIKit
import SnapKit
import RxSwift

final class RecommendSectionView: UIView {
    let disposeBag = DisposeBag()
    let isFetchedData = PublishSubject<RestaurantListData>()
    
    // MARK: UIComponents
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "인기 힙플레이스 🌟"
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 19)
        label.textColor = .label
        label.text = "추천 맛집을 찾아보세요"
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.homeTitleColor, range: (label.text! as NSString).range(of:"추천 맛집"))
        label.attributedText = attributedString
        
        return label
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
    
    let collectionView = RecommendCollectionView()
    
    private let seperatorView = SeperatorView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.bind(RestaurantListViewModel())
        setupViews()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        collectionView.rx.modelSelected(RestaurantListData.self)
            .subscribe(onNext: { model in
                print(">>1 ", model.id)
                self.isFetchedData.onNext(model)
                
            }).disposed(by: disposeBag)
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
            $0.top.equalToSuperview().inset(17.1)
            $0.leading.equalToSuperview().inset(23.1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(2.41)
            $0.leading.equalTo(subTitleLabel.snp.leading)
        }
        
        showAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(23.0)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17.13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(RecommendCollectionViewCell.height)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10.0)
            $0.bottom.equalToSuperview()

        }

    }

}
