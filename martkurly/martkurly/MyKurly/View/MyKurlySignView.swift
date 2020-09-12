//
//  MyCurlySignView.swift
//  martkurly
//
//  Created by Kas Song on 8/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlySignView: UIView {

    // MARK: - Properties
    private let welcomeLabel = UILabel().then {
        let text = StringManager.MyKurly.welcome.rawValue
        let attributedText = StringManager().setParagraphStyle(text: text, spacing: 4)
        $0.attributedText = attributedText
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private let promotionButton = UIButton().then {
        $0.setTitle(StringManager.MyKurly.promotion.rawValue, for: .normal)
        $0.setTitleColor(.agreementInfoGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    let signButton = KurlyButton(title: StringManager.MyKurly.sign.rawValue, style: .purple)

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
        [welcomeLabel, promotionButton, signButton].forEach {
            self.addSubview($0)
        }
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
        promotionButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        signButton.snp.makeConstraints {
            $0.top.equalTo(promotionButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
    }

}
