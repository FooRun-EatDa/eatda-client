//
//  TermsViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/09.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxRelay

final class TermsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let selectedAllObervable = BehaviorRelay<Bool>(value: false)
    let selectedterm1Obervable = BehaviorRelay<Bool>(value: false)
    let selectedterm2Obervable = BehaviorRelay<Bool>(value: false)
    let selectedterm3Obervable = BehaviorRelay<Bool>(value: false)

    private lazy var naviBar: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.rx.tap
            .bind {
                self.dismiss(animated: true)
            }.disposed(by: disposeBag)
        return button
    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashImage")
        return imageView
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "회원님\n환영합니다 !"
        titleLabel.setLineHeight(lineHeight: 36, numberOfLines: 2)
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
    private lazy var allowAllButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "termUncheck"), for: .normal)
        button.setImage(UIImage(named: "termCheck"), for: .selected)
        button.setTitle("   약관 전체 동의", for: .normal)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 15)
        button.rx.tap
            .bind { [self] in
                let tempBtns = [self.allowTerm1, self.allowTerm2, self.allowTerm3]
                button.isSelected = !button.isSelected
                self.selectedAllObervable.accept(button.isSelected)
                for btn in tempBtns {
                    btn.isSelected = button.isSelected
                }
            }.disposed(by: disposeBag)
        return button
    }()

    private lazy var allowTerm1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "termUncheck"), for: .normal)
        button.setImage(UIImage(named: "termCheck"), for: .selected)
        button.setTitle("   이용약관 동의(필수)", for: .normal)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 15)
        button.rx.tap
            .bind {
                button.isSelected = !button.isSelected
                self.selectedterm1Obervable.accept(button.isSelected)
            }.disposed(by: disposeBag)
        return button
    }()
    private lazy var allowTerm2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "termUncheck"), for: .normal)
        button.setImage(UIImage(named: "termCheck"), for: .selected)
        button.setTitle("   개인정보 수집 및 이용동의(필수)", for: .normal)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.titleLabel?.font = .mySystemFont(ofSize: 15)
        button.rx.tap
            .bind {
                button.isSelected = !button.isSelected
                self.selectedterm2Obervable.accept(button.isSelected)
            }.disposed(by: disposeBag)
        return button
    }()
    private lazy var allowTerm3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "termUncheck"), for: .normal)
        button.setImage(UIImage(named: "termCheck"), for: .selected)
        button.setTitle("  이벤트 수신 동의(선택)", for: .normal)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = .mySystemFont(ofSize: 15)
        button.rx.tap
            .bind {
                button.isSelected = !button.isSelected
                self.selectedterm3Obervable.accept(button.isSelected)
            }.disposed(by: disposeBag)
        return button
    }()
    private lazy var allowTerm3Description: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "다양한 대학교 맛집들의 이벤트 정보를 보내드립니다."
        titleLabel.font = .mySystemFont(ofSize: 12)
        titleLabel.textColor = .describeTextColor
        return titleLabel
    }()

    
    private lazy var divideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 25
        return view
    }()
    
    private lazy var regiesterButton: BottomStickyButton = {
        let button = BottomStickyButton()

        button.rx.tap.bind {
            let vc = InputSchoolViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        }.disposed(by: disposeBag)

        return button
    }()
    
    func a() {
        let vc = InputSchoolViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
        binding()
    }
    
    func binding() {
        
        Observable.combineLatest(selectedterm1Obervable, selectedterm2Obervable, selectedterm3Obervable, resultSelector: { t1, t2, t3 in
            return t1 && t2 && t3
        }).subscribe {
            self.allowAllButton.isSelected = $0
        }.disposed(by: disposeBag)
 
        Observable.combineLatest(selectedterm1Obervable,selectedterm2Obervable) {$0 && $1}
            .bind(to: self.regiesterButton.rx.isEnabled)
            .disposed(by: disposeBag)

        selectedAllObervable.bind(to: self.regiesterButton.rx.isEnabled)
            .disposed(by: disposeBag)

    }
    
    func initUI(){
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
        
        [logoImage, titleLable, allowAllButton, divideView, stackView, regiesterButton,  allowTerm3Description].forEach{ view.addSubview($0) }
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(72)
        }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(72)
        }

        regiesterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(94)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(regiesterButton.snp.top).offset(-57)
        }
        stackView.addArrangedSubview(allowTerm1)
        stackView.addArrangedSubview(allowTerm2)
        stackView.addArrangedSubview(allowTerm3)

        divideView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(stackView.snp.top).offset(-13)
        }

        allowAllButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalTo(divideView.snp.top).offset(-13)
        }
        allowTerm3Description.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().offset(50)
        }
    }
    
}
