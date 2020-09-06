//
//  MyKurlyOrderHistoryDetailTableViewCell.swift
//  martkurly
//
//  Created by Kas Song on 9/6/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyOrderHistoryDetailTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MyKurlyOrderHistoryDetailTableViewCell"
    private var cellType: MyKurlyDetailCellType = .orderNumber
    private var cellData = [String]()

    private let rightAccessoryImageView = UIImageView().then {
        let image = UIImage(systemName: "chevron.down")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        $0.image = image
    }
    private var cellTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }

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
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        cellTitle.text = cellData[0]
    }

    private func setContraints() {
        [cellTitle, rightAccessoryImageView, separator].forEach {
            self.addSubview($0)
        }
        cellTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        rightAccessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(cellTitle)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(cellTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        switch cellType {
        case .orderNumber:
            setConstraintsForOrderNumber()
        case .info:
            setConstraintsForInfo()
        }
        generateSubtitles()
    }

    private func setConstraintsForOrderNumber() {

    }

    private func setConstraintsForInfo() {

    }

    private func generateSubtitles() {

    }

    // MARK: - Helpers
    func configureCell(cellData: [String], cellType: MyKurlyDetailCellType) {
        self.cellData = cellData
        self.cellType = cellType
    }
}
