//
//  ShippingView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/30.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ShoippingView: UIView {

    // MARK: - Properties
    var shippingMoney = 0 {
        didSet {
            setUI()
        }
    }

    private let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    private lazy var freeShipMoney = UILabel().then {
        let shippingMoneyAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: ColorManager.General.mainPurple.rawValue
        ]

        let attributeString = NSAttributedString(
            string: (formatter.string(for: shippingMoney as NSNumber) ?? "0") + " 원",
            attributes: shippingMoneyAttribute
        )

        $0.attributedText = attributeString
    }

    private let shipMoney = UILabel().then {
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.text = "원 추가주문 시,"
        $0.font = .systemFont(ofSize: 12)
    }

    private let freeShip = UILabel().then {
        $0.text = "무료배송"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = .boldSystemFont(ofSize: 12)
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setUI() {
        [freeShipMoney, shipMoney, freeShip].forEach {
            addSubview($0)
        }
    }
}
