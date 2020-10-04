//
//  CartHeaderView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartHeaderView: UIView {

    // MARK: - Properties
    private var statusArr = Set<String>()

    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.black
    ]

    private let coldAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.init(red: 104, green: 183, blue: 148)
    ]

    private let freezeAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 10),
        .foregroundColor: UIColor.init(red: 107, green: 170, blue: 245)
    ]

    private let roomTemperatureAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 10),
        .foregroundColor: UIColor.init(red: 220, green: 123, blue: 85)
    ]

    private let truckImg = UIImageView().then {
        $0.image = UIImage(named: "truck")
        $0.sizeToFit()
    }

    private var shipping = UILabel().then {
        let estimateMoneyAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSAttributedString(
            string: "0",
            attributes: estimateMoneyAttribute
        )

        $0.attributedText = attributeString
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setConstraints() {
        setConfigure()
    }

    private func setConfigure() {
        [truckImg, shipping].forEach {
            self.addSubview($0)
        }

        truckImg.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(24)
        }

        shipping.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(truckImg.snp.trailing).offset(8)
        }

        backgroundColor = ColorManager.General.backGray.rawValue
    }

    func configure(text: String) {
        statusArr.insert(text)

        if statusArr.count == 1 {

            for i in statusArr {
                if i == "냉장" {
                    var cold: NSAttributedString {

                        let coldString = NSMutableAttributedString(string: i, attributes: coldAttributes)
                        coldString.append(NSAttributedString(string: "  박스로 배송됩니다", attributes: attributes))

                        return coldString
                    }

                    self.shipping.attributedText = cold

                } else if i == "냉동" {
                    var freeze: NSAttributedString {

                        let freezeString = NSMutableAttributedString(string: i, attributes: freezeAttributes)
                        freezeString.append(NSAttributedString(string: "  박스로 배송됩니다", attributes: attributes))

                        return freezeString
                    }

                    self.shipping.attributedText = freeze

                } else if i == "상온" {
                    var roomTemperature: NSAttributedString {

                        let roomString = NSMutableAttributedString(string: i, attributes: roomTemperatureAttributes)
                        roomString.append(NSAttributedString(string: "  박스로 배송됩니다.", attributes: attributes))

                        return roomString
                    }

                    self.shipping.attributedText = roomTemperature
                }
            }
        } else if statusArr.count == 2 {

        } else if statusArr.count == 3 {

        }

    }
}
