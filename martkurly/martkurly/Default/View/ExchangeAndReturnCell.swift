//
//  ExchangeAndReturnCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class ExchangeAndReturnCell: UITableViewCell {

    // MARK: - Properties
    private let title = UILabel().then {
        $0.text = StringManager.changeAndRefund.changeAndRefundTitle.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }

    private let line1 = UILabel().then {
        $0.text = StringManager.changeAndRefund.changeAndRefund1.rawValue
    }

    private let line2 = UILabel().then {
        $0.text = StringManager.changeAndRefund.changeAndRefund2.rawValue
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
        contentView.backgroundColor = .systemBackground
        [title, line1, line2].forEach {
            self.addSubview($0)
            $0.textAlignment = .center
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        [line1, line2].forEach {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
        }

        title.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(70)
        }
        line1.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(32)
        }
        line2.snp.makeConstraints {
            $0.top.equalTo(line1.snp.bottom).offset(8)
        }
    }
}
