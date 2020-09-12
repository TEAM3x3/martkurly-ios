//
//  MainCurlyInfo.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/07.
//  Copyright © 2020 Team3x3. All rights reserved.
//

enum InfoCellType: Int, CaseIterable {
    case curlyPolicy
    case curlyCEO
    case personalPrivacy
    case registrationNumber
    case mailOrderNumber
    case curlyAddress
    case noneOne
    case storeEnquiry
    case partnershipEnquiry
    case faxAndEmail
    case happinessCenterCall
    case noneTwo
    case kakaotalkGuide
    case curlySNS

    var description: [String] {
        switch self {
        case .curlyPolicy: return ["컬리소개", "이용약관", "개인정보처리방침"]
        case .curlyCEO: return ["주식회사 컬리 | 대표자 : 김슬아"]
        case .personalPrivacy: return ["개인정보보호책임자 : 이원준"]
        case .registrationNumber: return ["사업자등록번호 : 261-81-23567 ", "사업자 정보확인"]
        case .mailOrderNumber: return ["통신판매업 : 제 2018-서울강남-01646 호"]
        case .curlyAddress: return ["주소 : 서울특별시 강남구 도산대로 16길 20, 이래빌딩 B1 ~ 4F"]
        case .noneOne: return []
        case .storeEnquiry: return ["입점문의 : ", "입점문의하기"]
        case .partnershipEnquiry: return ["제휴문의 : ", "business@kurlycorp.com"]
        case .faxAndEmail: return ["팩스 : 070-7500-6098 | 이메일 : ", "help@kurlycorp.com"]
        case .happinessCenterCall: return ["고객행복센터 : ", "1644-1107"]
        case .noneTwo: return []
        case .kakaotalkGuide: return ["카카오톡 ", "@마켓컬리", " 친구 추가하고 소식과 혜택을 받아보세요."]
        case .curlySNS: return ["instagram", "facebook", "naverblog", "navercafe", "youtube"]
        }
    }

    enum CellStyle {
        case none
        case basic
        case lastHighlight
        case centerHighlight
        case custom
    }

    var cellStyle: CellStyle {
        switch self {
        case .curlyCEO, .personalPrivacy, .mailOrderNumber, .curlyAddress:
            return .basic
        case .registrationNumber, .storeEnquiry, .partnershipEnquiry, .faxAndEmail, .happinessCenterCall:
            return .lastHighlight
        case .kakaotalkGuide:
            return .centerHighlight
        case .curlyPolicy, .curlySNS:
            return .custom
        case .noneOne, .noneTwo:
            return .none
        }
    }
}
