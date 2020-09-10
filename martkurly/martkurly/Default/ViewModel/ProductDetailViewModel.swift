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
        let priceText = formatter.string(from: productDetail.price as NSNumber) ?? "0"

        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSMutableAttributedString(
            string: priceText, attributes: boldAttributes)
        attributeString.append(NSAttributedString(
            string: "원", attributes: attributes))

        return attributeString
    }
}
