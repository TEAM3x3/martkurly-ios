//
//  ProductDetailListViewModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/30.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

struct ProductListViewModel {
    let product: Product

    // MARK: - Formatter
    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    var imageURL: URL? {
        return URL(string: product.img)
    }

    var isShowSaleView: Bool {
        return product.sales?.contents == nil &&
            product.sales?.discount_rate == nil
    }

    var saleDisplayText: NSAttributedString? {
        guard isShowSaleView == false else { return nil }

        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]

        let giftAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.white
        ]

        if product.sales?.discount_rate != nil,
            let rate = product.sales?.discount_rate {

            let stringValue = NSMutableAttributedString(string: "SAVE\n", attributes: attributes)
            stringValue.append(NSAttributedString(string: "\(rate)", attributes: boldAttributes))
            stringValue.append(NSAttributedString(string: "%", attributes: attributes))
            return stringValue
        } else if let contents = product.sales?.contents {
            if contents == "1+1" {
                let stringValue = NSMutableAttributedString(string: "EVENT\n", attributes: attributes)
                stringValue.append(NSAttributedString(string: "\(contents)", attributes: boldAttributes))
                return stringValue
            } else if contents == "+gift" {
                let stringValue = NSAttributedString(string: "GIFT", attributes: giftAttributes)
                return stringValue
            }
        }
        return nil
    }

    var primeCostDisplayText: NSAttributedString {
        let costPriceAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        return NSMutableAttributedString(
            string: (formatter.string(for: product.price as NSNumber) ?? "0") + "원",
            attributes: costPriceAttributes)
    }

    var saleCostDisplayText: NSAttributedString? {
        let salePriceAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.lightGray,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.lightGray
        ]

        guard let saleCost = product.discount_price else { return nil }
        return NSMutableAttributedString(
            string: (formatter.string(for: saleCost as NSNumber) ?? "0") + "원",
            attributes: salePriceAttributes)
    }
}
