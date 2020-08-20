//
//  NotChangeAndReturnView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class NotChangeAndReturnView: UITableViewCell {

    // MARK: - Properties
    private let line1 = UILabel().then {
        $0.text = StringManager.notExchangeAndReturn.line.rawValue
    }

    private let line2 = UILabel().then {
        $0.text = StringManager.notExchangeAndReturn.line1.rawValue
    }

    private let line3 = UILabel().then {
        $0.text = StringManager.notExchangeAndReturn.line2.rawValue
    }

    private let line4 = UILabel().then {
        $0.text = StringManager.notExchangeAndReturn.line3.rawValue
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
        [line1, line2, line3, line4].forEach {
            self.addSubview($0)
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.snp.leading).offset(16)
            }
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 13)
            let attributedString = NSMutableAttributedString(string: $0.text ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            $0.attributedText = attributedString
        }

        line1.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(56)
        }

        line2.snp.makeConstraints {
            $0.top.equalTo(line1.snp.bottom).offset(16)
        }

        line3.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(8)
        }

        line4.snp.makeConstraints {
            $0.top.equalTo(line3.snp.bottom).offset(8)
        }
    }
}
