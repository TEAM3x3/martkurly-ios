//
//  EventModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/13.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct EventModel: Decodable {
    let id: Int
    let title: String
    let image: String
}

struct EventProducts: Decodable {
    let id: Int
    let title: String
    let goods: [Product]
}
