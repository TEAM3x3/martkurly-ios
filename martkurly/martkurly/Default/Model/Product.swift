//
//  Product.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

/*
 SaleType
 
 savePercent => "SAVE 40%"
 saleAndGift => "SALE + GIFT"
 none => none
 */

enum SaleType {
    case savePercent
    case saleAndGift
    case none
}

/*
 SortType
 
 fastArea => 샛별지역 상품인지 볼 때
 fastAreaAndquality => 샛별지역 + 상품 정렬
 fastAreaAndBenefit => 샛별지역 + 상품 정렬(혜택)
 */

enum SortType: String {
    case fastArea
    case fastAreaAndCondition
    case fastAreaAndBenefit
    case notSort

    var sortList: [String] {
        switch self {
        case .fastArea:
            return ["샛별지역상품", "택배지역상품"]
        case .fastAreaAndCondition:
            return ["신상품순", "인기상품순", "낮은 가격순", "높은 가격순"]
        case .fastAreaAndBenefit:
            return ["혜택순", "신상품순", "인기상품순", "낮은 가격순", "높은 가격순"]
        case .notSort:
            return []
        }
    }
}
