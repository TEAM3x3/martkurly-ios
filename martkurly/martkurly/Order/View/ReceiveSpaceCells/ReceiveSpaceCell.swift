//
//  ReceiveSpaceCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReceiveSpaceCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ReceiveSpaceCell"

    private let checkButton = KurlyChecker()
    private let spaceTitleLabel = UILabel().then {
        $0.text = "테스트"
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

        [checkButton, spaceTitleLabel].forEach {
            self.addSubview($0)
        }

        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(orderVCSideInsetValue)
            $0.top.bottom.equalToSuperview().inset(12)
        }

        spaceTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(titleText: String?, isActive: Bool) {
        spaceTitleLabel.text = titleText
        checkButton.isActive = isActive
    }
}
