//
//  RegisterDeliveryType.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

enum RegisterDeliveryType: Int, CaseIterable {
    case sameOrderer
    case receiverName
    case receiverPhone
    case basicAddress
    case detailAddress
    case receivePlace
    case defaultPlaceSet
    case saveButton

    var titleText: String {
        switch self {
        case .sameOrderer: return "주문자 정보와 동일"
        case .receiverName: return "받는 분 이름*"
        case .receiverPhone: return "받는 분 휴대폰*"
        case .basicAddress: return "주소*"
        case .detailAddress: return "상세 주소"
        case .receivePlace: return "받으실 장소*"
        case .defaultPlaceSet: return "기본 배송지로 저장"
        default: return ""
        }
    }

    var placeHolderText: String {
        switch self {
        case .receiverName: return "이름을 입력해 주세요"
        case .receiverPhone: return "번호를 입력해주세요"
        case .basicAddress: return "주소검색"
        case .detailAddress: return "나머지 주소를 입력해 주세요"
        case .receivePlace: return "장소를 입력해주세요"
        default: return ""
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .receiverPhone: return .numberPad
        default: return .default
        }
    }

    var isShowCounting: Bool {
        switch self {
        case .detailAddress: return true
        default: return false
        }
    }

    var imageName: String {
        switch self {
        case .basicAddress: return "magnifyingglass"
        case .receivePlace: return "chevron.compact.right"
        default: return ""
        }
    }
}
