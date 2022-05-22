//
//  BottomStickyButton.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/21.
//

import Foundation
import UIKit

final class BottomStickyButton: UIButton {
 
    init() {
        super.init(frame: .zero)
        self.setTitleColor(.white, for: .normal)
        self.setTitle("확인\n\n", for: .normal)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        self.isEnabled = false
        self.setBackgroundColor(.applyButtonColor, for: .normal)
        self.setBackgroundColor(.buttonDisableColor, for: .disabled)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

