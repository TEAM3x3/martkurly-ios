//
//  Recommend.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/15.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

enum RecommendationType {
    case basicProductList
    case rankingProductList
    case productAndReviews
    case anotherRecommendation
}

struct RecommendationList {
    let title: String
    let cellType: RecommendationType
}

struct MDRecommendModel: Decodable {
    let id: Int
    let name: String
    let goods: [Product]
}
