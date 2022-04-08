//
//  FilterView.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/19.
//

import UIKit
import TTGTags

class FilterView: UIView {
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    private var tags: [String] = []
    private var showType: ShowType = .none
    private var selectedDict: [ShowType: [String]] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(showType: ShowType) {
        self.showType = showType
        self.tags = showType.tags
        
        if tagCollectionView.allTags().count > 0 { tagCollectionView.removeAllTags() }
        
        tagCollectionView.alignment = .left
        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }

}


extension FilterView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(
        _ textTagCollectionView: TTGTextTagCollectionView!,
        didTap tag: TTGTextTag!,
        at index: UInt
    ) {
        let item = tags[Int(index)]

        if tag.selected {
            selectedDict[showType, default: []].append(item)
        } else {
            selectedDict[showType]?.removeAll(where: {$0 == item})
        }
        
        print(selectedDict)
    }
}

private extension FilterView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)

        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupTagCollectionView() {
        tagCollectionView.delegate = self

        let insetValue: CGFloat = 14.0
        tagCollectionView.contentInset = UIEdgeInsets(
            top: insetValue,
            left: insetValue,
            bottom: insetValue,
            right: insetValue
        )

        let cornerRadiusValue: CGFloat = 18.0
        let shadowOpacity: CGFloat = 0.0
        let extraSpace = CGSize(width: 20.0, height: 20.0)
        let color = UIColor.lightGrayBorderColor

        let style = TTGTextTagStyle()
        style.backgroundColor = .white
        style.cornerRadius = cornerRadiusValue
        style.borderColor = color
        style.borderWidth = 1.0
        style.shadowOpacity = shadowOpacity
        style.extraSpace = extraSpace

        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .filterBackgroundColor
        selectedStyle.cornerRadius = cornerRadiusValue
        selectedStyle.borderColor = UIColor.filterStrokeColor
        style.borderWidth = 1.0
        selectedStyle.shadowOpacity = shadowOpacity
        selectedStyle.extraSpace = extraSpace

        tags.forEach { tag in
            let font = UIFont.mySystemFont(ofSize: 12)
            let tagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: color
            )
            let selectedTagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: .label
            )

            let tag = TTGTextTag(
                content: tagContents,
                style: style,
                selectedContent: selectedTagContents,
                selectedStyle: selectedStyle
            )
            tagCollectionView.addTag(tag)
        }
    }
}
