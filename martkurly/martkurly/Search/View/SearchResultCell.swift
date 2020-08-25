//
//  SearchResultCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SearchResultCell"

    private let resultLabel = UILabel().then {
        $0.text = "테스트"
        $0.font = .systemFont(ofSize: 18)
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

        self.addSubview(resultLabel)
        resultLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        let underLine = UIView()
        underLine.backgroundColor = ColorManager.General.backGray.rawValue

        self.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
