//
//  AroundCollectionView.swift
//  EatDa
//
//  Created by 김나희 on 6/26/22.
//

import RxSwift
import RxCocoa

final class AroundCollectionView: UICollectionView {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 14.68, bottom: 0.0, right: 16.0)
        layout.itemSize = CGSize(width: AroundCollectionViewCell.width , height: AroundCollectionViewCell.height)
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        attribute()
        bind(RestaurantListViewModel())
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.backgroundColor = .systemBackground
        self.showsHorizontalScrollIndicator = false
        self.register(AroundCollectionViewCell.self, forCellWithReuseIdentifier: "AroundCollectionViewCell")
    }
    
    
    func bind(_ viewModel: RestaurantListViewModel) {
        viewModel.aroundRestaurantData
            .drive(self.rx.items) { collectionView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AroundCollectionViewCell", for: indexPath) as! AroundCollectionViewCell
                cell.setData(data)

                return cell
            }
            .disposed(by: disposeBag)
    }
    
}
