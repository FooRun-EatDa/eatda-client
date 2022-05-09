//
//  EnterUserInfoViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/10.
//

import Foundation
import UIKit
import RxSwift

final class EnterUserInfoViewController: UIViewController {

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

    private lazy var stepStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()
    
    lazy var stepList: [UIImageView] = []

    private lazy var step1View: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.image =  UIImage(named: "termUncheck")
        view.tag = 1
        stepList.append(view)
        return view
    }()

    private lazy var step2View: UIImageView = {
        let view = UIImageView()
        view.image =  UIImage(named: "termUncheck")
        view.tag = 2
        stepList.append(view)
        return view
    }()

    private lazy var step3View: UIImageView = {
        let view = UIImageView()
        view.image =  UIImage(named: "termUncheck")
        view.tag = 3
        stepList.append(view)
        return view
    }()

    private lazy var step4View: UIImageView = {
        let view = UIImageView()
        view.image =  UIImage(named: "termUncheck")
        view.tag = 4
        stepList.append(view)
        return view
    }()

    private lazy var step5View: UIImageView = {
        let view = UIImageView()
        view.image =  UIImage(named: "termUncheck")
        view.tag = 5
        stepList.append(view)
        return view
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "회원님의\n정보를 입력해주세요"
        titleLabel.setLineHeight(lineHeight: 36, numberOfLines: 2)
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
    private lazy var inputSchoolButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.divideViewColor, for: .normal)
        button.setTitle("학교검색하기", for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 12)
        button.rx.tap
            .bind {
                //TODO: 모달 올라와야함
            }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var divideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()
    
    private lazy var regiesterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .applyButtonColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 18)
        button.rx.tap
            .bind {
                let vc = EnterNicknameViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
            }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var registerBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .applyButtonColor
        return view
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

        stepStackView.addArrangedSubview(step1View)
        stepStackView.addArrangedSubview(step2View)
        stepStackView.addArrangedSubview(step3View)
        stepStackView.addArrangedSubview(step4View)
        stepStackView.addArrangedSubview(step5View)

        [titleLable, inputSchoolButton, divideView, regiesterButton, registerBottomView].forEach{ view.addSubview($0) }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(24)
        }
        
        inputSchoolButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.top.equalTo(titleLable.snp.bottom).offset(56)
        }
        
        divideView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(inputSchoolButton.snp.bottom)
            make.height.equalTo(1)
        }
        
        registerBottomView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(30)
        }
        
        regiesterButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerBottomView.snp.top)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
    }

}

