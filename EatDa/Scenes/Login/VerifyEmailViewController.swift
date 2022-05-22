//
//  VerifyEmailViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/10.
//

import Foundation
import UIKit
import RxSwift

final class VerifyEmailViewController: UIViewController {

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
        let view = ProgressCheck(index: 2, range: 5)
        return view
    }()

    private lazy var titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "이메일로 전송된\n인증번호 4자리를 입력해주세요"
        titleLabel.setLineHeight(lineHeight: 36, numberOfLines: 2)
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
    private lazy var inputVerifyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "4자리 숫자"
        textField.textColor = .mainTextColor
        textField.font = .mySystemFont(ofSize: 16)
        return textField
    }()

    private lazy var divideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()
    
    private lazy var repeatVerifyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.applyButtonColor, for: .normal)
        button.setTitle("다시 요청", for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 12)
        button.rx.tap
            .bind {
                print("SDF")
            }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var passwordCheckLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "잘못된 인증번호 입니다. 다시 입력해주세요"
        titleLabel.font = .myMediumSystemFont(ofSize: 12)
        titleLabel.textColor = .emailErrorColor
//        titleLabel.isHidden = true
        return titleLabel
    }()

    
    private lazy var regiesterButton: BottomStickyButton = {
        let button = BottomStickyButton()
        button.isEnabled = true
        button.rx.tap.bind {
            let vc = EnterPasswordViewContoller()
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


        [titleLable, inputVerifyTextField, divideView, repeatVerifyButton, passwordCheckLabel, regiesterButton ].forEach{ view.addSubview($0) }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(24)
        }
        
        inputVerifyTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(titleLable.snp.bottom).offset(56)
        }
        
        divideView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(inputVerifyTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        passwordCheckLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(divideView.snp.bottom).offset(10)
        }
        
        repeatVerifyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(inputVerifyTextField)
        }
        
        regiesterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(94)
        }
    }

}

