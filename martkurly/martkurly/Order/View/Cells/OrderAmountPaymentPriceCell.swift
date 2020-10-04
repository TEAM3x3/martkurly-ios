//
//  OrderAmountPaymentPriceCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderAmountPaymentPriceCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "OrderAmountPaymentPriceCell"

    private let boldAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 18),
        .foregroundColor: UIColor.black
    ]

    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.black
    ]

    private let topLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let amountPaymentTitleLabel = UILabel().then {
        $0.text = "최종 결제 금액"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private lazy var amountPaymentPriceLabel = UILabel().then {
        let attributesString = NSMutableAttributedString(
            string: "159,000",
            attributes: boldAttributes)

        attributesString.append(NSAttributedString(
                                    string: " 원",
                                    attributes: attributes))
        $0.attributedText = attributesString
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [topLine, amountPaymentTitleLabel, amountPaymentPriceLabel].forEach {
            self.addSubview($0)
        }

        topLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
            $0.height.equalTo(1)
        }

        amountPaymentTitleLabel.snp.makeConstraints {
            $0.top.equalTo(topLine.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-orderVCSideInsetValue)
        }

        amountPaymentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(amountPaymentTitleLabel)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }
    }

    func configure(titleText: String, priceText: String) {
        amountPaymentTitleLabel.text = titleText

        let attributesString = NSMutableAttributedString(
            string: priceText,
            attributes: boldAttributes)

        attributesString.append(NSAttributedString(
                                    string: " 원",
                                    attributes: attributes))
        amountPaymentPriceLabel.attributedText = attributesString
    }
}
