//
//  FirstTableViewCell.swift
//  NewTableView
//
//  Created by ㅇ오ㅇ on 2020/09/03.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import Then

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "FirstTableViewCell"

    let label = UIButton().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    let titleLabel = UILabel().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConfigure() {
        setConstraints()
    }

    func setConstraints() {
        backgroundColor = ColorManager.General.backGray.rawValue

        [label, titleLabel].forEach {
            self.addSubview($0)
        }

        label.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.leading.equalTo(label).offset(64)
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }

}
