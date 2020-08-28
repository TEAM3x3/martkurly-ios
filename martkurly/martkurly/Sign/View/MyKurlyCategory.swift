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

    let data = [
        ["비회원 주문 조회"],
        ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개"],
        ["알림 설정"]
    ]
}
