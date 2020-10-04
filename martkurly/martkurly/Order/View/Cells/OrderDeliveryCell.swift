//
//  OrderDeliveryCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderDeliveryCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "OrderDeliveryCell"

    private let starsDeliveryTextView = HalfCircleTextView().then {
        $0.configure(text: "샛별배송",
                     textColor: ColorManager.General.mainPurple.rawValue,
                     backgroundColor: .white,
                     borderColor: ColorManager.General.mainPurple.rawValue)
    }

    private let defaultDeliveryTextView = HalfCircleTextView().then {
        $0.configure(text: "기본배송지",
                     textColor: ColorManager.General.mainPurple.rawValue,
                     backgroundColor: UIColor(red: 239, green: 229, blue: 239),
                     borderColor: .clear)
    }

    private let deliveryAddressLabel = UILabel().then {
        $0.text = "경기 부천시 심곡로9번길 47, 휴먼스빌 000호"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.numberOfLines = 2
    }

    private let userInfoLabel = UILabel().then {
        $0.text = "천지운, 010-1234-5678"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let deliveryHolidayInfoLabel = UILabel().then {
        $0.text = "배송 휴무일: 샛별배송 (휴무없음), 택배배송 (일요일)"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
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

        [starsDeliveryTextView, defaultDeliveryTextView, deliveryAddressLabel, userInfoLabel, deliveryHolidayInfoLabel].forEach {
            self.addSubview($0)
        }

        starsDeliveryTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        defaultDeliveryTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(starsDeliveryTextView.snp.trailing).offset(4)
        }

        deliveryAddressLabel.snp.makeConstraints {
            $0.top.equalTo(starsDeliveryTextView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }

        userInfoLabel.snp.makeConstraints {
            $0.top.equalTo(deliveryAddressLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        deliveryHolidayInfoLabel.snp.makeConstraints {
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
