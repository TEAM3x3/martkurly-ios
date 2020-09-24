//
//  OrdererInfomationCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrdererInfomationCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "OrdererInfomationCell"

    private let ordererNameLabel = UILabel().then {
        $0.text = "천지운"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let ordererPhoneLabel = UILabel().then {
        $0.text = "010-1234-5678"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let ordererEmailLabel = UILabel().then {
        $0.text = "test@gmail.com"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let ordererGuideLabel = UILabel().then {
        $0.text = "주문자 정보 변경 방법 : 마이컬리 > 개인정보 수정"
        $0.textColor = .lightGray
        $0.font = .boldSystemFont(ofSize: 12)
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
        self.backgroundColor = .clear

        let amountStack = UIStackView(arrangedSubviews: [
            makeInfoStackView(titleText: "보내는 분", displayLabel: ordererNameLabel),
            makeInfoStackView(titleText: "휴대폰", displayLabel: ordererPhoneLabel),
            makeInfoStackView(titleText: "이메일", displayLabel: ordererEmailLabel),
            ordererGuideLabel
        ])
        amountStack.axis = .vertical
        amountStack.spacing = 16

        self.addSubview(amountStack)
        amountStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-orderVCSideInsetValue)
        }
    }

    func makeInfoStackView(titleText: String, displayLabel: UILabel) -> UIStackView {
        let label = UILabel()
        label.text = titleText
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }

        let stack = UIStackView(arrangedSubviews: [label, displayLabel])
        stack.axis = .horizontal
        stack.spacing = 4

        return stack
    }
}
