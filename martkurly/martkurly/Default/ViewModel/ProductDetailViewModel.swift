//
//  ProductDetailViewModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/10.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

struct ProductDetailViewModel {
    let productDetail: ProductDetail

    // MARK: - Formatter
    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)
        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 3    // 최대 소수점 단위
    }

    // MARK: - Properties
    var productMainImageURL: URL? {
        return URL(string: productDetail.img)
    }

    var priceAttributeText: NSAttributedString {
        let priceText = productDetail.discount_price != nil ?
            productDetail.discount_price! : productDetail.price
        let displayPriceText = formatter.string(from: priceText as NSNumber) ?? "0"

        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSMutableAttributedString(
            string: displayPriceText, attributes: boldAttributes)
        attributeString.append(NSAttributedString(
            string: "원", attributes: attributes))

        guard let ratePercent = productDetail.sales?.discount_rate else { return attributeString }

        let rateAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: ColorManager.General.rateText.rawValue
        ]

        let discountAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.lightGray,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.lightGray
        ]

        let newAttributeString = NSMutableAttributedString(
            string: "회원할인가\n", attributes: attributes)

        attributeString.append(NSAttributedString(
            string: " \(ratePercent)%\n", attributes: rateAttributes))

        attributeString.append(NSAttributedString(
            string: (formatter.string(from: productDetail.price as NSNumber) ?? "0") + "원",
            attributes: discountAttributes))

        newAttributeString.append(attributeString)
        return newAttributeString
    }
}
