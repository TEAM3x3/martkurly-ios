//
//  DeliveryActionCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DeliveryActionCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "DeliveryActionCell"

    private let kurlyChecker = KurlyChecker()
    private let actionTitleLabel = UILabel().then {
        $0.text = "결제수단으로 환불"
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
        [kurlyChecker, actionTitleLabel].forEach {
            self.addSubview($0)
        }

        kurlyChecker.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        actionTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(kurlyChecker)
            $0.leading.equalTo(kurlyChecker.snp.trailing).offset(12)
        }
    }

    func configure(isChecked: Bool, titleText: String) {
        kurlyChecker.isActive = isChecked
        actionTitleLabel.text = titleText
    }
}
