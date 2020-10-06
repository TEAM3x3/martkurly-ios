//
//  Order.swift
//  martkurly
//
//  Created by Kas Song on 10/5/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct Order: Decodable {
    let discount_payment: Int
    let discount_price: Int
//    let id: Int
//    let items: [Items]
//    let orderdetail: OrderDetail
//    let total_payment: Int
//    let user: User

    struct Items: Decodable {
        let cart: String?
        let discount_payment: Int
        let goods: Goods
        let id: Int
        let quantity: Int
        let sub_total: Int

        struct Goods: Decodable {
            let discount_price: Int?
            let id: Int
            let img: String
            let packing_status: String?
            let price: Int
            let sales: Sales?
            let sales_count: Int?
            let short_desc: String?
            let stock: Stock
            let title: String
            let transfer: String?

            struct Sales: Decodable {
                let contents: String?
                let discount_rate: Int?
            }

            struct Stock: Decodable {
                let count: Int
                let id: Int
                let updated_at: String
            }
        }
    }

    struct OrderDetail: Decodable {
        let address: String
        let consumer: String?
        let created_at: String?
        let delivery_cost: Int?
        let delivery_type: String
        let entrance_password: String
        let etc: String?
        let receiver_phone: String
        let receiving_place: String?
        let title: String?
        let zip_code: String?
    }

    struct User: Decodable {
        let username: String
    }
}
