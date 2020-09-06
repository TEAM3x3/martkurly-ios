//
//  CategoryType.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

/*
 Main Home Page에서 5개로 나눠져 있는 카테고리 목록 Enum
 "컬리추천", "신상품", "베스트", "알뜰쇼핑", "이벤트" 순
 */
enum MainCategoryType: Int, CaseIterable {
    case curlyRecommend
    case newProduct
    case baseProduct
    case cheapProduct
    case eventProduct
}

/*
 Product Detail Page에서 5개로 나눠져 있는 카테고리 목록 Enum
 "상품설명", "상품이미지", "상세정보", "후기", "상품문의"
 */

enum ProductCategoryType: Int, CaseIterable {
    case productExplain
    case productImage
    case productDetailInfo
    case productReviews
    case productInquiry

    var description: String {
        switch self {
        case .productExplain: return "상품설명"
        case .productImage: return "상품이미지"
        case .productDetailInfo: return "상세정보"
        case .productReviews: return "후기"
        case .productInquiry: return "상품문의"
        }
    }

    static func getAllCases(reviewsCount: Int) -> [String] {
        var array = [String]()
        ProductCategoryType.allCases.forEach {
            if $0 == .productReviews {
                array.append("\($0.description)\n(\(reviewsCount)+)")
                return
            }
            array.append($0.description)
        }
        return array
    }
}

/*
 https://www.notion.so/Default-View-API-Document-53d6f4325b9e4400a483672fb5db18cb
 상위 Notion 참고
 Category Menu Bar Style Type
 */

enum CategoryType {
    case fixInsetStyle
    case fixNonInsetStyle
    case fixNonInsetsmallBarStyle
    case infinityStyle
    case infinityTBLineStyle

    var sideInset: CGFloat {
        switch self {
        case .fixInsetStyle: return 12
        case .fixNonInsetsmallBarStyle: fallthrough
        case .fixNonInsetStyle: return 0
        case .infinityStyle: return 8
        case .infinityTBLineStyle: return 20
        }
    }

    var nonSelectFont: UIFont {
        switch self {
        case .fixNonInsetsmallBarStyle: fallthrough
        case .fixInsetStyle: return UIFont.systemFont(ofSize: 18)
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return UIFont.systemFont(ofSize: 16)
        case .infinityTBLineStyle: return UIFont.systemFont(ofSize: 14)
        }
    }

    var selectFont: UIFont {
        switch self {
        case .fixNonInsetsmallBarStyle: return UIFont.systemFont(ofSize: 18)
        case .fixInsetStyle: return UIFont.boldSystemFont(ofSize: 18)
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return UIFont.boldSystemFont(ofSize: 16)
        case .infinityTBLineStyle: return UIFont.boldSystemFont(ofSize: 14)
        }
    }

    var topLineHeight: CGFloat {
        switch self {
        case .infinityTBLineStyle: fallthrough
        case .fixNonInsetsmallBarStyle: return 0.3
        default: return 0
        }
    }

    var topLineInsetValue: CGFloat {
        switch self {
        case .infinityTBLineStyle: return 20
        default: return 0
        }
    }

    var bottomLineHeight: CGFloat {
        switch self {
        case .fixNonInsetsmallBarStyle: return 0
        default: return 0.3
        }
    }

    var bottomLineInsetValue: CGFloat {
        switch self {
        case .infinityTBLineStyle: return 20
        default: return 0
        }
    }

    var underMoveLineHeight: CGFloat {
        switch self {
        case .infinityTBLineStyle: return 2
        case .fixNonInsetsmallBarStyle: return 3
        default: return 4
        }
    }

    var underMoveLineWidth: CGFloat {
        switch self {
        case .fixNonInsetsmallBarStyle: return 20
        default: return 0
        }
    }
}
