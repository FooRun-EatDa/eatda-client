//
//  FilterView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit
import SnapKit
import RxSwift

final class FilterButtonView: UIView {
    private let title: String
    private let imageTitle: String
    
    let viewModel = FilterSectionViewModel()
    
    let disposeBag = DisposeBag()
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: imageTitle))
        
        return image
    }()

    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .mySystemFont(ofSize: 12)

        label.textColor = UIColor.uncheckTextColor
        
        return label
    }()
    
    private lazy var checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "check"))
        
        return image
    }()
    
    
    init(title:String, imageTitle: String) {
        self.title = title
        self.imageTitle = imageTitle
        
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setClick(selected: Bool) {
        var imageName: String = "title"
        
        if selected {
            imageName = imageTitle+"_fill"
            categoryTitle.font = .myBoldSystemFont(ofSize: 12.0)
            categoryTitle.textColor = UIColor.label
            checkImage.image = UIImage(named: "check_fill")
            self.layer.borderColor = UIColor.mainColor.cgColor
        } else {
            imageName = imageTitle
            categoryTitle.font = .mySystemFont(ofSize: 12.0)
            categoryTitle.textColor = .uncheckTextColor
            checkImage.image = UIImage(named: "check")
            self.layer.borderColor = UIColor.lightGrayBorderColor.cgColor
        }
        categoryImage.image = UIImage(named: imageName)
        
    }

}

private extension FilterButtonView {
    func setLayout() {
        
        [categoryImage, categoryTitle, checkImage]
            .forEach { addSubview($0) }
        
        categoryImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(32.0)
        }
        
        categoryTitle.snp.makeConstraints {
            $0.top.equalTo(categoryImage.snp.bottom).offset(10.0)
            $0.centerX.equalToSuperview().offset(-5)
        }
        
        checkImage.snp.makeConstraints {
            $0.leading.equalTo(categoryTitle.snp.trailing).offset(2.3)
            $0.top.equalTo(categoryTitle.snp.top).offset(2.0)
        }
        
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGrayBorderColor.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        
        self.snp.makeConstraints {
            $0.width.equalTo(72.0)
            $0.height.equalTo(86.0)
        }
    
    }
    

}
