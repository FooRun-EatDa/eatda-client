//
//  RestaurantDetailViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/01/30.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
 
    // MARK: - UIComponent
    private lazy var shareButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "share")
        return button
    }()
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentsView = UIView()
    
    private lazy var floatButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "restaurant_detail")
        return button
    }()
    
    private lazy var restaurantImageView = UIView()
    private lazy var restaurantDetailView = UIView()
    private lazy var restaurantMenuView = UIView()
    private lazy var restaurantLocationView = UIView()
    private lazy var restaurantReviewView = UIView()

    //TODO: divideView 를 for문으로 반복생성하도록 수정필요
    private lazy var divideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: 0xE7E7E7)
        return view
    }()
    private lazy var divideView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: 0xF8F8F8)
        return view
    }()
    private lazy var divideView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: 0xF8F8F8)
        return view
    }()
    private lazy var divideView4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: 0xF8F8F8)
        return view
    }()
    
    

    //restaurantImageView
    private lazy var imageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.tag = 1
        return view
    }()
    private let nameLbl: UILabel = {
        let label = UILabel()
        label.text = "주호식당"
        label.textColor = UIColor.mainTextColor
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    private let explanationLbl: UILabel = {
        let label = UILabel()
        label.text = "경희대 대표 요리주점"
        label.textColor = UIColor.mainTextColor
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    private lazy var hashTagCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.tag = 2
        return view
       }()
    private lazy var detailTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.allowsSelection = false
        view.tag = 10
        return view
    }()
    
    //restaurantDetailView
    private let menuTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "메뉴"
        label.textColor = UIColor.mainTextColor
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    private let menuAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("전체보기 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    private lazy var menuTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        view.separatorColor = UIColor.init(hex: 0xE7E7E7)
        view.tag = 11
        return view
    }()
    
    //restaurantMapView
    private let mapTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "매장 위치"
        label.textColor = UIColor.mainTextColor
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    private let mapView = UIView()
    
    
    
    //restaurantReviewView
    private let reviewTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "리뷰"
        label.textColor = UIColor.mainTextColor
        label.font = .boldSystemFont(ofSize: 19)
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
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(UIColor.mainTextColor, for: .normal)
        button.setImage(UIImage(named: "arrow"), for: .normal)
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
        return view
    }()
    
    
    
    // MARK: - other variables
    var imageSource: [String] = ["1","2","3"]


    override func viewDidLoad() {
        view.backgroundColor = .systemBackground

        detailTableView.register(RestaurantDetailTVC.self, forCellReuseIdentifier: "RestaurantDetailTVC")
        menuTableView.register(RestaurantMenuTVC.self, forCellReuseIdentifier: "RestaurantMenuTVC")
        reviewTableView.register(RestaurantReviewTVC.self, forCellReuseIdentifier: "RestaurantReviewTVC")
        imageCollectionView.register(RestaurantImageCVC.self, forCellWithReuseIdentifier: RestaurantImageCVC.id)
        hashTagCollectionView.register(RestauranthashTagCVC.self, forCellWithReuseIdentifier: RestauranthashTagCVC.id)

        tabBarController?.tabBar.isHidden = true
        
        setRightBarButtonItem()
        setLayout()
    }

    
    @objc func showDetail(_ sender: AnyObject?){
        
    }
}


// MARK: - private
private extension RestaurantDetailViewController {
    
    func setRightBarButtonItem() {
        self.navigationItem.rightBarButtonItems = [shareButton]
    }

    
    func setLayout() {

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentsView)
        contentsView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
//        view.addSubview(floatButton)
//        floatButton.snp.makeConstraints {
//            $0.trailing.bottom.equalToSuperview().inset(14)
//            $0.width.height.equalTo(60)
//        }

        
        
        [restaurantImageView, divideView, restaurantDetailView, divideView2, restaurantMenuView, divideView3, restaurantLocationView, divideView4, restaurantReviewView ].forEach { contentsView.addSubview($0) }
        restaurantImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(350)
        }
        divideView.snp.makeConstraints {
            $0.top.equalTo(restaurantImageView.snp.bottom)
            $0.height.equalTo(2)
            $0.leading.trailing.equalToSuperview()
        }
        restaurantDetailView.snp.makeConstraints {
            $0.top.equalTo(divideView.snp.bottom)
            $0.height.equalTo(230)
            $0.leading.trailing.equalToSuperview()
        }
        divideView2.snp.makeConstraints {
            $0.top.equalTo(restaurantDetailView.snp.bottom)
            $0.height.equalTo(10)
            $0.leading.trailing.equalToSuperview()
        }
        restaurantMenuView.snp.makeConstraints {
            $0.top.equalTo(divideView2.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(490)
        }
        divideView3.snp.makeConstraints {
            $0.top.equalTo(restaurantMenuView.snp.bottom)
            $0.height.equalTo(10)
            $0.leading.trailing.equalToSuperview()
        }
        restaurantLocationView.snp.makeConstraints {
            $0.top.equalTo(divideView3.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(270)
        }
        divideView4.snp.makeConstraints {
            $0.top.equalTo(restaurantLocationView.snp.bottom)
            $0.height.equalTo(10)
            $0.leading.trailing.equalToSuperview()
        }
        restaurantReviewView.snp.makeConstraints {
            $0.top.equalTo(divideView4.snp.bottom)
            $0.height.equalTo(500)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
        [imageCollectionView, nameLbl, explanationLbl, hashTagCollectionView].forEach { restaurantImageView.addSubview($0) }
        imageCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        nameLbl.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        explanationLbl.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        hashTagCollectionView.snp.makeConstraints {
            $0.top.equalTo(explanationLbl.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(315)
            $0.height.equalTo(30)
        }
        
        
        
        [detailTableView].forEach { restaurantDetailView.addSubview($0) }
        detailTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(216)
        }
        
        
        
        [menuTitleLbl, menuAllBtn, menuTableView ].forEach { restaurantMenuView.addSubview($0) }
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
            $0.height.equalTo(400)
        }
        
        
        
        [mapTitleLbl, mapView].forEach { restaurantLocationView.addSubview($0) }
        mapTitleLbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        mapView.backgroundColor = .lightGray
        mapView.snp.makeConstraints {
            $0.top.equalTo(mapTitleLbl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        
        
        [reviewTitleLbl, reviewCountLbl, reviewAllBtn, reviewTableView].forEach { restaurantReviewView.addSubview($0) }
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
            $0.height.equalTo(420)
        }
        reviewTableView.layoutIfNeeded()

        restaurantReviewView.snp.remakeConstraints { (make) in
            make.top.equalTo(divideView4.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(reviewTableView.contentSize.height + 40)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
}

extension RestaurantDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return imageSource.count
        } else {
            return 2
        }
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         if collectionView.tag == 1 {
             
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantImageCVC.id, for: indexPath)
             
             if let cell = cell as? RestaurantImageCVC {
//                 cell.model =  imageSource[indexPath.item]
  
                 let image = UIImageView()
                 image.image = UIImage(named: "restaurant_detail")
                 cell.addSubview(image)
                 image.contentMode = .scaleAspectFill
                 image.snp.makeConstraints { make in
                     make.top.bottom.leading.trailing.equalToSuperview()
                 }
             }
             return cell

         }else {
             
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestauranthashTagCVC.id, for: indexPath)
             if let cell = cell as? RestauranthashTagCVC {
                 cell.model = "ㅁㄴㅇㄹ"
                 cell.titleLabel.textColor = UIColor(hex: 0xF8BA00)
                 cell.titleLabel.text = "#\(String(indexPath.row))"
             }
             cell.layer.cornerRadius = 15
             cell.backgroundColor = UIColor.init(hex: 0xFFF0D9)
             
             
             return cell
         }
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
            return CGSize(width: 325, height: collectionView.frame.height)
        }else {
            return CGSize(width: 40, height: 30)
        }
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        }else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
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
        //            cell.imageView?.image = UIImage(named0: "heart")
            case 0:
                cell.textLabel?.text = "종류"
                cell.textLabel?.textColor = UIColor.subTextColor
                cell.textLabel?.font = .boldSystemFont(ofSize: 13)
       
                let detailLabel = UILabel()
                detailLabel.text = "요리주점"
                detailLabel.textAlignment = .right
                detailLabel.sizeToFit()
                detailLabel.textColor = UIColor.mainTextColor
                detailLabel.font = .boldSystemFont(ofSize: 13)

                cell.accessoryView = detailLabel
                cell.indentationLevel = 1

            case 1:
                cell.textLabel?.text = "전화번호"
                cell.textLabel?.textColor = UIColor.subTextColor
                cell.textLabel?.font = .boldSystemFont(ofSize: 13)

                let detailButton = UIButton(type: .custom)
                detailButton.addTarget(self, action: #selector(showDetail(_:)), for: .touchUpInside)
                detailButton.sizeToFit()

                let callBtn = UIImageView()
                let callLbl = UILabel()
                callBtn.image = UIImage(named: "heart")
                callLbl.font = .boldSystemFont(ofSize: 13)
                callLbl.text = "010-1111-1111"
                
                [callBtn, callLbl].forEach { detailButton.addSubview($0) }
                callBtn.snp.makeConstraints {
                    $0.trailing.equalToSuperview()
                    $0.height.width.equalTo(24)
                    $0.centerY.equalToSuperview()
                }
                callLbl.snp.makeConstraints {
                    $0.trailing.equalTo(callBtn.snp.leading).offset(-10)
                    $0.centerY.equalToSuperview()
                }

                cell.accessoryView = detailButton
                cell.indentationLevel = 1

            case 2:
                cell.textLabel?.text = "지역"
                cell.textLabel?.textColor = UIColor.subTextColor
                cell.textLabel?.font = .boldSystemFont(ofSize: 13)

                let button = UIButton(type: .custom)
                button.setTitle("정건 🔻", for: .normal)
                button.titleLabel?.font = .boldSystemFont(ofSize: 13.0)
                button.setTitleColor(UIColor.mainTextColor, for: .normal)
                button.sizeToFit()

                cell.accessoryView = button
                cell.indentationLevel = 1

            case 3:
                cell.textLabel?.text = "가격대"
                cell.textLabel?.textColor = UIColor.subTextColor
                cell.textLabel?.font = .boldSystemFont(ofSize: 13)
       
                let detailLabel = UILabel()
                detailLabel.text = "12,000 - 20,000원"
                detailLabel.textAlignment = .right
                detailLabel.sizeToFit()
                detailLabel.textColor = UIColor.mainTextColor
                detailLabel.font = .boldSystemFont(ofSize: 13)

                cell.accessoryView = detailLabel
                cell.indentationLevel = 1

            case 4:
                cell.textLabel?.text = "영업시간"
                cell.textLabel?.textColor = UIColor.subTextColor
                cell.textLabel?.font = .boldSystemFont(ofSize: 13)

                let button = UIButton(type: .custom)
                button.setTitle("09:00 - 11:00 🔻", for: .normal)
                button.titleLabel?.font = .boldSystemFont(ofSize: 13.0)
                button.setTitleColor(UIColor.mainTextColor, for: .normal)
                button.sizeToFit()

                cell.accessoryView = button
                cell.indentationLevel = 1

            default:
                cell.textLabel?.text = "종류"
                cell.textLabel?.textColor = UIColor.subTextColor
                cell.textLabel?.font = .boldSystemFont(ofSize: 13)
       
                let detailLabel = UILabel()
                detailLabel.text = "요리주점"
                detailLabel.textAlignment = .right
                detailLabel.sizeToFit()
                detailLabel.textColor = UIColor.mainTextColor
                detailLabel.font = .boldSystemFont(ofSize: 13)

                cell.accessoryView = detailLabel
                cell.indentationLevel = 1

            }
            return cell

        }else if tableView.tag == 11{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantMenuTVC", for: indexPath) as? RestaurantMenuTVC else {
                return UITableViewCell()
            }
            
            if indexPath.row == 2 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0);
            }
                
            return cell
            
        } else{
            
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
            return 40
        }else if tableView.tag == 11 {
            return 130
        } else {
            return UITableView.automaticDimension
        }
    }
    
}


