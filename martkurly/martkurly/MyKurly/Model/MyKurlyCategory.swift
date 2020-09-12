//
//  MyKurlyCategory.swift
//  martkurly
//
//  Created by Kas Song on 8/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

struct MyKurlyCategory {

    static let instance = MyKurlyCategory()
    private init() {}

    let signedInData = [
        ["적립금", "쿠폰", "친구초대"],
        ["주문 내역", "상품후기", "상품 문의", "1:1 문의", "대량주문 문의"],
        ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개", "컬리패스"],
        ["개인정보 수정", "알림 설정"],
        ["로그아웃"]
    ]

    let signedInSubtitle = ["원", "장", "지금 5,000원 받기"]

    let signedOutData = [
        ["비회원 주문 조회"],
        ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개"],
        ["알림 설정"]
    ]
}
