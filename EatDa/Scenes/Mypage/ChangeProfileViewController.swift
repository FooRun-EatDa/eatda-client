//
//  ChangeProfileViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/06/01.
//

import Foundation
import UIKit

class ChangeProfileViewController: UIViewController {
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .dateGrayColor
        view.layer.cornerRadius = 50
        return view
    }()
    
    private lazy var nickLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "닉네임"
        titleLabel.font = .mySystemFont(ofSize: 14)
        return titleLabel
    }()
    
    private lazy var nickTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "기존유저의닉네임"
        textField.textColor = .mainTextColor
        textField.font = .mySystemFont(ofSize: 14)
        return textField
    }()

    private lazy var emailCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray1
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupUI()
    }
    
    func setupUI(){
        [profileImageView, nickLabel, nickTextField, emailCheckView].forEach { view.addSubview($0) }
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(43)
            make.width.height.equalTo(100)
        }
        
        nickLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(90)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(40)
        }
        
        nickTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nickLabel)
            make.leading.equalTo(nickLabel.snp.trailing).offset(14)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        emailCheckView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nickTextField)
            make.top.equalTo(nickTextField.snp.bottom).offset(3)
            make.height.equalTo(1)
        }
    }
    
    func setupNavigation(){
        self.navigationItem.title = "프로필 변경"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .mainTextColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(self.changeInfo))
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.mySystemFont(ofSize: 16)]
        self.navigationItem.rightBarButtonItem?.tintColor = .applyButtonColor

    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func changeInfo(){
        print("API 연동 필요")
    }

    
    
}
