//
//  MapSection.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/13.
//

import UIKit
import SnapKit

final class MapSectionView: UIView {

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "클릭하면 주변 맛집이?"

        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 19)
        label.textColor = .label
        label.text = "내 동네 맛집은?"
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.foregroundColor, value: UIColor.homeTitleColor, range: (label.text! as NSString).range(of:"내 동네 맛집"))
        label.attributedText = attributedString
        
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "refresh"), for: .normal)
        
        return button
    }()
    
    private lazy var mapImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "map"))
        
        image.snp.makeConstraints {
            $0.height.equalTo(218.0)
            $0.width.equalTo(343.0)
        }

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


private extension MapSectionView {
    func setupViews(){
        
        [
            subTitleLabel,
            titleLabel,
            mapImageView
        ].forEach { addSubview($0) }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.15)
            $0.leading.equalToSuperview().inset(23.1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(3.0)
            $0.leading.equalTo(subTitleLabel.snp.leading)
        }
        
        mapImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
}
