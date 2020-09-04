//
//  MyKurlyTableViewCell.swift
//  martkurly
//
//  Created by Kas Song on 9/4/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyTableViewCell: UITableViewCell {

    // MARK: - Properties
    private let cellTitle = UILabel()
    private let rightAccessoryImageView = UIImageView()
    private let cellSubtitle = UILabel().then {
        $0.text = "143 원"
        $0.textColor = .martkurlyMainPurpleColor
        $0.font = UIFont.boldSystemFont(ofSize: 15)
    }
    private var cellType: MyKurlyCellType = .normal

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {
        self.addSubview(cellTitle)
        cellTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        switch self.cellType {
        case .simple:
            break
        case .normal:
            setConstrainsForNormalType()
        case .subtitle:
            setConstrainsForSubtitleType()
        }
    }

    private func setConstrainsForNormalType() {

    }

    private func setConstrainsForSubtitleType() {

    }

    // MARK: - Helpers
    func configureCell() {

    }
}
