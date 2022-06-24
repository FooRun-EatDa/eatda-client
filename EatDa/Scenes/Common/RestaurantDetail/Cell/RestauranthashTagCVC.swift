//
//  RestauranthashTagCVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/02/01.
//

import Foundation
import UIKit

class RestauranthashTagCVC: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: String? { didSet { bind() } }

    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .mySystemFont(ofSize: 13)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()

        configure()

    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addSubviews() {
        addSubview(titleLabel)
    }

    private func configure() {
        
        backgroundColor = .hashTagBackgroundColor
        titleLabel.textColor = .hashTagTextColor
        layer.cornerRadius = 15

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(13)
            make.top.bottom.equalToSuperview().inset(6)
        }
    }

    private func bind() {
        titleLabel.text = model
    }



    
}



