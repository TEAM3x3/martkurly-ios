//
//  DeliverySaveButtonCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DeliverySaveButtonCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "DeliverySaveButtonCell"

    private let infoLabel = UILabel().then {
        $0.text = "배송 정보 저장에 동의합니다"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let saveButton = KurlyButton(title: "저장",
                                         style: .purple)

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

        [infoLabel, saveButton].forEach {
            self.addSubview($0)
        }

        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(orderVCSideInsetValue)
        }

        saveButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(12)
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
            $0.height.equalTo(44)
        }
    }
}
