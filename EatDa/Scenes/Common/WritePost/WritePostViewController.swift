//
//  WritePostViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/04/05.
//

import Foundation
import UIKit
import SnapKit

class WritePostViewController: UIViewController {
    
    lazy var navView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var navBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.titleLabel?.font = UIFont.mySystemFont(ofSize: 15)
        return button
    }()

    lazy var navTitle: UILabel = {
        let label = UILabel()
        label.text = "작성하기"
        label.font = UIFont.myBoldSystemFont(ofSize: 15)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        initUI()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        view.addSubview(navView)
        navView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        navView.addSubview(navTitle)
        navTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        navView.addSubview(navBackButton)
        navBackButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        navBackButton.addTarget(self, action: #selector(didTouchBack(_:)), for: .touchUpInside)

    }
    
    @objc func didTouchBack(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}
