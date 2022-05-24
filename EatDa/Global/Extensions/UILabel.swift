//
//  UILabel.swift
//  EatDa
//
//  Created by 김희진 on 2022/02/07.
//

import UIKit

extension UILabel{
    func setLineHeight(lineHeight: CGFloat, numberOfLines:CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / (numberOfLines + 1)
            ]
                
            let attrString = NSAttributedString(string: text, attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func makeTag(_ content: String) {
        text = content
        layer.borderWidth = 1.0
        layer.cornerRadius = 12
        layer.borderColor = UIColor.hashTagBackgroundColor.cgColor
        layer.masksToBounds = true
        backgroundColor = .hashTagBackgroundColor
        font = .mySystemFont(ofSize: 12.0)
        textColor = .hashTagTextColor
        textAlignment = .center
        
        self.snp.makeConstraints {
            $0.width.equalTo(50.0)
            $0.height.equalTo(26.0)
        }
    }
}
