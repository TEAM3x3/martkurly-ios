//
//  Recommend.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/15.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct Recommendation: Decodable {
    let title: String
    let bool: Bool  // true => 판매랭킹
    let serializers: [Product]
}

enum RecommendationType {
    case basicProductList
    case rankingProductList
    case productAndReviews
    case anotherRecommendation
}

struct RecommendationList {
    let title: String
    let cellType: RecommendationType
    let goods: [Product]
}

struct MDRecommendModel: Decodable {
    let id: Int
    let name: String
    let goods: [Product]
}

// Review Products Model

struct ReviewProductsModel: Decodable {
    let title: String
    let serializers: [ReviewProductModel]
}

struct ReviewProductModel: Decodable {
    let id: Int
    let title: String
    let img: String
    let price: Int
    let reviews: [Review]
}

struct Review: Decodable {
    let id: Int
    let title: String
    let content: String
    let user: User

    struct User: Decodable {
        let username: String
    }
}
