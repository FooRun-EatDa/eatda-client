//
//  SearchLogCell.swift
//  EatDa
//
//  Created by 김나희 on 6/10/22.
//

import UIKit

final class SearchLogCell: UICollectionViewCell {
    private lazy var tagView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.lightGrayBorderColor.cgColor
        
        return view
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .mySystemFont(ofSize: 13)

        return label
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(tagView)
        tagView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tagView.addSubviews([tagLabel, removeButton])
        tagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        removeButton.snp.makeConstraints {
            $0.leading.equalTo(tagLabel.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
                        
    }
    
    func setData(_ tag: String) {
        tagLabel.text = tag
    }
}
