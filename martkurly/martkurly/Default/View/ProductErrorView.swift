//
//  ProductErrorCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class ProductErrorView: UITableViewCell {

    // MARK: - Properties
    private let line1 = UILabel().then {
        $0.text = StringManager.productErrorCase.productErrorCase1.rawValue
    }

    private let line2 = UILabel().then {
        $0.text = StringManager.productErrorCase.freshColdFreeze.rawValue
    }

    private let line3 = UILabel().then {
        $0.text = StringManager.productErrorCase.freshColdFreeze1.rawValue
    }

    private let line4 = UILabel().then {
        $0.text = StringManager.productErrorCase.expirationDate.rawValue
    }

    private let line5 = UILabel().then {
        $0.text = StringManager.productErrorCase.expirationDate1.rawValue
    }

    private let line6 = UILabel().then {
        $0.text = StringManager.productErrorCase.expirationDate2.rawValue
    }

    private let line7 = UILabel().then {
        $0.text = StringManager.productErrorCase.reference.rawValue
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
        [line1, line2, line3, line4, line5, line6, line7].forEach {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.snp.leading).inset(16)
            }
        }

        [line2, line4, line5].forEach {
            $0.textColor = ColorManager.General.mainPurple.rawValue
            $0.font = UIFont.boldSystemFont(ofSize: 14)
        }

        [line1, line3, line6, line7].forEach {
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.numberOfLines = 0
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
            $0.top.equalTo(line1.snp.bottom).offset(24)
        }

        line3.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(8)
        }

        line4.snp.makeConstraints {
            $0.top.equalTo(line3.snp.bottom).offset(24)
        }

        line5.snp.makeConstraints {
            $0.top.equalTo(line4.snp.bottom).offset(8)
        }

        line6.snp.makeConstraints {
            $0.top.equalTo(line5.snp.bottom).offset(8)
        }

        line7.snp.makeConstraints {
            $0.top.equalTo(line6.snp.bottom).offset(24)
        }
    }
}
