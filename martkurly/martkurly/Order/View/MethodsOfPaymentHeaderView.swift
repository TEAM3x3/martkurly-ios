//
//  MethodsOfPaymentHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MethodsOfPaymentHeaderView: UIView {

    // MARK: - Properties

    var paymentType: PaymentType = .creditCard {
        didSet { paymentImageView.image = UIImage(named: paymentType.imageName) }
    }

    var isShowPaymentList = false {
        didSet {
            showListButton.image = isShowPaymentList ?
                UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            paymentImageView.isHidden = isShowPaymentList
        }
    }

    private let paymentTitleLabel = UILabel().then {
        $0.text = "결제 수단*"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let paymentImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.lessThanOrEqualTo(100)
        }
    }

    private let showListButton = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .black
        $0.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
    }

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
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.backgroundColor = .white

        [paymentTitleLabel, paymentImageView, showListButton].forEach {
            self.addSubview($0)
        }

        paymentTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        paymentImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(showListButton.snp.leading).offset(-8)
        }

        showListButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }
    }

    func configureAttributes() {
        paymentImageView.image = UIImage(named: paymentType.imageName)
    }
}
