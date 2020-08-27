//
//  SortListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SortListCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SortListCell"

    let sortTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
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
        self.addSubview(sortTitleLabel)
        sortTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    func configure(cellText: String, isSelected: Bool) {
        sortTitleLabel.text = cellText

        sortTitleLabel.font = isSelected ?
            .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 16)
        sortTitleLabel.textColor = isSelected ?
            ColorManager.General.mainPurple.rawValue : .black
    }
}
