//
//  AdditionalInfoView.swift
//  martkurly
//
//  Created by Kas Song on 8/26/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class AdditionalInfoView: UIView {

    // MARK: - Properties
    private let titleView = SignUpTextFieldTitleView(title: StringManager.SignUp.additionalInfo.rawValue, mendatory: false)
    private let subtitleView = UILabel().then {
        $0.text = StringManager.SignUp.additionalInfoSubtitle.rawValue
        $0.textColor = .agreementInfoGray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    let tableView = UITableView()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        tableView.register(AdditionalInfoTableViewCell.self, forCellReuseIdentifier: AdditionalInfoTableViewCell.identifier)
        tableView.separatorStyle = .none
    }

    private func setContraints() {
        [titleView, subtitleView, tableView].forEach {
            self.addSubview($0)
        }
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        subtitleView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.leading.equalTo(titleView)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(subtitleView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
