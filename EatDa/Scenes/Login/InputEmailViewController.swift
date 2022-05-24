//
//  InputEmailViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/10.
//

import Foundation
import UIKit
import RxSwift

final class InputEmailViewController: UIViewController {

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
        let view = ProgressCheck(index: 1, range: 5)
        return view
    }()

    private lazy var titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "가입을 위해\n학교이메일을 입력해주세요"
        titleLabel.setLineHeight(lineHeight: 36, numberOfLines: 2)
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
    private lazy var inputEmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "unieat2022"
        textField.textColor = .mainTextColor
        textField.font = .mySystemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var emailCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.emailCheckColor
        return view
    }()

    private lazy var emilDomainLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "@ khu.ac.kr"
        titleLabel.font = .mySystemFont(ofSize: 16)
        return titleLabel
    }()

    private lazy var emilCheckLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "이미 가입된 메일입니다"
        titleLabel.font = .myMediumSystemFont(ofSize: 12)
        titleLabel.textColor = .emailErrorColor
        titleLabel.isHidden = true
        return titleLabel
    }()
    
    private lazy var regiesterButton: BottomStickyButton = {
        let button = BottomStickyButton()
        button.isEnabled = true
        button.rx.tap.bind {
            let vc = VerifyEmailViewController()
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


        [titleLable, inputEmailTextField, emailCheckView, emilDomainLabel, emilCheckLabel, regiesterButton].forEach{ view.addSubview($0) }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(24)
        }
        
        inputEmailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(132)
            make.top.equalTo(titleLable.snp.bottom).offset(56)
        }
        
        emilDomainLabel.snp.makeConstraints { make in
            make.leading.equalTo(inputEmailTextField.snp.trailing)
            make.centerY.equalTo(inputEmailTextField)
        }
        
        emailCheckView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(inputEmailTextField)
            make.top.equalTo(inputEmailTextField.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        
        emilCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(emailCheckView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(24)
        }
        
        regiesterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(94)
        }
        
    }

}

