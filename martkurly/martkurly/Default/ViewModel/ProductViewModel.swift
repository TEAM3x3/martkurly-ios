//
//  ProductViewModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct ProductViewModel {
    let product: Product

    // MARK: - Formatter
    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)
        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 3    // 최대 소수점 단위
    }

    var imageURL: URL? {
        return URL(string: product.img)
    }

    var salePrice: String {
        return (formatter.string(for: product.price as NSNumber) ?? "0") + "원"
    }
}
