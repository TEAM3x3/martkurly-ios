//
//  DeliverySpaceModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct DeliverySpaceModel {
    var address: String             // 주소
    var detail_address: String      // 상세주소
    var status: String              // 기본 배송지 상태
    var receiving_place: String     // 받으실 장소
    var entrance_password: String?  // 공동현관 비밀번호
    var free_pass: Bool             // 공동현관 자유출입 가능 여부
    var etc: String?                // 기타
    var message: Bool?              // 배송완료 메시지 전송 여부
    var extra_message: String?      // 경비실 특이사항, 택배함 정보 데이터, 기타 장소 세부사항에 대한 값을 저장
}
