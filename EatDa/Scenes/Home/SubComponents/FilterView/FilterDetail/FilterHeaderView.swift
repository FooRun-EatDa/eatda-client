//
//  FilterHeaderView.swift
//  EatDa
//
//  Created by 김나희 on 2022/04/02.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FilterHeaderView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    let border = SeperatorView()
    let sortButton = UIButton()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        attribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    func bind(_ viewModel: FilterViewModel) {
//        // sort button 탭 이벤트 방출 시 -> tappedSortButton 바인딩
//        sortButton.rx.tap
//            .bind(to: viewModel.sortButtonTapped)
//            .disposed(by: disposeBag)
//    }
    
}

// MARK: private
private extension FilterHeaderView {

    func attribute() {
        // sort 버튼 ui
        sortButton.setImage(UIImage(named:"filter"), for: .normal)
    }
    
    func setupLayout() {
        [sortButton, border]
            .forEach { addSubview($0) }
        
        sortButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(22.0)
            $0.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(18.0)
        }
        
        border.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(12.0)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
        
    }
}
