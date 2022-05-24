//
//  MapDetailView.swift
//  EatDa
//
//  Created by 김나희 on 5/17/22.
//

import UIKit

class MapDetailView: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let addressLabel = UILabel()
    let likeButton = LikeButton()
    let likeCountLabel = UILabel()
    
    private lazy var likeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3.0
                
        [likeButton, likeCountLabel] .forEach { stackView.addArrangedSubview($0) }

        return stackView
    }()
    
    private lazy var tagLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3.0
        
        let label = UILabel()
        label.makeTag("#정건")
        let label1 = UILabel()
        label.makeTag("#정건")
        
        
        [label, label1] .forEach { stackView.addArrangedSubview($0) }

        return stackView
    }()

    
    init(_ viewModel: MapDetailModel) {
        super.init(frame: .zero)

        attribute()
        setData(viewModel)
        setupLayout()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func attribute() {
        imageView.makeRound(radius: 10)
        titleLabel.font = .myBoldSystemFont(ofSize: 15)
        titleLabel.textColor = .mainTextColor
        descriptionLabel.font = .mySystemFont(ofSize: 11)
        descriptionLabel.textColor = .grayTextColor
        addressLabel.font = .myMediumSystemFont(ofSize: 12)
        addressLabel.textColor = .mainTextColor
        likeCountLabel.font = .mySystemFont(ofSize: 15)
        likeCountLabel.textColor = .mainTextColor
        
        likeStackView.axis = .horizontal
        likeStackView.spacing = 3
        likeStackView.distribution = .fillProportionally
    }

    func setData(_ viewModel: MapDetailModel) {
        imageView.image = UIImage(named: "res")
        //imageView.contentMode = .scaleAspectFit
        titleLabel.text = viewModel.placeName
        descriptionLabel.text = viewModel.discription
        addressLabel.text = viewModel.address
        likeCountLabel.text = String(viewModel.likeCount)
    }
    
    func setupLayout() {
        [imageView, titleLabel, descriptionLabel, addressLabel, tagLabels, likeStackView]
            .forEach { addSubview($0) }
        
        self.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(3)
            $0.width.height.equalTo(84)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(2)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        tagLabels.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        likeStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).offset(-3)
            $0.trailing.equalToSuperview().inset(8)
        }
        
    }
}
