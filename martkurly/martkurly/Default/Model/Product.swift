//
//  Product.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let short_desc: String
    let price: Int
    let img: String
    let sales: Sales

    struct Sales: Decodable {
        let discount_rate: Int
        let contents: String?
    }
}

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

enum SortHeaderType: String {
    case fastAreaAndNot
    case fastAreaAndCondition
    case fastAreaAndBenefit
    case notSort

    var sortList: [String] {
        switch self {
        case .fastAreaAndNot:
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

enum SortType: String {
    case fastArea
    case condition
    case benefit

    var sortList: [String] {
        switch self {
        case .fastArea:
            return FastAreaType.allValues
        case .condition:
            return ConditionType.allValues
        case .benefit:
            return BenefitType.allValues
        }
    }
}

enum FastAreaType: String, CaseIterable {
    case 샛별지역상품
    case 택배지역상품

    static var allValues: [String] {
        var array = [String]()
        FastAreaType.allCases.forEach {
            array.append($0.rawValue)
        }
        return array
    }
}

enum ConditionType: String, CaseIterable {
    case 신상품순
    case 인기상품순
    case 낮은가격순 = "낮은 가격순"
    case 높은가격순 = "높은 가격순"

    static var allValues: [String] {
        var array = [String]()
        ConditionType.allCases.forEach {
            array.append($0.rawValue)
        }
        return array
    }
}

enum BenefitType: String, CaseIterable {
    case 혜택순
    case 신상품순
    case 인기상품순
    case 낮은가격순 = "낮은 가격순"
    case 높은가격순 = "높은 가격순"

    static var allValues: [String] {
        var array = [String]()
        BenefitType.allCases.forEach {
            array.append($0.rawValue)
        }
        return array
    }
}
