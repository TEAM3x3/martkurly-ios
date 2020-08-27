//
//  OrderCancelNotice.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class OrderCancelNoticeCell: UITableViewCell {

    // MARK: - Properties
    private let view = UIView().then {
        $0.backgroundColor = .systemBackground
    }

    private let title = UILabel().then {
        $0.text = StringManager.orderCancelNotice.orderCancelNoticeTitle.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
    }

    private let depositIdentify1 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentify1.rawValue
    }

    private let depositIdentify2 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentify2.rawValue
    }

    private let depositIdentify3 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentify3.rawValue
    }

    private let depositIdentifyAfter1 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentifyAfter1.rawValue
    }

    private let depositIdentifyAfter2 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentifyAfter2.rawValue
    }

    private let paymentCancelRefund1 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.paymentCancelRefund1.rawValue
    }

    private let paymentCancelRefund2 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.paymentCancelRefund2.rawValue
    }

    // MARK: - LifeCycle
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
        self.addSubview(view)
        [depositIdentify1, depositIdentify2, depositIdentify3, depositIdentifyAfter1, depositIdentifyAfter2, paymentCancelRefund1, paymentCancelRefund2].forEach {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        [title].forEach {
            self.addSubview($0)
        }

        [depositIdentify1, depositIdentifyAfter1, paymentCancelRefund1].forEach {
            $0.font = UIFont.boldSystemFont(ofSize: 14)
        }

        view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        title.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(64)
            $0.centerX.equalToSuperview()
        }
        depositIdentify1.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(32)
        }
        depositIdentify2.snp.makeConstraints {
            $0.top.equalTo(depositIdentify1.snp.bottom).offset(4)
        }
        depositIdentify3.snp.makeConstraints {
            $0.top.equalTo(depositIdentify2.snp.bottom).offset(4)
        }
        depositIdentifyAfter1.snp.makeConstraints {
            $0.top.equalTo(depositIdentify3.snp.bottom).offset(16)
        }
        depositIdentifyAfter2.snp.makeConstraints {
            $0.top.equalTo(depositIdentifyAfter1.snp.bottom).offset(4)
        }
        paymentCancelRefund1.snp.makeConstraints {
            $0.top.equalTo(depositIdentifyAfter2.snp.bottom).offset(16)
        }
        paymentCancelRefund2.snp.makeConstraints {
            $0.top.equalTo(paymentCancelRefund1.snp.bottom).offset(4)
        }
    }
}
