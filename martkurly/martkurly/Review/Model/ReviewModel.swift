//
//  ReviewModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/05.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct ReviewModel: Decodable {
    let id: Int         // Review ID
    let title: String   // Review Title
    let content: String // Review Content
    let goods: Product  // Review Product
}
