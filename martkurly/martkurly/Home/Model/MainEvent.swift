//
//  MainEvent.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/16.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct MainEvent: Decodable {
    let id: Int             // 이벤트 ID
    let title: String       // 이벤트 명
    let image: String       // 이벤트 이미지
}

struct MainEventProducts: Decodable {
    let id: Int                     // 이벤트 ID
    let title: String               // 이벤트 명
    let event: [MainEventCategory]  // 이벤트 하위 카테고리들

    struct MainEventCategory: Decodable {
        let id: Int                 // 이벤트 하위 카테고리 ID
        let name: String            // 이벤트 하위 카테고리 이름
        let mainEvent: [MainEventProducts]    // 이벤트 하위 카테고리 상품들
    }

    struct MainEventProducts: Decodable {
        let goods: Product
    }
}
