//
//  FilterView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit
import SnapKit

final class FilterButtonView: UIView {
    private let title: String
    private let imageTitle: String
    var isSelected: Bool
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: imageTitle))
        
        image.snp.makeConstraints {
            $0.height.width.equalTo(32.0)
        }
        
        return image
    }()

    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = UIColor.label
        
        return label
    }()
    
    private lazy var checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "check"))
        
        return image
    }()
    

    init(title:String, imageTitle: String, isSeleted: Bool) {
        self.title = title
        self.imageTitle = imageTitle
        self.isSelected = false
        
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isSelected {
            self.isSelected = true
        } else {
            self.isSelected = false
        }
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        var imageName: String = "title"
        
        if !self.isSelected {
            imageName = imageTitle
            categoryTitle.font = .systemFont(ofSize: 14.0, weight: .medium)
            categoryTitle.textColor = .uncheckTextColor
            checkImage.image = UIImage(named: "check")
        } else {
            imageName = imageTitle+"_fill"
            categoryTitle.font = .systemFont(ofSize: 14.0, weight: .medium)
            categoryTitle.textColor = UIColor.label
            checkImage.image = UIImage(named: "check_fill")
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
            $0.leading.trailing.equalToSuperview().inset(22.0)
        }
        
        categoryTitle.snp.makeConstraints {
            $0.top.equalTo(categoryImage.snp.bottom).offset(10.0)
            $0.leading.equalToSuperview().inset(12.0)
        }
        
        checkImage.snp.makeConstraints {
            $0.leading.equalTo(categoryTitle.snp.trailing).offset(1.0)
            $0.top.equalTo(categoryTitle.snp.top).offset(2.0)
        }
        
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.filterViewBorderColor.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    
    }
    

}
