//
//  FilterSectionView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/29.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class FilterSectionView: UIView {
    
    private let categoryView = FilterButtonView(title: "종류별", imageTitle: "category")
    private let districtView = FilterButtonView(title: "지역별", imageTitle: "district")
    private let priceView = FilterButtonView(title: "가격별", imageTitle: "price")
    private let hashtagView = FilterButtonView(title: "해시태그", imageTitle: "hashtag")
    
    private let filter = FilterView(frame: .zero)
    let filterviewmodel = FilterSectionViewModel()

    
    let disposeBag = DisposeBag()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("조회하기", for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 15.0)
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
        filter.isHidden = true
        bind(filterviewmodel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: FilterSectionViewModel) {
        categoryView.rx.tapGesture()
            .when(.recognized)
            .map { _ in false }
            .bind { state in
                viewModel.filterViewType.onNext((state,.category))
            }
            .disposed(by: disposeBag)
        
        districtView.rx.tapGesture()
            .when(.recognized)
            .map { _ in false }
            .bind { state in
                viewModel.filterViewType.onNext((state,.district))
            }
            .disposed(by: disposeBag)
        
        priceView.rx.tapGesture()
            .when(.recognized)
            .map { _ in false }
            .bind { state in
                viewModel.filterViewType.onNext((state,.price))
            }
            .disposed(by: disposeBag)

        
        hashtagView.rx.tapGesture()
            .when(.recognized)
            .map { _ in false }
            .bind { state in
                viewModel.filterViewType.onNext((state,.hashtag))
            }
            .disposed(by: disposeBag)

        viewModel.showFilter
            .drive(onNext: { value in
                let hiddenValue = value.0
                let type = value.1
                                
                guard type != .none else {
                    self.filter.isHidden = true
                    return
                }
                
                switch type {
                case .category:
                    self.resetView()
                    self.filter.isHidden = hiddenValue
                    self.filter.setup(showType: type)
                    self.categoryView.setClick(selected: !hiddenValue)
                case .district:
                    self.resetView()
                    self.filter.isHidden = hiddenValue
                    self.filter.setup(showType: type)
                    self.districtView.setClick(selected: !hiddenValue)
                case .price:
                    self.resetView()
                    self.filter.isHidden = hiddenValue
                    self.filter.setup(showType: type)
                    self.priceView.setClick(selected: !hiddenValue)
                case .hashtag:
                    self.resetView()
                    self.filter.isHidden = hiddenValue
                    self.filter.setup(showType: type)
                    self.hashtagView.setClick(selected: !hiddenValue)
                case .none:
                    break
                }
            })
            .disposed(by: disposeBag)
        
    }
}

private extension FilterSectionView {
    func setupViews(){
        let filterButtonStackView = UIStackView(arrangedSubviews: [categoryView, districtView, priceView, hashtagView])
        filterButtonStackView.spacing = 13.67
        filterButtonStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [filterButtonStackView, filter])
        stackView.axis = .vertical
        stackView.spacing = 20.0

        
        [stackView, applyButton, seperatorView]
            .forEach { addSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.3)
            $0.leading.trailing.equalToSuperview().inset(22.0)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(28.62)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.width.equalTo(315.0)
            $0.height.equalTo(52.0)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(applyButton.snp.bottom).offset(31.52)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(11.24)
            $0.bottom.equalToSuperview()
        }
    }
    
    func resetView(){
        self.categoryView.setClick(selected: false)
        self.districtView.setClick(selected: false)
        self.priceView.setClick(selected: false)
        self.hashtagView.setClick(selected: false)
    }
    
}
