//
//  RecommendCollectionView.swift
//  EatDa
//
//  Created by 김나희 on 5/30/22.
//

import Foundation
import RxSwift
import RxCocoa

final class RecommendCollectionView: UICollectionView {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 14.68, bottom: 0.0, right: 13.41)
        layout.itemSize = CGSize(width: RecommendCollectionViewCell.width , height: RecommendCollectionViewCell.height)
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        attribute()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.backgroundColor = .systemBackground
        self.showsHorizontalScrollIndicator = false
        self.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendCollectionViewCell")
    }
    
    
    func bind(_ viewModel: RestaurantListViewModel) {
        viewModel.recommendRestaurantData
            .drive(self.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as! RecommendCollectionViewCell
                cell.setData(data)

                return cell
            }
            .disposed(by: disposeBag)
    }
    
}

