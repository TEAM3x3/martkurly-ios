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
    }
    private let currentPrice = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    private let priorPrice = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    private let stepper = KurlyStepper()

    private var isOnSale = false

    // MARK: - Lifecycle
    init(isOnSale: Bool) {
        super.init(frame: .zero)
        self.isOnSale = isOnSale
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        isOnSale ? setContraints() : setConstraintsForIsOnSale()
    }

    private func setContraints() {
        [titleLabel, currentPrice, priorPrice, stepper].forEach {
            self.addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

    }

    private func setConstraintsForIsOnSale() {

    }

    // MARK: - Helpers
    func configureViewData(title: String, currentPrice: String, priorPrice: String) {

    }
}
