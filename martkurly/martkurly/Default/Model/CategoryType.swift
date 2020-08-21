//
//  CategoryType.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

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
