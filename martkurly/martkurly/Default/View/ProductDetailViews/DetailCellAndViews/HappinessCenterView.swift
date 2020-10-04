//
//  HappinessCenterView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/31.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class HappinessCenterView: UIView {

    // MARK: - Properties

    private let defaultPaddingValue: CGFloat = 12

    private let centerTitleLabel = UILabel().then {
        $0.text = StringManager.HappinessCenterText.title
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }

    private let centerTitleUsageLabel = UILabel().then {
        $0.text = StringManager.HappinessCenterText.titleUsage
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.setLineSpacing(lineSpacing: 8.0)
    }

    private lazy var callInquiryStackView =
        makeInquiryStackView(inquiryTitleText: StringManager.HappinessCenterText.inquiryCallTitle,
                             inquiryTimeText: StringManager.HappinessCenterText.inquiryCallTime)
    private lazy var kakaotalkStackView =
        makeInquiryStackView(inquiryTitleText: StringManager.HappinessCenterText.inquiryKakaotalkTitle,
                             inquiryTimeText: StringManager.HappinessCenterText.inquiryKakaotalkTime,
                             inquiryButtonTitleText: StringManager.HappinessCenterText.inquiryKakaotalkButton,
                             inquiryButtonUsageText: StringManager.HappinessCenterText.inquiryKakaotalkUsage)
    private lazy var homepageStackView =
        makeInquiryStackView(inquiryTitleText: StringManager.HappinessCenterText.inquiryHomepageTitle,
                             inquiryTimeText: StringManager.HappinessCenterText.inquiryHomepageTime,
                             inquiryButtonTitleText: StringManager.HappinessCenterText.inquiryHomepageButton,
                             inquiryButtonUsageText: StringManager.HappinessCenterText.inquiryHomepageUsage)

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        [centerTitleLabel, centerTitleUsageLabel, callInquiryStackView, kakaotalkStackView, homepageStackView].forEach {
            self.addSubview($0)
        }

        centerTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
        }

        centerTitleUsageLabel.snp.makeConstraints {
            $0.top.equalTo(centerTitleLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
        }

        callInquiryStackView.snp.makeConstraints {
            $0.top.equalTo(centerTitleUsageLabel.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
        }

        kakaotalkStackView.snp.makeConstraints {
            $0.top.equalTo(callInquiryStackView.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
        }

        homepageStackView.snp.makeConstraints {
            $0.top.equalTo(kakaotalkStackView.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
        }
    }

    func makeInquiryStackView(inquiryTitleText: String,
                              inquiryTimeText: String,
                              inquiryButtonTitleText: String? = nil,
                              inquiryButtonUsageText: String? = nil) -> UIStackView {
        let inquiryTitleLabel = UILabel()
        inquiryTitleLabel.text = inquiryTitleText
        inquiryTitleLabel.textColor = .black
        inquiryTitleLabel.textAlignment = .center
        inquiryTitleLabel.font = .systemFont(ofSize: 18)

        let inquiryTimeLabel = UILabel()
        inquiryTimeLabel.text = inquiryTimeText
        inquiryTimeLabel.textColor = .black
        inquiryTimeLabel.textAlignment = .center
        inquiryTimeLabel.numberOfLines = 0
        inquiryTimeLabel.font = .systemFont(ofSize: 14)
        inquiryTimeLabel.setLineSpacing(lineSpacing: 8.0)

        let inquiryStackView = UIStackView(arrangedSubviews: [inquiryTitleLabel, inquiryTimeLabel])
        inquiryStackView.axis = .vertical
        inquiryStackView.spacing = 8

        guard let inquiryButtonTitleText = inquiryButtonTitleText,
            let inquiryButtonUsageText = inquiryButtonUsageText else { return inquiryStackView }

        let inquiryButton = UIButton(type: .system)
        inquiryButton.setTitle(inquiryButtonTitleText, for: .normal)
        inquiryButton.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
        inquiryButton.titleLabel?.font = .systemFont(ofSize: 16)
        inquiryButton.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        inquiryButton.layer.borderWidth = 1
        inquiryButton.layer.cornerRadius = 40 / 2
        inquiryButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(188)
        }

        let inquiryUsageLabel = UILabel()
        inquiryUsageLabel.text = inquiryButtonUsageText
        inquiryUsageLabel.textColor = ColorManager.General.chevronGray.rawValue
        inquiryUsageLabel.textAlignment = .center
        inquiryUsageLabel.numberOfLines = 0
        inquiryUsageLabel.font = .systemFont(ofSize: 14)
        inquiryUsageLabel.setLineSpacing(lineSpacing: 8.0)

        let amountStackView = UIStackView(arrangedSubviews: [
            inquiryStackView, inquiryButton, inquiryUsageLabel
        ])
        amountStackView.axis = .vertical
        amountStackView.spacing = 16
        amountStackView.alignment = .center

        return amountStackView
    }
}
