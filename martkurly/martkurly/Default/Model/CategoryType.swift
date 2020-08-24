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
 https://www.notion.so/Default-View-API-Document-53d6f4325b9e4400a483672fb5db18cb
 상위 Notion 참고
 */

enum CategoryType {
    case fixInsetStyle
    case fixNonInsetStyle
    case fixNonInsetsmallBarStyle
    case infinityStyle

    var sideInset: CGFloat {
        switch self {
        case .fixInsetStyle: return 12
        case .fixNonInsetsmallBarStyle: fallthrough
        case .fixNonInsetStyle: return 0
        case .infinityStyle: return 8
        }
    }

    var nonSelectFont: UIFont {
        switch self {
        case .fixNonInsetsmallBarStyle: fallthrough
        case .fixInsetStyle: return UIFont.systemFont(ofSize: 18)
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return UIFont.systemFont(ofSize: 16)
        }
    }

    var selectFont: UIFont {
        switch self {
        case .fixNonInsetsmallBarStyle: return UIFont.systemFont(ofSize: 18)
        case .fixInsetStyle: return UIFont.boldSystemFont(ofSize: 18)
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return UIFont.boldSystemFont(ofSize: 16)
        }
    }

    var topLineHeight: CGFloat {
        switch self {
        case .fixNonInsetsmallBarStyle: return 0.3
        case .fixInsetStyle: fallthrough
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return 0
        }
    }

    var bottomLineHeight: CGFloat {
        switch self {
        case .fixNonInsetsmallBarStyle: return 0
        case .fixInsetStyle: fallthrough
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return 0.3
        }
    }

    var underMoveLineHeight: CGFloat {
        switch self {
        case .fixNonInsetsmallBarStyle: return 3
        case .fixInsetStyle: fallthrough
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return 4
        }
    }

    var underMoveLineWidth: CGFloat {
        switch self {
        case .fixNonInsetsmallBarStyle: return 20
        case .fixInsetStyle: fallthrough
        case .fixNonInsetStyle: fallthrough
        case .infinityStyle: return 0
        }
    }
}
