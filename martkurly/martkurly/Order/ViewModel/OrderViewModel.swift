//
//  OrderViewModel.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/07.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

// MARK: - OrderProductHeader
struct OrderViewModel {
    let orderItem: [CartItem]

    var productTitle: NSAttributedString {
        let productTitleText: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        return NSAttributedString(
            string: orderItem[0].goods.title,
            attributes: productTitleText
        )
    }

    var productCount: NSAttributedString {
        let productCountText: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        if orderItem.count == 1 {
            return NSAttributedString(
                string: "",
                attributes: productCountText)
        } else {
            return NSAttributedString(
                string: "외 \(orderItem.count - 1)건",
                attributes: productCountText)
        }
    }
}

// MARK: - OrderProductInView
struct OrderDataViewModel {
    let orderItem: CartItem

    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    var imageURL: URL? {
        return URL(string: orderItem.goods.img)
    }

    var productTitle: NSAttributedString {
        let productTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        return NSAttributedString(
            string: orderItem.goods.title,
            attributes: productTitle
        )
    }

    var productEach: NSAttributedString {
        let productEach: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        return NSAttributedString(
            string: "수량 \(orderItem.quantity)개",
            attributes: productEach)
    }

    var productAmountPrice: NSAttributedString {
        let productAmountPrice: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        return NSAttributedString(
            string: "합계 " + (formatter.string(for: orderItem.discount_payment as NSNumber) ?? "0") + "원",
            attributes: productAmountPrice
        )
    }
}
