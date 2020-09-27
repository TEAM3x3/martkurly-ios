//
//  OrderMainPaymentPriceCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderMainPaymentPriceCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "OrderMainPaymentPriceCell"

    private let mainPaymentTitleLabel = UILabel().then {
        $0.text = "주문 금액"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let mainPaymentPriceLabel = UILabel().then {
        $0.text = "159,000 원"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
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

        [mainPaymentTitleLabel, mainPaymentPriceLabel].forEach {
            self.addSubview($0)
        }

        mainPaymentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-12)
        }

        mainPaymentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(mainPaymentTitleLabel)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }
    }

    func configure(titleText: String, priceText: String) {
        mainPaymentTitleLabel.text = titleText
        mainPaymentPriceLabel.text = priceText + " 원"
    }
}
