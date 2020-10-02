//
//  Constants.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

// KurlyService

let KURLY_REF = "http://13.209.33.72/api"

let KURLY_GOODS_REF = KURLY_REF + "/goods"  // 상품 리스트
let REF_GOODS = KURLY_GOODS_REF + "/"       // 상품 디테일 페이지
let REF_CHEAP_PRODUCTS = KURLY_GOODS_REF + "/sale"  // [홈] - [알뜰쇼핑]
let REF_BEST_PRODUCTS = KURLY_GOODS_REF + "/best"   // [홈] - [베스트]
let REF_SEARCH_WORD_PRODUCTS = KURLY_GOODS_REF + "/goods_search"        // 최근 검색어에 포함
let REF_SEARCH_TYPING_PRODUCTS = KURLY_GOODS_REF + "/word_search"       // 타이핑 단어에 포함
let REF_RECOMMEND_PRODUCTS = KURLY_GOODS_REF + "/main_page_recommend"   // [홈] - [컬리추천] - [이 상품 어때요?]

let KURLY_EVENT_REF = KURLY_REF + "/event"      // [홈] - [이벤트]
let REF_EVENT_GOODS = KURLY_EVENT_REF + "/"     // [홈] - [이벤트] 상세

let KURLY_MAIN_EVENT_REF = KURLY_REF + "/mainEvent" // [홈] - [컬리추천] - [최 상단 이벤트]
let REF_MAIN_EVENT = KURLY_MAIN_EVENT_REF + "/"     // [홈] - [컬리추천] - [최 상단 이벤트] 상세

let REF_SIGNUP = KURLY_REF + "/users"
let REF_SIGNIN = KURLY_REF + "/users/login"

let REF_CATEGORY = KURLY_REF + "/category"

let REF_CART = KURLY_REF + "/cart/1"
let REF_CART_PUSH = KURLY_REF + "/cart/1/item"
let REF_CART_DELETE = KURLY_REF + "/cart/1/item/goods_delete"

// Notification

let PRODUCT_DETAILVIEW_EVENT = "PRODUCT_DETAILVIEW_EVENT"
