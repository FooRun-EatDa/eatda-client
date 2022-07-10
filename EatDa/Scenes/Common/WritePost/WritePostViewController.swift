//
//  WritePostViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/04/05.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class WritePostViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    lazy var navView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var navBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.mainTextColor, for: .normal)
        button.titleLabel?.font = UIFont.mySystemFont(ofSize: 15)
        return button
    }()
    
    lazy var navOkButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.applyButtonColor, for: .normal)
        button.titleLabel?.font = UIFont.mySystemFont(ofSize: 15)
        return button
    }()

    lazy var navTitle: UILabel = {
        let label = UILabel()
        label.text = "작성하기"
        label.font = UIFont.myBoldSystemFont(ofSize: 15)
        return label
    }()
    
    
    private lazy var myActivityView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var myActivityPostView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var myActivityreviewView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var myActivityEventView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var myActivitydiviedView1: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayBorderColor
        return view
    }()

    private lazy var myActivitydiviedView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayBorderColor
        return view
    }()

    private lazy var myActivityPostButton: UIButton = {
        let button = UIButton()
        button.rx.tap.bind { [weak self] in
            print("1")

//            let vc = ChangeProfileViewController()
//            vc.hidesBottomBarWhenPushed = true
//            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var myActivityReviewButton: UIButton = {
        let button = UIButton()
        button.rx.tap.bind { [weak self] in
            print("2")
        }.disposed(by: disposeBag)

        return button
    }()
    
    private lazy var myActivityEventButton: UIButton = {
        let button = UIButton()
        button.rx.tap.bind { [weak self] in
            print("3")

        }.disposed(by: disposeBag)

        return button
    }()

    
    private lazy var myActivityPostTitleLable: UILabel = {
        let label = UILabel()
        label.font = .myMediumSystemFont(ofSize: 13)
        label.text = "작성글"
        label.textColor = .discribeTextColor
        return label
    }()

    private lazy var myActivityPostCountLable: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 18)
        label.text = "0"
        label.textColor = .mainTextColor
        return label
    }()

    private lazy var myActivityReviewTitleLable: UILabel = {
        let label = UILabel()
        label.font = .myMediumSystemFont(ofSize: 13)
        label.text = "리뷰"
        label.textColor = .discribeTextColor
        return label
    }()

    private lazy var myActivityReviewCountLable: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 18)
        label.text = "0"
        label.textColor = .mainTextColor
        return label
    }()

    
    private lazy var myActivityEventTitleLable: UILabel = {
        let label = UILabel()
        label.font = .myMediumSystemFont(ofSize: 13)
        label.text = "이벤트"
        label.textColor = .discribeTextColor
        return label
    }()

    private lazy var myActivityEventCountLable: UILabel = {
        let label = UILabel()
        label.font = .myBoldSystemFont(ofSize: 18)
        label.text = "0"
        label.textColor = .mainTextColor
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    
    func bind(_ viewModel: WritePostViewModel) {
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
        navBackButton.addTarget(self, action: #selector(didTouchBack(_:)), for: .touchUpInside)
        navBackButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(23)
            make.centerY.equalToSuperview()
        }
        
        navView.addSubview(navOkButton)
        navOkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-23)
            make.centerY.equalToSuperview()
        }

        
        
        view.addSubview(myActivityView)
        
        myActivityView.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(144)
        }
        
        [myActivityPostView, myActivityreviewView, myActivityEventView, myActivitydiviedView1, myActivitydiviedView2].forEach{ myActivityView.addSubview($0) }

        
        let btnwidth = ( UIScreen.main.bounds.size.width - 44 ) / 3
        myActivityPostView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(btnwidth)
        }
        myActivityreviewView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(myActivityPostView.snp.trailing)
            make.height.equalTo(100)
            make.width.equalTo(btnwidth)
        }
        
        myActivityEventView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(myActivityreviewView.snp.trailing)
            make.height.equalTo(100)
            make.width.equalTo(btnwidth)
        }
        
        [myActivityPostTitleLable, myActivityPostCountLable, myActivityPostButton].forEach{ myActivityPostView.addSubview($0) }
        myActivityPostCountLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        
        myActivityPostTitleLable.snp.makeConstraints { make in
            make.top.equalTo(myActivityPostCountLable.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        myActivityPostButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [myActivityReviewTitleLable, myActivityReviewCountLable, myActivityReviewButton ].forEach{ myActivityreviewView .addSubview($0) }
        myActivityReviewCountLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        
        myActivityReviewTitleLable.snp.makeConstraints { make in
            make.top.equalTo(myActivityPostCountLable.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        myActivityReviewButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        
        [myActivityEventTitleLable, myActivityEventCountLable, myActivityEventButton ].forEach{ myActivityEventView.addSubview($0) }
        myActivityEventCountLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        
        myActivityEventTitleLable.snp.makeConstraints { make in
            make.top.equalTo(myActivityEventCountLable.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        
        myActivityEventButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        myActivitydiviedView1.snp.makeConstraints { make in
            make.leading.equalTo(myActivityPostButton.snp.trailing)
            make.centerY.equalTo(myActivityPostButton)
            make.width.equalTo(1)
            make.height.equalTo(30)
        }
        myActivitydiviedView2.snp.makeConstraints { make in
            make.leading.equalTo(myActivityReviewButton.snp.trailing)
            make.centerY.equalTo(myActivityPostButton)
            make.width.equalTo(1)
            make.height.equalTo(30)
        }
        
        
        
        
        
        
        
        
        
    }
    
    @objc func didTouchBack(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}
