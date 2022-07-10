//
//  RestaurantDetailViewModel.swift
//  EatDa
//
//  Created by 김나희 on 5/24/22.
//

import RxSwift
import RxCocoa

struct RestaurantDetailViewModel {
    let aroundDetailButtonTapped = PublishRelay<Void>()
    
//    let writePostTapped = PublishRelay<Void>()
//    let pushWritePostViewController: Driver<WritePostViewModel>

    let mapViewTapped = PublishSubject<Void>()
    let searchRestaurantData: Driver<RestaurantDetailModel>
    let disposeBag = DisposeBag()

    init(_ id: Int, model: RestaurantListNetwork = RestaurantListNetwork()) {
        
//        let writePostViewModel = WritePostViewModel(id: id)
        let searchRestauranListData = model.getRestaurantDetailValue(id)
        
        self.searchRestaurantData = searchRestauranListData
            .asDriver(onErrorDriveWith: .empty() )
        
//        self.pushWritePostViewController = writePostTapped
//            .map { return writePostViewModel }
//            .asDriver(onErrorDriveWith: .empty())
    }
}
