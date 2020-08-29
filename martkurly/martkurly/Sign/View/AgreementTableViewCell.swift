//
//  AgreementTableViewCell.swift
//  martkurly
//
//  Created by Doyoung Song on 8/21/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class AgreementTableViewCell: UITableViewCell {

    // MARK: - Properties
    private var cellType: AgreementCellType = .title

    let checkmark = AgreementCheckMarkView()
    private let title = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    private let info = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    private let subtitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .agreementInfoGray
        $0.clipsToBounds = true
    }
    private let pushButton = UIButton().then {
        $0.setImage(ImageManager.General.goForward.rawValue, for: .normal)
    }
    let smsCheckmark = AgreementCheckMarkView()
    let smsLabel = UILabel().then {
        $0.text = "SMS"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    private let agreementPromotionView = AgreementPromotionView()
    let emailCheckmark = AgreementCheckMarkView()
    let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }

    private let separator = UIView().then {
        $0.backgroundColor = ColorManager.General.separator.rawValue
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
    }

    private func setConstraints() {
        switch cellType {
        case .title:
            setPropertiesForTitleType()
        case .page:
            setPropertiesForPageType()
        case .choice:
            setPropertiesForChoiceType()
        case .normal:
            setPropertiesForNormalType()
        }
    }

    private func setPropertiesForTitleType() {
        title.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        info.textColor = ColorManager.General.mainGray.rawValue

        [checkmark, title, info, separator].forEach {
            self.addSubview($0)
        }
        checkmark.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(checkmark.snp.trailing).offset(12)
            $0.bottom.equalTo(checkmark).offset(-3)
        }
        info.snp.makeConstraints {
            $0.leading.equalTo(checkmark).inset(4)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(checkmark.snp.bottom).offset(12)
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    private func setPropertiesForPageType() {
        [checkmark, title, subtitle, pushButton].forEach {
            self.addSubview($0)
        }
        checkmark.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(checkmark.snp.trailing).offset(12)
            $0.bottom.equalTo(checkmark).offset(-3)
        }
        subtitle.snp.makeConstraints {
            $0.bottom.equalTo(title)
            $0.leading.equalTo(title.snp.trailing).offset(8)
        }
        pushButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(checkmark)
            $0.height.width.equalTo(15)
        }
    }

    private func setPropertiesForChoiceType() {
        [smsCheckmark, smsLabel, emailCheckmark, emailLabel, agreementPromotionView].forEach {
            self.addSubview($0)
        }
        smsCheckmark.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(40)
            $0.height.width.equalTo(30)
        }
        smsLabel.snp.makeConstraints {
            $0.leading.equalTo(smsCheckmark.snp.trailing).offset(8)
            $0.bottom.equalTo(smsCheckmark).offset(-3)
        }
        emailCheckmark.snp.makeConstraints {
            $0.top.equalTo(smsCheckmark)
            $0.leading.equalTo(smsLabel.snp.trailing).offset(112)
            $0.height.width.equalTo(30)
        }
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(emailCheckmark.snp.trailing).offset(8)
            $0.bottom.equalTo(emailCheckmark).offset(-3)
        }
        agreementPromotionView.snp.makeConstraints {
            $0.top.equalTo(smsCheckmark.snp.bottom).offset(12)
            $0.leading.equalTo(smsCheckmark)
            $0.width.equalTo(230)
            $0.height.equalTo(70)
        }
    }

    private func setPropertiesForNormalType() {
        [checkmark, title, subtitle].forEach {
            self.addSubview($0)
        }
        checkmark.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(checkmark.snp.trailing).offset(12)
            $0.bottom.equalTo(checkmark).offset(-3)
        }
        subtitle.snp.makeConstraints {
            $0.bottom.equalTo(title)
            $0.leading.equalTo(title.snp.trailing).offset(8)
        }
    }

    // MARK: - Helpers
    func configureCell(title: String, info: String, subtitle: String, cellType: AgreementCellType) {
        self.title.text = title
        self.info.attributedText = StringManager().setParagraphStyle(text: info, spacing: 5)
        self.subtitle.text = subtitle
        self.cellType = cellType
    }

}
