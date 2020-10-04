//
//  UnDeliveryActionType.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

enum UnDeliveryActionType: Int, CaseIterable {
    case paymentRefund
    case productWarehousing

    var description: String {
        switch self {
        case .paymentRefund: return "결제수단으로 환불"
        case .productWarehousing: return "상품 입고 시 배송"
        }
    }
}
