//
//  SpaceConfirmButtonCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SpaceConfirmButtonCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SpaceConfirmButtonCell"

    private let confirmButton = KurlyButton(title: "확인", style: .purple)

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

        self.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(orderVCSideInsetValue)
            $0.height.equalTo(52)
        }
    }
}
