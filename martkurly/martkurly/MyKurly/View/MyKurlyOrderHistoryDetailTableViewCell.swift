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
        $0.numberOfLines = 0
//        $0.sizeToFit()
//        $0.clipsToBounds = true
    }
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    // 상세정보가 들어있는 뷰
    private var detailContentView = UIView().then {
        $0.backgroundColor = .yellow
//        $0.isHidden = true
    }
    private var subtitleLabels = [UILabel]()
    private var infoLabels = [UILabel]() // 구매 물품에 따라 다른 정보가 표시
    private var isInitialized = false
    // 상세정보뷰의 상태
    var isFoled = true {
        willSet {
            configureFoldingStatus(newValue: newValue)
        }
    }
    var updateTableView: () -> Void = { return }

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
        updateTableView()
    }

    // MARK: - UI
    private func configureUI() {
        guard isInitialized == false else { return } // layoutSubview 에서 여러번 실행되는 것을 방지
        self.selectionStyle = .none
        setAttributes()
        setContraints()
        isInitialized = true
    }

    private func setAttributes() {
        cellTitle.text = cellData[0]
    }

    private func setContraints() {
        [cellTitle, rightAccessoryImageView, separator, detailContentView].forEach {
            self.addSubview($0)
        }
        cellTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        rightAccessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(cellTitle)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(cellTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        detailContentView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
//            $0.height.greaterThanOrEqualTo(200)
        }

        switch cellType {
        case .orderNumber:
            setConstraintsForOrderNumber()
        case .info:
            generateSubtitles()
            setConstraintsForInfo()
        }
    }

    private func setConstraintsForOrderNumber() {

    }

    private func setConstraintsForInfo() {
        for index in subtitleLabels.indices {
            let subtitleLabel = subtitleLabels[index]
            let infoLabel = infoLabels[index]
            [subtitleLabel, infoLabel].forEach {
                detailContentView.addSubview($0)
            }
            if index == 0 {
                subtitleLabel.snp.makeConstraints {
                    $0.top.equalTo(separator.snp.bottom).offset(20)
                    $0.leading.equalTo(cellTitle)
                }
            } else {
                subtitleLabel.snp.makeConstraints {
                    $0.top.equalTo(subtitleLabels[index - 1].snp.bottom).offset(15)
                    $0.leading.equalTo(cellTitle)
                }
            }
            infoLabel.snp.makeConstraints {
                $0.leading.equalTo(cellTitle.snp.leading).offset(135)
                $0.centerY.equalTo(subtitleLabel)
            }
            if index == (subtitleLabels.count - 1) {
                subtitleLabel.snp.makeConstraints {
                    $0.bottom.equalToSuperview().inset(20)
                }
            }
        }
    }

    private func generateSubtitles() {
        for index in cellData.indices {
            if index == 0 { continue }
            let text = cellData[index]
            let subtitleLabel = UILabel().then {
                $0.text = text
                $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
            }
            let infoLabel = UILabel().then {
                $0.text = "이곳에 정보가 표시됩니다."
                $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            }
            subtitleLabels.append(subtitleLabel)
            infoLabels.append(infoLabel)
        }
    }

    // MARK: - Helpers
    func configureCell(cellData: [String], cellType: MyKurlyDetailCellType) {
        self.cellData = cellData
        self.cellType = cellType
    }

    private func configureFoldingStatus(newValue: Bool) {
        print(#function)
        switch newValue {
        case true:
            detailContentView.isHidden = true
        case false:
            detailContentView.isHidden = false
        }
    }
}
