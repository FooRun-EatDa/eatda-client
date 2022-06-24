//
//  RestaurantDetailViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/01/30.
//

import UIKit
import RxSwift
import MapKit

class RestaurantDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: RestaurantDetailViewModel?
    var nSelIndex = -1
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "restaurant_detail")
        return imageView
    }()
    lazy var stickyNaviView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    private lazy var floatButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 60
        button.clipsToBounds = true
        button.setImage(UIImage(named: "floating_button"), for: .normal)
        return button
   }()
    
    
    
    lazy var restaurantDiscripionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let nameLbl: UILabel = {
        let label = UILabel()
        label.text = "주호식당"
        label.textColor = UIColor.mainTextColor
        label.font = .myBoldSystemFont(ofSize: 26)
        return label
    }()
    let explanationLbl: UILabel = {
        let label = UILabel()
        label.text = "경희대 대표 요리주점"
        label.textColor = UIColor.mainTextColor
        label.font = .myMediumSystemFont(ofSize: 15)
        return label
    }()
    private lazy var imageCRBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .mySystemFont(ofSize: 12)
        button.setTitleColor(.grayTextColor, for: .normal)
        button.setTitle("이미지 출처", for: .normal)
        return button
    }()
    lazy var hashTagCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.tag = 2
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        view.register(RestauranthashTagCVC.self, forCellWithReuseIdentifier: RestauranthashTagCVC.id)
        return view
    }()
    private lazy var restaurantDiscripionDivideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: 0xE7E7E7)
        return view
    }()
    
    
    
    private lazy var restaurantDetailTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.allowsSelection = false
        view.tag = 10
        view.register(RestaurantDetailTVC.self, forCellReuseIdentifier: "RestaurantDetailTVC")
        return view
    }()
    private lazy var restaurantDetailTableDivideView: UIView = {
        let view = UIView()
        view.backgroundColor = .seperatorColor
        return view
    }()
    
    
    
    lazy var restaurantMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let menuTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "메뉴"
        label.textColor = UIColor.mainTextColor
        label.font = .myMediumSystemFont(ofSize: 22)
        return label
    }()
    private let menuAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("전체보기 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.mainTextColor, for: .normal)
        button.setImage(UIImage(named: "black_right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    private lazy var menuTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.separatorColor =  .seperatorColor
        view.tag = 11
        view.isScrollEnabled = false
        view.register(RestaurantMenuTVC.self, forCellReuseIdentifier: "RestaurantMenuTVC")
        return view
    }()
    private lazy var menuTableDivideView: UIView = {
        let view = UIView()
        view.backgroundColor = .seperatorColor
        return view
    }()
    
    
    
    lazy var restaurantLocationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let mapTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "매장 위치"
        label.textColor = UIColor.mainTextColor
        label.font = .myMediumSystemFont(ofSize: 22)
        return label
    }()
    private let mapView: UIView = {
        // 받아온 위도, 경도, 맛집 종류(노랑색:0, 빨강색:1) 핀 두가지 중 무엇인지
        let view = RestaurantMapView(restaurantCoordinate: CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525), categoryID: 0)
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var mapDivideView: UIView = {
        let view = UIView()
        view.backgroundColor = .seperatorColor
        return view
    }()
    
    
    
    lazy var restaurantReviewView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let reviewTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "리뷰"
        label.textColor = UIColor.mainTextColor
        label.font = .myMediumSystemFont(ofSize: 22)
        return label
    }()
    private let reviewCountLbl: UILabel = {
        let label = UILabel()
        label.text = "(\(123))"
        label.textColor = UIColor.mainTextColor
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private let reviewAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("전체보기 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.mainTextColor, for: .normal)
        button.setImage(UIImage(named: "black_right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    private lazy var reviewTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        view.separatorColor = UIColor.init(hex: 0xE7E7E7)
        view.tag = 12
        view.register(RestaurantReviewTVC.self, forCellReuseIdentifier: "RestaurantReviewTVC")
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        setViewConstraints()
        setGesture()
//        bind(viewModel!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print(viewModel!.searchRestaurantData.values)
//        viewModel!.searchRestaurantData
//            .asDriver(onErrorDriveWith: .empty())
//            .drive(onNext: {a in
//                self.nameLbl.text = a.address
//                self.explanationLbl.text = a.explanation
//            }).disposed(by: disposeBag)
    }
        
    func bind(_ viewModel: RestaurantDetailViewModel) {
        mapView.rx.tapGesture()
            .when(.recognized)
            .bind { _ in
                viewModel.mapViewTapped.onNext(())
            }
            .disposed(by: disposeBag)
        
        
        viewModel.mapViewTapped
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                let viewController = MapViewController()
                //viewController.bind(viewModel)
                viewController.hidesBottomBarWhenPushed = true
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
    }

    
    func createViews() {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(headerContainerView)
        headerContainerView.addSubview(imageView)
        
        contentView.addSubview(restaurantDiscripionView)
        [nameLbl, explanationLbl, imageCRBtn, hashTagCollectionView, restaurantDiscripionDivideView].forEach { restaurantDiscripionView.addSubview($0) }
        
        contentView.addSubview(restaurantDetailTableView)
        contentView.addSubview(restaurantDetailTableDivideView)
        
        contentView.addSubview(restaurantMenuView)
        [menuTitleLbl, menuAllBtn, menuTableView, menuTableDivideView].forEach { restaurantMenuView.addSubview($0) }
        
        contentView.addSubview(restaurantLocationView)
        [mapTitleLbl, mapView, mapDivideView].forEach { restaurantLocationView.addSubview($0) }

        contentView.addSubview(restaurantReviewView)
        [reviewTitleLbl, reviewCountLbl, reviewAllBtn, reviewTableView].forEach { restaurantReviewView.addSubview($0) }
             

        
    }
    
    func setViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(scrollView.snp.top).offset(220)
            make.bottom.equalTo(scrollView.snp.bottom)
//            make.height.equalTo(2000)
        }
        
        let headerContainerViewBottom : NSLayoutConstraint!
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        headerContainerViewBottom = headerContainerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        
        
        let imageViewTopConstraint: NSLayoutConstraint!
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
        
        
        restaurantDiscripionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(50)
        }
        explanationLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        imageCRBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLbl)
            make.trailing.equalToSuperview().inset(20)
        }
        hashTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(explanationLbl.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        restaurantDiscripionDivideView.snp.makeConstraints { make in
            make.top.equalTo(hashTagCollectionView.snp.bottom).offset(27)
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
        }
        
        
        restaurantDetailTableView.snp.makeConstraints { make in
            make.top.equalTo(restaurantDiscripionDivideView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(216)
        }
        restaurantDetailTableDivideView.snp.makeConstraints { make in
            make.top.equalTo(restaurantDetailTableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        
        restaurantMenuView.snp.makeConstraints { make in
            make.top.equalTo(restaurantDetailTableDivideView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(476)
        }
        menuTitleLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        menuAllBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-24)
        }
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(menuTitleLbl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(430)
        }
        menuTableDivideView.snp.makeConstraints { make in
            make.top.equalTo(menuTableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        
        restaurantLocationView.snp.makeConstraints {
            $0.top.equalTo(menuTableDivideView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(270)
        }
        mapTitleLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        mapView.snp.makeConstraints {
            $0.top.equalTo(mapTitleLbl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        mapDivideView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        
        
        restaurantReviewView.snp.makeConstraints {
            $0.top.equalTo(mapDivideView.snp.bottom)
            $0.height.equalTo(500)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        reviewTitleLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        reviewCountLbl.snp.makeConstraints {
            $0.centerY.equalTo(reviewTitleLbl)
            $0.leading.equalTo(reviewTitleLbl.snp.trailing).offset(8)
        }
        reviewAllBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        reviewTableView.snp.makeConstraints {
            $0.top.equalTo(reviewAllBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        reviewTableView.layoutIfNeeded()
        
        restaurantReviewView.snp.remakeConstraints { (make) in
            make.top.equalTo(mapDivideView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(reviewTableView.contentSize.height + 70)
            make.bottom.equalToSuperview()
        }
        
        
        
        headerContainerView.addSubview(stickyNaviView)
        stickyNaviView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(headerContainerView)
            make.height.equalTo(100)
        }
        
        view.addSubview(floatButton)
        floatButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
            $0.height.width.equalTo(120)
        }
    }
    
    func setGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        headerContainerView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        headerContainerView.addGestureRecognizer(swipeRight)
    }
    
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left :
                //                   pageControl.currentPage -= 1
                //                   imgView.image = UIImage(named: images[pageControl.currentPage])
                print("page Changed1")
                
                imageView.image = UIImage(named: "menu_datail")
                
            case UISwipeGestureRecognizer.Direction.right :
                //                   pageControl.currentPage += 1
                //                   imgView.image = UIImage(named: images[pageControl.currentPage])
                print("page Changed2")
                
                imageView.image = UIImage(named: "menu_datail")
            default:
                break
            }
        }
    }
    
}


extension RestaurantDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestauranthashTagCVC.id, for: indexPath)
        if let cell = cell as? RestauranthashTagCVC {
            cell.model = "ㅁㄴㅇㄹ"
            cell.titleLabel.text = "#\(String(indexPath.row))"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

extension RestaurantDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 200 {
            UIView.animate(withDuration: 2.0, animations: {
                self.stickyNaviView.isHidden = false
            })
        }else {
            UIView.animate(withDuration: 2.0, animations: {
                self.stickyNaviView.isHidden = true
            })
        }
    }
}

extension RestaurantDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10 {
            return 5
        }else if tableView.tag == 11{
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 10 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantDetailTVC", for: indexPath) as? RestaurantDetailTVC else {
                return UITableViewCell()
            }
            
            switch indexPath.row {
            case 0:
                cell.cellTitleLabel.text = "종류"
                cell.cellDetailTitleLabel.text = "요리주점"
                cell.cellDetailButton.isHidden = true
                
            case 1:
                cell.cellTitleLabel.text = "전화번호"
                cell.cellDetailButton.setTitle("010-1111-1111  ", for: .normal)
                cell.cellDetailTitleLabel.isHidden = true
                
            case 2:
                cell.cellTitleLabel.text = "지역"
                cell.cellDetailButton.setTitle("정건  ", for: .normal)
                cell.cellDetailTitleLabel.isHidden = true
                cell.cellDetailButton.setImage(UIImage(named: "black_down"), for: .normal)
                
                cell.cellDetailButton.rx.tap.bind{ _ in
                    print(self.nSelIndex)
                    
                    if self.nSelIndex == indexPath.row {
                        cell.cellDetailOpenedLabeView.isHidden = true
                        cell.cellDetailButton.setImage(UIImage(named: "black_down"), for: .normal)
                        
                        self.restaurantDetailTableView.snp.remakeConstraints { make in
                            make.top.equalTo(self.restaurantDiscripionDivideView.snp.bottom).offset(16)
                            make.leading.trailing.equalToSuperview()
                            make.height.equalTo(216)
                        }
                        
                    }else{
                        cell.cellDetailOpenedLabeView.text = "경기 수원시 영통구 덕영대로 1699"
                        cell.cellDetailOpenedLabeView.isHidden = false
                        cell.cellDetailButton.setImage(UIImage(named: "black_up"), for: .normal)
                        
                        self.restaurantDetailTableView.snp.remakeConstraints { make in
                            make.top.equalTo(self.restaurantDiscripionDivideView.snp.bottom).offset(16)
                            make.leading.trailing.equalToSuperview()
                            make.height.equalTo(250)
                        }
                        
                        
                    }
                    
                    self.nSelIndex = indexPath.row
                    print(self.nSelIndex)
        
                }.disposed(by: disposeBag)
                
            case 3:
                cell.cellTitleLabel.text = "가격대"
                cell.cellDetailTitleLabel.text = "12,000 - 20,000원"
                cell.cellDetailButton.isHidden = true
                
            case 4:
                cell.cellTitleLabel.text = "영업시간"
                cell.cellDetailButton.setTitle("09:00 - 11:00 ", for: .normal)
                cell.cellDetailButton.setImage(UIImage(named: "black_down"), for: .normal)
                cell.cellDetailTitleLabel.isHidden = true
                
                cell.cellDetailButton.rx.tap.bind{ _ in
                    print(self.nSelIndex)
                    
                    if self.nSelIndex == indexPath.row {
                        cell.cellDetailOpenedLabeView.isHidden = true
                        cell.cellDetailButton.setImage(UIImage(named: "black_down"), for: .normal)
                        
                        self.restaurantDetailTableView.snp.remakeConstraints { make in
                            make.top.equalTo(self.restaurantDiscripionDivideView.snp.bottom).offset(16)
                            make.leading.trailing.equalToSuperview()
                            make.height.equalTo(216)
                        }
                        
                    }else{
                        cell.cellDetailOpenedLabeView.text = "주말 09:00 - 11:00"
                        cell.cellDetailOpenedLabeView.isHidden = false
                        cell.cellDetailButton.setImage(UIImage(named: "black_up"), for: .normal)
                        
                        self.restaurantDetailTableView.snp.remakeConstraints { make in
                            make.top.equalTo(self.restaurantDiscripionDivideView.snp.bottom).offset(16)
                            make.leading.trailing.equalToSuperview()
                            make.height.equalTo(250)
                        }
                    }
                    
                    self.nSelIndex = indexPath.row
                    print(self.nSelIndex)
                    
                }.disposed(by: disposeBag)
                
                
            default:
                return UITableViewCell()
            }
            
            return cell
            
        }else if tableView.tag == 11{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantMenuTVC", for: indexPath) as? RestaurantMenuTVC else {
                return UITableViewCell()
            }
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantReviewTVC", for: indexPath) as? RestaurantReviewTVC else {
                return UITableViewCell()
            }
            
            if indexPath.row == 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 10 {
            
            switch indexPath.row {
            case 0,1,3:
                return 40
            default:
                if nSelIndex == indexPath.row {
                    return 80
                }else {
                    return 40
                }
            }
            
        }else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 10 {
            if nSelIndex == indexPath.row {
                nSelIndex = -1
            } else {
                nSelIndex = indexPath.row
            }
            tableView.reloadData()
            
        }else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}






