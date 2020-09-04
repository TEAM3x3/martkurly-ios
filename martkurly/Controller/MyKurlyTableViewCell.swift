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
    static let identifier = "MyKurlyTableViewCell"

    private let cellTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17.5, weight: .light)
    }
    private let rightAccessoryImageView = UIImageView().then {
        let image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        $0.image = image
    }
    private let cellSubtitle = UILabel().then {
        $0.text = ""
        $0.textColor = .martkurlyMainPurpleColor
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    private var separator = UIView().then {
        $0.backgroundColor = .separatorGray
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
        self.selectionStyle = .none
        setContraints()
    }

    private func setContraints() {
        [cellTitle, separator].forEach {
            self.addSubview($0)
        }
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
            setConstrainsForNormalType()
            setConstrainsForSubtitleType()
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }

    private func setConstrainsForNormalType() {
        self.addSubview(rightAccessoryImageView)
        rightAccessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(10)
            $0.height.equalTo(20)
        }
    }

    private func setConstrainsForSubtitleType() {
        self.addSubview(cellSubtitle)
        cellSubtitle.snp.makeConstraints {
            $0.trailing.equalTo(rightAccessoryImageView.snp.leading).offset(-13)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Helpers
    func configureCell(title: String, subtitle: String, cellType: MyKurlyCellType) {
        self.cellTitle.text = title
        self.cellSubtitle.text = subtitle
        self.cellType = cellType
    }
}
