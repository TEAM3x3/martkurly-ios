//
//  ExplainTableViewCase.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/10.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

enum ExplainTableViewCase: Int, CaseIterable {
    case productBasic
    case productInfo
    case productDelivery
    case productDetail
    case productImage
    case productWhyKurly
}

enum ExplainTableInfoCase: Int, CaseIterable {
    case each
    case weight
    case transfer
    case origin
    case packing
    case allergy
    case expiration

    var description: String {
        switch self {
        case .each: return "판매단위"
        case .weight: return "중량/용량"
        case .transfer: return "배송구분"
        case .origin: return "원산지"
        case .packing: return "포장타입"
        case .allergy: return "알레르기정보"
        case .expiration: return "유통기한"
        }
    }
}
