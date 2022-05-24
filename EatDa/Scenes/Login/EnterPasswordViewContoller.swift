//
//  EnterPasswordViewContoller.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/10.
//

import Foundation
import UIKit
import RxSwift

final class EnterPasswordViewContoller: UIViewController {

    let disposeBag = DisposeBag()
    var step: Int = 0
    
    private lazy var naviBar: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.rx.tap
            .bind {
                self.dismiss(animated: false)
            }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var stepView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()

    private lazy var stepStackView: ProgressCheck = {
        let view = ProgressCheck(index: 3, range: 5)
        return view
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "사용할 비밀번호를\n입력해주세요"
        titleLabel.setLineHeight(lineHeight: 36, numberOfLines: 2)
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
    private lazy var inputPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "8자리 이상"
        textField.textColor = .mainTextColor
        textField.font = .mySystemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var divideView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()
    
    private lazy var inputPasswordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 확인"
        textField.textColor = .mainTextColor
        textField.font = .mySystemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var divideView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()
    
    private lazy var regiesterButton: BottomStickyButton = {
        let button = BottomStickyButton()
        button.isEnabled = true
        button.rx.tap.bind {
            let vc = EnterUserInfoViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        }.disposed(by: disposeBag)

        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(naviBar)
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        naviBar.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
        }
        
        naviBar.addSubview(stepView)
        stepView.snp.makeConstraints { make in
            make.center.equalTo(naviBar)
            make.height.equalTo(2)
            make.width.equalTo(130)
        }

        naviBar.addSubview(stepStackView)
        stepStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(stepView)
            make.centerY.equalTo(stepView)
        }

        [titleLable, inputPasswordTextField, divideView1, inputPasswordCheckTextField, divideView2, regiesterButton].forEach{ view.addSubview($0) }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(24)
        }
        
        inputPasswordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(titleLable.snp.bottom).offset(56)
        }
        
        divideView1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(inputPasswordTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        inputPasswordCheckTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(divideView1.snp.bottom).offset(70)
        }
        
        divideView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(inputPasswordCheckTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }


        regiesterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(94)
        }

    }

}

