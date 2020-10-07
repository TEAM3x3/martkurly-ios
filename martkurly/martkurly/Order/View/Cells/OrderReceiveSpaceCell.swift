//
//  OrderReceiveSpaceCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderReceiveSpaceCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "OrderReceiveSpaceCell"

    private let spaceTitleLabel = UILabel().then {
        $0.text = "문 앞"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let accessUsageLabel = UILabel().then {
        $0.text = "출입방법 : 기타(경비실 호출하시면 됩니다)"
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

        [spaceTitleLabel, accessUsageLabel].forEach {
            self.addSubview($0)
        }

        spaceTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        accessUsageLabel.snp.makeConstraints {
            $0.top.equalTo(spaceTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }

    func configure(titleText: String, accessUsageText: String? = nil) {
        spaceTitleLabel.text = titleText
        accessUsageLabel.text = accessUsageText
    }
}
