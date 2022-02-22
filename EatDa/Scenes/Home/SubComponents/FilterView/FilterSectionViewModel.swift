//
//  FilterSectionViewModel.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/19.
//

import RxSwift
import RxCocoa

enum ShowType: String {
    case none
    case category
    case district
    case price
    case hashtag

    var tags: [String] {
        switch self {
        case .none:
           return []
        case .category:
            return ["선택안함", "한식", "분식", "카페·디저트", "일식", "회·해물", "양식", "중식", "고기·구이", "아시안", "찜·탕", "버거·샌드위치", "주점", "세계음식", "죽", "돈까스", "치킨", "피자", "패스트푸드", "샐러드", "뷔페", "족발·보쌈"]
        case .district:
            return ["선택안함", "정건", "마을", "중상", "영리단길", "영일중", "서그내", "8출"]
        case .price:
            return ["선택안함", "10,000원 이하", "10,000원 ~ 15,000원", "15,000원 ~ 20,000원", "20,000원 ~ 30,000원", "30,000원 이상"]
        case .hashtag:
            return ["선택안함", "#flex", "#혼밥", "#점심", "#저녁", "#데이트", "#이자카야", "#2차", "#N차", "#맥주", "#조용한", "#칵테일", "#해장", "#감성", "#갓성비", "#10분컷"]
        }
    }
}

struct FilterSectionViewModel {
    let showFilter: Driver<(Bool, ShowType)>
    let filterViewType = PublishSubject<(Bool, ShowType)>()

    
    init() {
        self.showFilter = filterViewType
            .asDriver(onErrorJustReturn: (true, .none))
        
    }
    
}
