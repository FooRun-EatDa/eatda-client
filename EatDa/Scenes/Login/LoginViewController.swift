//
//  LoginViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/01.
//

import Foundation
import UIKit
import RxSwift

class GuideVO {
    var image: String?
    var main: String?
    var sub: String?
}

class LoginViewController: UIViewController {
    
    var dataset = [("guideImage1", "우리학교 맛집은?", "대학생 취향 저격 맛집 추천"),
                   ("guideImage2", "오늘 점심 같이 먹을사람?", "번개모임으로 학교친구 만들기"),
                   ("guideImage3", "지금까지 이런 이벤트는 없었다", "내가 낸 아이디어가 신메뉴로!")]
    
    lazy var data: [GuideVO] = {
        var dataList = [GuideVO]()
        for (image, main, sub) in self.dataset {
            var vo = GuideVO()
            vo.image = image
            vo.main = main
            vo.sub = sub

            dataList.append(vo)
        }
        return dataList
    }()
    
    var currentIndex = 0
    var timer: Timer?
    let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = .zero

        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.register(ImageSliderCollectionViewCell.self, forCellWithReuseIdentifier: ImageSliderCollectionViewCell.id)
        return view
    }()
        
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = data.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.applyButtonColor
        pageControl.isUserInteractionEnabled = false
        pageControl.addTarget(self, action: #selector(pageValueDidChanged), for: .valueChanged)
        return pageControl
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .applyButtonColor
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 14)
        button.rx.tap
            .bind {
                let bottomSheetVC = BottomSheetViewController(contentViewController: SplashViewController())
                bottomSheetVC.modalPresentationStyle = .overFullScreen
                self.present(bottomSheetVC, animated: false, completion: nil)
                
            }.disposed(by: disposeBag)
        return button
    }()
    
    private lazy var regiesterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.mainTextColor.cgColor
        button.setTitleColor(.mainTextColor, for: .normal)
        button.layer.cornerRadius = 8
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .myBoldSystemFont(ofSize: 14)
        return button
    }()
        
    private lazy var noLoginLinkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .mySystemFont(ofSize: 12)
        button.setTitleColor(.applyButtonColor, for: .normal)
        button.setTitle("비회원으로 둘러보기", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    func initUI(){
        [collectionView, pageControl, loginButton, regiesterButton, noLoginLinkButton].forEach { view.addSubview($0) }
        noLoginLinkButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        regiesterButton.snp.makeConstraints { make in
            make.bottom.equalTo(noLoginLinkButton.snp.top).offset(-18)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(regiesterButton.snp.top).offset(-12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }

        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }

       
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top)
        }
    }
    
    @objc func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(pageValueDidChanged), userInfo: nil, repeats: true)
    }
    
    @objc func pageValueDidChanged() {
        if currentIndex < data.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
        pageControl.currentPage = currentIndex

        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(pageValueDidChanged), userInfo: nil, repeats: true)
    }

}


extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSliderCollectionViewCell.id, for: indexPath) as! ImageSliderCollectionViewCell
        let data = data[indexPath.row]
        cell.image.image = UIImage(named: data.image!)
        cell.mainGuideLabel.text = data.main
        cell.subGuideLabel.text = data.sub

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = currentIndex
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(pageValueDidChanged), userInfo: nil, repeats: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
    }
}

