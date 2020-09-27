//
//  OrderPaymentPriceHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderPaymentPriceHeaderView: UIView {

    // MARK: - Properties

    private let deliveryLabel = UILabel().then {
        $0.text = "결제 금액"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.backgroundColor = .white

        [deliveryLabel].forEach {
            self.addSubview($0)
        }

        deliveryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }
    }

    func configureAttributes() {

    }
}
