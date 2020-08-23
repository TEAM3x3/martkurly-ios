//
//  CategoryDetailButtonCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class DetailTableViewCell: UITableViewCell {

    // MARK: - Properties

    private let btn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitleColor(.black, for: .normal)
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        addSubview(btn)
        btn.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.equalTo(contentView).offset(64)
            $0.trailing.equalTo(contentView)
        }
    }

    func configure(title: String) {
        btn.setTitle(title, for: .normal)
    }
}
