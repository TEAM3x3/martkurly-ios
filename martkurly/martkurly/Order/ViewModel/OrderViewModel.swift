//
//  OrderViewModel.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/07.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

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
