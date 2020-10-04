//
//  ExplainInfoViewModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/10.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct ExplainInfoViewModel {
    var productDetailData: ProductDetail?

    var infomations: [ExplainTableInfoCase] {
        guard let productDetailData = productDetailData else { return [] }

        var infomations = [ExplainTableInfoCase]()
        infomations.append(.each)
        infomations.append(.weight)
        if productDetailData.transfer != nil { infomations.append(.transfer) }
        if productDetailData.origin != nil { infomations.append(.origin) }
        infomations.append(.packing)
        if productDetailData.allergy != nil { infomations.append(.allergy) }
        if productDetailData.expiration != nil { infomations.append(.expiration) }
        return infomations
    }

    func requestInfoContent(type: ExplainTableInfoCase) -> String? {
        guard let productDetailData = productDetailData else { return nil }
        switch type {
        case .each: return productDetailData.each
        case .weight: return productDetailData.weight
        case .transfer: return productDetailData.transfer
        case .origin: return productDetailData.origin
        case .packing:
            guard let packing = productDetailData.packing else { return nil }
            let packingArray = packing.components(separatedBy: "\n")
            return packingArray[0]
        case .allergy: return productDetailData.allergy
        case .expiration: return productDetailData.expiration
        }
    }

    func requestInfoSubContent(type: ExplainTableInfoCase) -> String? {
        guard let productDetailData = productDetailData else { return nil }
        switch type {
        case .packing:
            guard let packing = productDetailData.packing else { return nil }
            let packingArray = packing.components(separatedBy: "\n")
            return packingArray[1]
        default:
            return nil
        }
    }
}
