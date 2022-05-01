//
//  BottomSheetViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/01.
//

import Foundation
import UIKit

enum BottomSheetViewState {
   case expanded
   case normal
}

class BottomSheetViewController: UIViewController {
        
    private let dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.48)
        view.isUserInteractionEnabled = true
        return view
    }()

    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray1
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    var defaultHeight: CGFloat = 476
    var bottomSheetPanMinTopConstant: CGFloat = 30.0
    // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant


    private var contentViewController: UIViewController = {
        let controller = UIViewController()
        return controller
    }()
    
    init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)

        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
    }

    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {

        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)

        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
            dimmedView.alpha = dimAlphaWithBottomSheetTopConstraint(value: bottomSheetViewTopConstraint.constant)
        case .ended:
            if velocity.y > 1500 {
                hideBottomSheetAndGoBack()
                return
            }
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        let defaultPadding = safeAreaHeight+bottomPadding - defaultHeight

        let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant, defaultPadding, safeAreaHeight + bottomPadding])

        if nearestValue == bottomSheetPanMinTopConstant {
            showBottomSheet(atState: .expanded)
        } else if nearestValue == defaultPadding { // Bottom Sheet을 .normal 상태로 보여주기
            showBottomSheet(atState: .normal)
        } else { // Bottom Sheet을 숨기고 현재 View Controller를 dismiss시키기
            hideBottomSheetAndGoBack()
        }
        default:
            break
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }

    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }

    func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }

    private func setupUI() {
        [dimmedView, bottomSheetView, dragIndicatorView].forEach { view.addSubview($0) }

        addChild(contentViewController)
        bottomSheetView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)

        setupLayout()
    }

    private func showBottomSheet(atState: BottomSheetViewState = .normal)  {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
                bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        } else {
                bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
        }

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = self.dimAlphaWithBottomSheetTopConstraint(value: self.bottomSheetViewTopConstraint.constant)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func setupLayout() {

         dimmedView.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }

         bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 476.0)
         NSLayoutConstraint.activate([
             bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             bottomSheetViewTopConstraint,
         ])

         dragIndicatorView.snp.makeConstraints { make in
             make.width.equalTo(60)
             make.height.equalTo(6)
             make.centerX.equalToSuperview()
             make.top.equalTo(bottomSheetView.snp.top).offset(10)
         }
         
         contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
              contentViewController.view.heightAnchor.constraint(equalToConstant: 476),
               contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
               contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
               contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
         ])


     }


    private func dimAlphaWithBottomSheetTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = 0.7

        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom

        // bottom sheet의 top constraint 값이 fullDimPosition과 같으면 dimmer view의 alpha 값이 0.5
        let fullDimPosition = (safeAreaHeight + bottomPadding - defaultHeight) / 2

        // bottom sheet의 top constraint 값이 noDimPosition과 같으면 dimmer view의 alpha 값이 0.
        let noDimPosition = safeAreaHeight + bottomPadding

        // Bottom Sheet의 top constraint 값이 fullDimPosition보다 작으면 경색이 가장 진해진 상태로 지정
        if value < fullDimPosition {
            return fullDimAlpha
        }

        // Bottom Sheet의 top constraint 값이 noDimPosition보다 크면 배경색이 투명한 상태로 지정
        if value > noDimPosition {
            return 0.0
        }

        // 그 외의 경우 top constraint 값에 따라 0.0과 0.7 사이의 alpha 값이 Return되도록 합니다
        return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
    }
}
