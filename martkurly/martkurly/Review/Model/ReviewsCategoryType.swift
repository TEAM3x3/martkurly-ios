//
//  ReviewsCategoryType.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

enum ReviewsCategoryType: Int, CaseIterable {
    case possibleReviews
    case completeReviews

    var description: String {
        switch self {
        case .possibleReviews: return "작성가능 후기 (0)"
        case .completeReviews: return "작성완료 후기 (0)"
        }
    }

    static var categoryTitles: [String] {
        return ["작성가능 후기 (0)", "작성완료 후기 (0)"]
    }
}

struct ReviewsStringManager {
    static let General = ReviewsStringManager()

    private let boldAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 12),
        .foregroundColor: UIColor.darkGray
    ]

    private let basicAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.darkGray
    ]

    var pointTitleText: NSAttributedString {
        return NSAttributedString(
            string: "후기 작성 시 사진후기 100원, 글후기 50원을 적립해드립니다.",
            attributes: boldAttributes)
    }

    var purpleSaveInfoText: NSAttributedString {
        let infoText = NSMutableAttributedString(
            string: "- 퍼플, 더퍼플은 ",
            attributes: basicAttributes)
        infoText.append(NSAttributedString(
                            string: "2배 ",
                            attributes: boldAttributes))
        infoText.append(NSAttributedString(
                            string: "적립 (사진 200원, 글 100원)",
                            attributes: basicAttributes))
        return infoText
    }

    var additionSaveInfoText: NSAttributedString {
        let infoText = NSMutableAttributedString(
            string: "- 주간 베스트 후기로 선정 시 ",
            attributes: basicAttributes)
        infoText.append(NSAttributedString(
                            string: "5,000원",
                            attributes: boldAttributes))
        infoText.append(NSAttributedString(
                            string: "을 추가 적립",
                            attributes: basicAttributes))
        return infoText
    }

    var reviewInfoText: NSAttributedString {
        return NSAttributedString(
            string: "* 후기 작성은 배송 완료일로부터 30일 이내 가능합니다.",
            attributes: basicAttributes)
    }
}
