//
//  Product.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

// 기본 Product 구조체
struct Product: Decodable {
    let id: Int                 // 상품 코드
    let title: String           // 상품 명
    let short_desc: String      // 상품 설명
    let img: String             // 상품 이미지
    let price: Int              // 상품 원가
    let discount_price: Int?    // 상품 할인가
    let packing_status: String? // 상품 포장 상태
    let sales: Sales?           // 상품 할인(%)
    let tagging: [Tagging]      // 상품 Tag

    struct Tagging: Decodable {
        let name: String        // 태그명

        enum CodingKeys: String, CodingKey {
            case tag
        }

        enum TagKeys: String, CodingKey {
            case name
        }

        init(from decoder: Decoder) throws {
            let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
            let tagContainer = try keyedContainer.nestedContainer(
                keyedBy: TagKeys.self,
                forKey: .tag)
            name = try tagContainer.decode(String.self, forKey: .name)
        }
    }
}

struct Sales: Decodable {
    let discount_rate: Int? // 할인(%)
    let contents: String?   // 다른방식
}

// 상세정보 Product 구조체
struct ProductDetail: Decodable {
    let id: Int                 // 상품 번호
    let img: String             // 상품 이미지
    let info_img: String        // 상품 정보 이미지
    let title: String           // 상품 이름
    let short_desc: String      // 상품 설명
    let price: Int              // 상품 가격
    let discount_price: Int?    // 상품 할인가격
    let sales: Sales?           // 상품 할인 정보
    let each: String?           // 수량
    let weight: String          // 무게
    let transfer: String?       // 배송 정보(샛별 / 택배)
    let packing: String?        // 포장 방법
    let origin: String?         // 원산지
    let allergy: String?        // 알레르기 정보
    let info: String?           // 상품 안내
    let expiration: String?     // 상품 유통기한
    let explains: [ProductExplain]
    let details: [ProductDetailInfomation]

    struct ProductExplain: Decodable {
        let img: String
        let text_title: String
        let text_context: String
        let text_description: String
    }

    struct ProductDetailInfomation: Decodable {
        let detail_title: String
        let detail_desc: String

        enum CodingKeys: String, CodingKey {
            case detail_title
            case detail_desc
        }

        enum DetailKeys: String, CodingKey {
            case title
        }

        init(from decoder: Decoder) throws {
            let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
            detail_desc = try keyedContainer.decode(String.self, forKey: .detail_desc)

            let detailKeys = try keyedContainer.nestedContainer(
                keyedBy: DetailKeys.self,
                forKey: .detail_title)
            detail_title = try detailKeys.decode(String.self, forKey: .title)
        }
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
