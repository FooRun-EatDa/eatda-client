//
//  LikeButton.swift
//  EatDa
//
//  Created by 김나희 on 5/17/22.
//

import UIKit
import RxSwift

class LikeButton: UIButton {
    let disposeBag = DisposeBag()
    
    var id: Int = 0
    var isLiked:Bool = false

    private let unlikedImage = UIImage(named: "heart")
    private let likedImage = UIImage(named: "heart_fill")

    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.3

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setImage(unlikedImage, for: .normal)
        bind(RestaurantListViewModel())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setLikedState(_ restaurantId: Int, _ state: Bool) {
        id = restaurantId
        isLiked = state
        if state {
            setImage(likedImage, for: .normal)
        } else {
            setImage(unlikedImage, for: .normal)
        }
    }
    

    func flipLikedState() {
        isLiked = !isLiked
        UIView.animate(withDuration: 0.1, animations: {
            let newImage = self.isLiked ? self.likedImage : self.unlikedImage
            let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.transform = self.transform.scaledBy(x: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }

    func bind(_ viewModel: RestaurantListViewModel) {
        self.rx.tap
            .map {
                self.flipLikedState()
                return (self.id, self.isLiked)
            }
            .bind(to: viewModel.likeButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.likeButtonTapped
            .subscribe(onNext: { button in
                viewModel.tapLikeButton(button.0, button.1)
            }).disposed(by: disposeBag)
    }
}
