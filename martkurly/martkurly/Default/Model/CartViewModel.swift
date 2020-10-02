//
//  CartViewModel.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

struct CartViewModel {
    let cartItems: Cart.Items

    // MARK: - 천단위
    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

// MARK: - Image
    var imageURL: URL? {
        return URL(string: cartItems.goods.img)
    }

    var isShowDiscountPrice: Bool {
        return cartItems.goods.discount_price == nil
    }

    var discountText: NSAttributedString? {
        guard isShowDiscountPrice == false else {
            return nil }

        let discountAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10),
                    .foregroundColor: UIColor.lightGray,
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.lightGray
                ]

        if cartItems.goods.discount_price != nil,
           let discount = cartItems.goods.discount_price {
            let discountText = NSMutableAttributedString(
                string: (formatter.string(for: discount as NSNumber) ?? "0") + "원",
                attributes: discountAttributes)

            return discountText
        }
        return nil
    }

    var priceText: NSAttributedString {
        let priceAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        return NSMutableAttributedString(
            string: (formatter.string(for: cartItems.goods.price as NSNumber) ?? "0") + "원",
            attributes: priceAttributes)
    }

    var subTotalPrice: NSAttributedString {
        let subTotalPriceAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        return NSMutableAttributedString(
            string: (formatter.string(for: cartItems.sub_total as NSNumber) ?? "0") + "원",
            attributes: subTotalPriceAttributes
        )
    }

    var title: NSAttributedString {
        let title: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        return NSAttributedString(
            string: cartItems.goods.title,
            attributes: title
        )
    }

    var status: NSAttributedString {
        let statusText: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.black
        ]

        return NSAttributedString(
            string: cartItems.goods.packing_status,
            attributes: statusText
        )
    }

}
