//
//  SignUpTitleLabel.swift
//  martkurly
//
//  Created by Kas Song on 8/25/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpTextFieldTitleView: UIView {

    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    private let mendatoryCheckmark = UILabel().then {
        $0.text = "*"
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    private var mendatory: Bool?

    // MARK: - Lifecycle
    init(title text: String, mendatory: Bool) {
        super.init(frame: .zero)
        self.titleLabel.text = text
        self.mendatory = mendatory
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setConstraints()
    }

    private func setConstraints() {
        guard let mendatory = mendatory else { return }
        if mendatory {
            [titleLabel, mendatoryCheckmark].forEach {
                self.addSubview($0)
            }
            titleLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
//                $0.centerY.equalToSuperview()
            }
            mendatoryCheckmark.snp.makeConstraints {
                $0.top.equalTo(titleLabel).offset(1)
                $0.leading.equalTo(titleLabel.snp.trailing)
            }
        } else {
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview()
//                $0.centerY.equalToSuperview()
            }
        }
    }

}
