//
//  SchoolSearchViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/21.
//

import UIKit
import RxSwift
import RxCocoa

final class SchoolSearchViewController: UIViewController {
    
    let disposedBag = DisposeBag()
    var schoolData: [SchoolData] = []
    let selectedSchoolObervable = PublishSubject<String>()
    
    let maxDimmedAlpha: CGFloat = 0.48
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray1
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
        
    private lazy var bottomsheetPinchView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainTextColor
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    private lazy var mainContentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var inputSchoolTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "학교검색하기"
        textField.textColor = .mainTextColor
        textField.font = .mySystemFont(ofSize: 12)
        return textField
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shool_search"), for: .normal)
        button.rx.tap.bind { [weak self] in
            guard let keyword = self?.inputSchoolTextField.text else {return}
            self?.getSchoolData(keyword)
        }.disposed(by: disposedBag)
        return button
    }()
    
    private lazy var divideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.divideViewColor
        return view
    }()

    private lazy var schoolTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
            
    var defaultHeight: CGFloat = UIScreen.main.bounds.size.height
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.size.height
    var maximumContainerHeight: CGFloat = UIScreen.main.bounds.size.height
    let dismissibleHeight: CGFloat = 100
    var mainContentViewConstant: CGFloat = 0
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        setupPanGesture()
    }

    func getSchoolData(_ keyword: String) {

        let apiCall = API<[SchoolData]>(url:APIConstants.GET_SCHOOL_DATA, method: .get, parameters: ["keyword": keyword])
        
        apiCall.fetch { result in
            DispatchQueue.main.async {
                self.schoolData = result.data ?? []
                self.schoolTableView.reloadData()
            }
        }
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainContentViewConstant = mainContentView.bounds.size.height + view.safeAreaInsets.bottom
        
        currentContainerHeight = mainContentViewConstant
        maximumContainerHeight = mainContentViewConstant
        defaultHeight = mainContentViewConstant
        
        dimmedView.alpha = 0
        self.dimmedView.alpha = self.maxDimmedAlpha
        animatePresentContainer()
    }
        
    func setupConstraints() {
        [dimmedView, containerView].forEach{ view.addSubview($0) }
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerView.addSubview(mainContentView)
        mainContentView.addSubview(bottomsheetPinchView)
        bottomsheetPinchView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(3)
        }
        
        [inputSchoolTextField, searchButton, divideView, schoolTableView].forEach { mainContentView.addSubview($0) }
        
        inputSchoolTextField.snp.makeConstraints { make in
            make.top.equalTo(bottomsheetPinchView.snp.bottom).offset(62)
            make.leading.equalToSuperview().inset(23)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(36)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputSchoolTextField)
            make.leading.equalTo(inputSchoolTextField.snp.trailing)
        }
        divideView.snp.makeConstraints { make in
            make.top.equalTo(inputSchoolTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(1)
        }
        schoolTableView.snp.makeConstraints { make in
            make.top.equalTo(divideView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(390)
        }

        mainContentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(schoolTableView.snp.bottom).offset(0)
        }
                         
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}

extension SchoolSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = schoolData[indexPath.row]
        let cell = UITableViewCell()
        cell.indentationLevel = 1
        cell.textLabel?.font = .mySystemFont(ofSize: 12)
        cell.textLabel?.text = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSchoolObervable.onNext(schoolData[indexPath.row].name ?? "")
        self.dismiss(animated: false)
    }
}


extension SchoolSearchViewController {

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {}
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
        
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewHeightConstraint?.constant = self.defaultHeight
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
    }
}


        
     
