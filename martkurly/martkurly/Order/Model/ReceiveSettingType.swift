//
//  ReceiveSettingType.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

enum ReceiveSettingType: Int, CaseIterable {
    case receiveSpace
    case attachedExplain
    case completeMessage
    case confirmButton

    func getHeaderTitleText(receiveSpaceType: ReceiveSpaceType? = nil) -> String {
        switch self {
        case .receiveSpace: return "받으실 장소*"
        case .attachedExplain:
            guard let receiveSpaceType = receiveSpaceType else { return "" }
            switch receiveSpaceType {
            case .doorFront: return "공동현관 출입 방법*"
            case .securityOffice: return "경비실 특이사항"
            case .parcelBox: return "택배함 정보*"
            case .anotherPlace: return "기타 장소 세부 사항*"
            }
        case .completeMessage: return "배송 완료 메시지 전송*"
        default: return ""
        }
    }
}

enum ReceiveSpaceType: Int, CaseIterable {
    case doorFront
    case securityOffice
    case parcelBox
    case anotherPlace

    var description: String {
        switch self {
        case .doorFront: return "문 앞"
        case .securityOffice: return "경비실"
        case .parcelBox: return "택배함"
        case .anotherPlace: return "기타 장소"
        }
    }

    var placeHolder: String? {
        switch self {
        case .doorFront: return nil
        case .securityOffice: return "경비실 위치 등 특이사항이 있을 경우 작성해주세요"
        case .parcelBox: return "택배함 위치 / 택배함 번호, 비밀번호"
        case .anotherPlace: return "예) 계단 밑, 주택단지 앞 경비초소를 지나 A동 출입구 (배송 시간은 별도로 지정할 수 없습니다)"
        }
    }
}

enum DoorFrontUsage: Int, CaseIterable {
    case commonDoor
    case enterFree
    case theOthers

    var description: String {
        switch self {
        case .commonDoor: return "공동현관 비밀번호"
        case .enterFree: return "자유 출입 가능"
        case .theOthers: return "기타"
        }
    }

    var placeHolder: String? {
        switch self {
        case .commonDoor: return "예: #1234* (특수문자 포함)"
        case .enterFree: return nil
        case .theOthers: return "예: 연락처로 전화, 경비실로 호출"
        }
    }
}
