//
//  OrderSubPaymentPriceCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderSubPaymentPriceCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "OrderSubPaymentPriceCell"

    private let subPaymentTitleLabel = UILabel().then {
        $0.text = "ㄴ  상품 금액"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
    }

    private let subPaymentPriceLabel = UILabel().then {
        $0.text = "177,800 원"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
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

        [subPaymentTitleLabel, subPaymentPriceLabel].forEach {
            self.addSubview($0)
        }

        subPaymentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-12)
        }

        subPaymentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(subPaymentTitleLabel)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }
    }

    func configure(titleText: String, priceText: String, type: PaymentCellType) {
        subPaymentTitleLabel.text = titleText
        subPaymentPriceLabel.text = type == .discountPricePayment ?
            "-\(priceText) 원" : "\(priceText) 원"
    }
}
