//
//  Search.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

enum SearchType {
    case popular
    case recent
    case fileShort

    var description: String {
        switch self {
        case .popular: return "인기 검색어"
        case .recent: return "최근 검색어"
        case .fileShort: return "상품 바로가기"
        }
    }

    var emptySentence: String {
        switch self {
        case .popular: fallthrough
        case .fileShort: return ""
        case .recent: return "최근 검색어가 없습니다."
        }
    }
}
