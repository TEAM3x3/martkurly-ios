//
//  ChooseProductsDetailView.swift
//  martkurly
//
//  Created by Kas Song on 9/17/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ChooseProductsDetailView: UIView {

    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .textMainGray
    }
    private let currentPrice = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14.5, weight: .regular)
        $0.textColor = .black
    }
    private let priorPrice = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13.5, weight: .regular)
        $0.textColor = .textLightGray
    }
    private let strikethrough = UIView().then {
        $0.backgroundColor = .backgroundGray
    }
    var price = 0
    let stepper = KurlyStepper()
    private var isOnSale = false

    // MARK: - Lifecycle
    init(title: String, currentPrice: String, priorPrice: String, price: Int, isOnSale: Bool) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.currentPrice.text = currentPrice
        self.priorPrice.text = priorPrice
        self.price = price
        self.isOnSale = isOnSale
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        isOnSale ? setConstraintsForIsOnSale() : setContraints()
    }

    private func setContraints() {
        [titleLabel, currentPrice, stepper].forEach {
            self.addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        stepper.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        currentPrice.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(stepper)
        }
    }

    private func setConstraintsForIsOnSale() {
        [titleLabel, currentPrice, priorPrice, strikethrough, stepper].forEach {
            self.addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        stepper.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        priorPrice.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.centerY.equalTo(currentPrice)
        }
        strikethrough.snp.makeConstraints {
            $0.leading.trailing.equalTo(priorPrice)
            $0.centerY.equalTo(priorPrice)
            $0.height.equalTo(1)
        }
        currentPrice.snp.makeConstraints {
            $0.leading.equalTo(priorPrice.snp.trailing).offset(5)
            $0.bottom.equalTo(stepper)
        }
    }
}
