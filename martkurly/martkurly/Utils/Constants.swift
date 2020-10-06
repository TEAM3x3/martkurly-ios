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
let LOCAL_REF = "http://5a996f9f659a.jp.ngrok.io/api"

let KURLY_GOODS_REF = KURLY_REF + "/goods"  // 상품 리스트
let REF_GOODS = KURLY_GOODS_REF + "/"       // 상품 디테일 페이지
let REF_NEW_PRODUCTS = KURLY_GOODS_REF + "/new_product"
let REF_BEST_PRODUCTS = KURLY_GOODS_REF + "/best"   // [홈] - [베스트]
let REF_CHEAP_PRODUCTS = KURLY_GOODS_REF + "/sale"  // [홈] - [알뜰쇼핑]
let REF_SEARCH_WORD_PRODUCTS = KURLY_GOODS_REF + "/goods_search"        // 최근 검색어에 포함
let REF_SEARCH_TYPING_PRODUCTS = KURLY_GOODS_REF + "/word_search"       // 타이핑 단어에 포함
let REF_RECOMMEND_PRODUCTS = KURLY_GOODS_REF + "/main_page_recommend"   // [홈] - [컬리추천] - [이 상품 어때요?]
let REF_SALES_PRODUCTS = KURLY_GOODS_REF + "/sales_goods"               // [홈] - [컬리추천] - [알뜰 상품]
let REF_HEALTH_PRODUCTS = KURLY_GOODS_REF + "/main_page_health"         // [홈] - [컬리추천] - [건강식품]

let KURLY_EVENT_REF = KURLY_REF + "/event"      // [홈] - [이벤트]
let REF_EVENT_GOODS = KURLY_EVENT_REF + "/"     // [홈] - [이벤트] 상세
let REF_SQAURE_EVENTS = KURLY_EVENT_REF + "/square_event_list"  // [홈] - [Sqaure 이벤트]

let KURLY_MAIN_EVENT_REF = KURLY_REF + "/mainEvent" // [홈] - [컬리추천] - [최 상단 이벤트]
let REF_MAIN_EVENT = KURLY_MAIN_EVENT_REF + "/"     // [홈] - [컬리추천] - [최 상단 이벤트] 상세

let REF_USER = KURLY_REF + "/users"
let REF_SIGNIN = KURLY_REF + "/users/login"

let REF_CATEGORY = KURLY_REF + "/category"
let REF_MDRECOMMAND_PRODUCTS = REF_CATEGORY + "/md_recommend"

let REF_CART = KURLY_REF + "/cart/1"                               // 장바구니(Token Needs)
let REF_CART_LOCAL = LOCAL_REF + "/cart/1"                         // 장바구니
let REF_CART_PUSH = KURLY_REF + "/cart/1/item"                     // 장바구니 상품 추가(Token Needs)
let REF_CART_PUSH_LOCAL = LOCAL_REF + "/cart/1/item"               // post: 장바구니 상품 추가 , patch: 제품 갯수 수정
let REF_CART_DELETE = KURLY_REF + "/cart/1/item/goods_delete"      // 장바구니 상품 삭제()
let REF_CART_DELETE_LOCAL = LOCAL_REF + "/cart/1/item"             // 장바구니 상품 삭제

let REF_USER_REVIEW_LIST = KURLY_REF + "/review"   // 유저가 작성한 리뷰 리스트 반환(Token Needs)
let REF_PRODUCT_REVIEW_LIST = "/reviews"        // 해당 상품에 대한 리뷰 리스트 반환
let REF_USER_POSSIBLE_REVIEW_LIST = KURLY_REF + "/users/writable" // 유저가 작성 가능한 리뷰 반환(Token Needs)

let REF_ADDRESS = KURLY_REF + "/users"

// [추천] 탭
let REF_RC_ANIMALS_GOODS = KURLY_GOODS_REF + "/pet_goods_best"
let REF_RC_HOME_GOODS = KURLY_GOODS_REF + "/home_appliances"
let REF_RC_ICECREAM_GOODS = KURLY_GOODS_REF + "/ice_cream"
let REF_RC_CLEANING_GOODS = KURLY_GOODS_REF + "/cleaning"
let REF_RC_RICECAKE_GOODS = KURLY_GOODS_REF + "/rice_cake"
let REF_RC_SALTEDFISH_GOODS = KURLY_GOODS_REF + "/salted_fish"
let REF_RC_CHICKEN_GOODS = KURLY_GOODS_REF + "/chicken_goods"
let REF_RC_REVIEW_GOODS = KURLY_GOODS_REF + "/recommend_review"

// Notification

let PRODUCT_DETAILVIEW_EVENT = "PRODUCT_DETAILVIEW_EVENT"
let SQAURE_EVENT = "SQAURE_EVENT"
