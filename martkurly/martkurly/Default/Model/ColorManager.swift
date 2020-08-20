//
//  ColorManager.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

// 모든 뷰에서 공통적으로 생성되는 값일 경우 General, 특정 뷰에서만 사용될 경우 뷰 이름으로 enum 을 생성해서 사용
// 사용법: ColorManager.General.howToUse.rawValue
// 새로운 값을 추가할 때는 case 를 생성하고 rawValue switch self 내에 동일한 case 를 생성하고 원하는 return 값 입력

struct ColorManager {

    enum General: RawRepresentable {
        typealias RawValue = UIColor

        case mainPurple
        case mainGray
        case text
        case whyKurlyText
        case separator
        case backGray
        case chevronGray

        init?(rawValue: UIColor) {
            switch rawValue {
            default:
                return nil
            }
        }

        var rawValue: UIColor {
            switch self {
            case .mainPurple:
                return .martkurlyMainPurpleColor
            case .mainGray:
                return .textMainGray
            case .text:
                return .textBlack
            case .separator:
                return .separatorGray
            case .whyKurlyText:
                return .textDarkGray
            case .backGray:
                return .backgroundGray
            case .chevronGray:
                return .chevronGray
            }
        }
    }

    enum MainVC: RawRepresentable {
        typealias RawValue = UIColor

        case mainPurple

        init?(rawValue: UIColor) {
            switch rawValue {
            default:
                return nil
            }
        }

        var rawValue: UIColor {
            switch self {
            case .mainPurple:
                return .martkurlyMainPurpleColor
            }
        }
    }

}
