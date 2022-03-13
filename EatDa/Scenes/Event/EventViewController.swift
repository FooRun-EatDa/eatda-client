//
//  EventViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/13.
//

import UIKit
import SnapKit

final class EventViewController: UIViewController {
    
    // MARK: - UIComponent
    private lazy var noticeBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "bell")
        return button
    }()
    
    private lazy var tapTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트"
        label.font = .myBoldSystemFont(ofSize: 25)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var eventCountLabel: UILabel = {
        let label = UILabel()
        label.text = "12" // 수정 필요
        label.font = .myBoldSystemFont(ofSize: 25)
        label.textColor = UIColor.hashTagTextColor
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: EventCollectionViewCell.width, height: EventCollectionViewCell.height)
                collectionView.collectionViewLayout = flowLayout

        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "EventCollectionViewCell")
        
        return collectionView
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setLayout()
    }
}

extension EventViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell
        
        cell?.setup()
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 0.0, bottom: 11.73, right: 0.0)
    }
    
}


private extension EventViewController {
    func setNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = noticeBarButton
    }
    
    func setLayout() {
        [tapTitleLabel, eventCountLabel, collectionView]
            .forEach { view.addSubview($0) }
        
        tapTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20.0)
            $0.leading.equalToSuperview().inset(22.54)
        }
        
        eventCountLabel.snp.makeConstraints {
            $0.top.equalTo(tapTitleLabel.snp.top)
            $0.leading.equalTo(tapTitleLabel.snp.trailing).offset(8.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(eventCountLabel.snp.bottom).offset(16.04)
            $0.leading.trailing.equalToSuperview().inset(19.49)
            $0.bottom.equalToSuperview()
        }
    }
}
