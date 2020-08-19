//
//  CancelMoreNoticeView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CancelMoreNoticeView: UIView {

    // MARK: - Properties
    private let orderCancelTitle = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.orderCancel.rawValue
    }

    private let orderCancelLabel1 = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.orderCancel1.rawValue
    }

    private let orderCancelLabel2 = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.orderCancel2.rawValue
    }

    private let orderCancelLabel3 = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.orderCancel3.rawValue
    }

    private let orderCancelLabel4 = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.orderCacnel4.rawValue
    }

    private let paymentRefund = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.paymentRefund.rawValue
    }

    private let paymentRefund1 = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.paymentRefund1.rawValue
    }

    private let paymentRefund2 = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.paymentRefund2.rawValue
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.backgroundColor = ColorManager.General.backGray.rawValue

        [orderCancelLabel1, orderCancelLabel2, orderCancelLabel3, orderCancelLabel4, paymentRefund1, paymentRefund2].forEach {
            self.addSubview($0)
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.numberOfLines = 0
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
            let attributedString = NSMutableAttributedString(string: $0.text ?? "")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            $0.attributedText = attributedString
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.snp.leading).inset(16)
            }
        }

        [orderCancelTitle, paymentRefund].forEach {
            self.addSubview($0)
            $0.font = UIFont.boldSystemFont(ofSize: 14)
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.snp.leading).inset(16)
            }
        }

        orderCancelTitle.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(50)
        }

        orderCancelLabel1.snp.makeConstraints {
            $0.top.equalTo(orderCancelTitle.snp.bottom).offset(8)
        }

        orderCancelLabel2.snp.makeConstraints {
            $0.top.equalTo(orderCancelLabel1.snp.bottom).offset(5)
        }

        orderCancelLabel3.snp.makeConstraints {
            $0.top.equalTo(orderCancelLabel2.snp.bottom).offset(5)
        }

        orderCancelLabel4.snp.makeConstraints {
            $0.top.equalTo(orderCancelLabel3.snp.bottom).offset(5)
        }

        paymentRefund.snp.makeConstraints {
            $0.top.equalTo(orderCancelLabel4.snp.bottom).offset(32)
        }

        paymentRefund1.snp.makeConstraints {
            $0.top.equalTo(paymentRefund.snp.bottom).offset(8)
        }

        paymentRefund2.snp.makeConstraints {
            $0.top.equalTo(paymentRefund1.snp.bottom).offset(5)
        }

    }

}
