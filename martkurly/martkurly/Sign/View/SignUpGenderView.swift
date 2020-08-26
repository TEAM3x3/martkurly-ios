//
//  SignUpGenderView.swift
//  martkurly
//
//  Created by Kas Song on 8/26/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpGenderView: UIView {

    // MARK: - Properties
    private let title = SignUpTextFieldTitleView(title: StringManager.SignUp.gender.rawValue, mendatory: false)
    private let tableView = UITableView()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {
        [title, tableView].forEach {
            self.addSubview($0)
        }
        title.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
