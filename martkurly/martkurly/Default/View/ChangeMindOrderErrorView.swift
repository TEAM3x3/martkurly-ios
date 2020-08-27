//
//  ChangeMindOrderErrorView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class ChangeMaindOrderErrorView: UITableViewCell {

    // MARK: - Properties
    private let line1 = UILabel().then {
        $0.text = StringManager.changeMindAndOrderError.freshColdFreeze.rawValue
    }

    private let line2 = UILabel().then {
        $0.text = StringManager.changeMindAndOrderError.freshColdFreeze1.rawValue
    }

    private let line3 = UILabel().then {
        $0.text = StringManager.changeMindAndOrderError.expirationDateOver.rawValue
    }

    private let line4 = UILabel().then {
        $0.text = StringManager.changeMindAndOrderError.expirationDateOver1.rawValue
    }

    private let line5 = UILabel().then {
        $0.text = StringManager.changeMindAndOrderError.expirationDateOver2.rawValue
    }

    private let line6 = UILabel().then {
        $0.text = StringManager.changeMindAndOrderError.reference.rawValue
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
        contentView.backgroundColor = ColorManager.General.backGray.rawValue
        [line1, line2, line3, line4, line5, line6].forEach {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.snp.leading).offset(16)
            }
        }

        [line1, line3, line4].forEach {
            $0.textColor = ColorManager.General.mainPurple.rawValue
            $0.font = UIFont.boldSystemFont(ofSize: 14)
        }

        [line2, line5, line6].forEach {
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 13)
            let attributedString = NSMutableAttributedString(string: $0.text ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            $0.attributedText = attributedString
        }

        line1.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(48)
        }

        line2.snp.makeConstraints {
            $0.top.equalTo(line1.snp.bottom).offset(8)
        }

        line3.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(24)
        }

        line4.snp.makeConstraints {
            $0.top.equalTo(line3.snp.bottom).offset(8)
        }

        line5.snp.makeConstraints {
            $0.top.equalTo(line4.snp.bottom).offset(8)
        }

        line6.snp.makeConstraints {
            $0.top.equalTo(line5.snp.bottom).offset(24)
        }
    }
}
