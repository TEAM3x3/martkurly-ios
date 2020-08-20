//
//  ImageManager.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

// 모든 뷰에서 공통적으로 생성되는 값일 경우 General, 특정 뷰에서만 사용될 경우 뷰 이름으로 enum 을 생성해서 사용
// 사용법: ImageManager.General.martCulryWhiteLogo.rawValue
// 새로운 값을 추가할 때는 case 를 생성하고 rawValue switch self 내에 동일한 case 를 생성하고 원하는 return 값 입력

struct ImageManager {

    enum General: RawRepresentable {
        typealias RawValue = UIImage

        case martCulryWhiteLogo
        case goForward

        init?(rawValue: UIImage) {
            switch rawValue {
            default:
                return nil
            }
        }

        var rawValue: UIImage {
            switch self {
            case .martCulryWhiteLogo:
                return UIImage(named: "Martcurly_MainTitle_White")!
            case .goForward:
                return UIImage(systemName: "chevron.right")!.withTintColor(.chevronForwardGray, renderingMode: .alwaysOriginal)
            }
        }
    }

    enum WhyKurly: RawRepresentable {
        typealias RawValue = UIImage

        case content1
        case content2
        case content3
        case content4
        case content5

        init?(rawValue: UIImage) {
            switch rawValue {
            default:
                return nil
            }
        }

        var rawValue: UIImage {
            switch self {
            case .content1:
                return UIImage(named: "01_check")!
            case .content2:
                return UIImage(named: "02_only")!
            case .content3:
                return UIImage(named: "03_cold")!
            case .content4:
                return UIImage(named: "04_price")!
            case .content5:
                return UIImage(named: "05_eco")!
            }
        }
    }

    enum Agreement: RawRepresentable {
        typealias RawValue = UIImage

        case unchecked
        case checked

        init?(rawValue: UIImage) {
            switch rawValue {
            default:
                return nil
            }
        }

        var rawValue: UIImage {
            switch self {
            case .unchecked:
                return UIImage(systemName: "checkmark.circle")!.withTintColor(ColorManager.General.uncheckedmark.rawValue, renderingMode: .alwaysOriginal)
            case .checked:
                return UIImage(systemName: "checkmark.circle.fill")!.withTintColor(ColorManager.General.mainPurple.rawValue, renderingMode: .alwaysOriginal)
            }
        }
    }
}
