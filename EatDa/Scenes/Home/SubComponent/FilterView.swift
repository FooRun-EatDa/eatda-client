//
//  FilterView.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit
import SnapKit

final class FilterView: UIView {
    private let title: String
    private let imageTitle: String
    
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: imageTitle))
        image.snp.makeConstraints {
            $0.height.width.equalTo(32.0)
        }
        
        return image
    }()
    
    private lazy var categoryTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(named: "empty_check"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 5.0, bottom: 0, right: 0)
        
        return button
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
    
}

private extension FilterView {
    func setLayout() {
        let stackView = UIStackView(arrangedSubviews: [categoryImage, categoryTitleButton])
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.layer.borderWidth = 0.6
        stackView.layer.borderColor = UIColor.filterViewBorderColor.cgColor
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 20
        
        let inset: CGFloat = 16.0
        
        categoryImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(inset)
        }

        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    

}
