//
//  Cart.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct Cart: Decodable {
    let id: Int
    let quantity_of_goods: Int
    var items: [CartItem]
    let total_pay: Int
    let discount_total_pay: Int
    var discount_price: Int
}

struct CartItem: Decodable {
    let id: Int
    let cart: Int?
    let goods: Product
    var quantity: Int
    var sub_total: Int
    var discount_payment: Int
}

/*
 {
     "id": 1,
     "quantity_of_goods": 1,
     "items": [
         {
             "id": 1,
             "cart": 1,
             "goods": {
                 "id": 1,
                 "title": "[KF365] 햇 감자 1kg",
                 "short_desc": "믿고 먹을 수 있는 상품을 합리적인 가격에, KF365",
                 "packing_status": "상온",
                 "price": 2380,
                 "img": "https://pbs-13-s3.s3.amazonaws.com/goods/%5BKF365%5D%20%ED%96%87%20%EA%B0%90%EC%9E%90%201kg/KF365_%ED%96%87_%EA%B0%90%EC%9E%90_1kg_goods_image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXOLZAM2NBPACFGX7%2F20200925%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20200925T072151Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=483aba06a3d7097e8ffcb730892785fdd95c4f10a5d269bbd5f0a29c2b2745f8",
                 "sales": null,
                 "tagging": [],
                 "discount_price": null
             },
             "quantity": 5,
             "sub_total": 11900,
             "discount_payment": 11900
         }
     ],
     "total_pay": 11900,
     "discount_total_pay": 11900,
     "discount_price": 0
 }
 */
