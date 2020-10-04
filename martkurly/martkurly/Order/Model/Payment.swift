//
//  Payment.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

enum PaymentType: Int, CaseIterable {
    case creditCard
    case chai
    case toss
    case naverPay
    case payco
    case smilePay
    case phone

    var imageName: String {
        switch self {
        case .creditCard: return "Payment_creditcard"
        case .chai: return "Payment_chai"
        case .toss: return "Payment_toss"
        case .naverPay: return "Payment_naverpay"
        case .payco: return "Payment_payco"
        case .smilePay: return "Payment_smilepay"
        case .phone: return "Payment_phone"
        }
    }
}

enum PaymentCellType: Int, CaseIterable {
    case orderPricePayment
    case productPricePayMent
    case discountPricePayment
    case deliveryPricePayment
    case amountPricePayment

    var description: String {
        switch self {
        case .orderPricePayment: return "주문 금액"
        case .productPricePayMent: return "ㄴ  상품 금액"
        case .discountPricePayment: return "ㄴ  상품 할인"
        case .deliveryPricePayment: return "배송비"
        case .amountPricePayment: return "최종 결제 금액"
        }
    }
}
