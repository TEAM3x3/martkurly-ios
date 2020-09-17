//
//  PriceView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/16.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class PriceView: UIView {

    // MARK: - Propertise
    private let sumLabel = UILabel().then {
        $0.text = "상품금액"
    }
    var sumCount = UILabel().then {
        $0.text = "0"
    }
    private let sumWon = UILabel().then {
        $0.text = "원"
    }

    private let discountLabel = UILabel().then {
        $0.text = "상품할인금액"
    }
    var discountCount = UILabel().then {
        $0.text = "0"
    }
    private let discountWon = UILabel().then {
        $0.text = "원"
    }

    private let shipLabel = UILabel().then {
        $0.text = "배송비"
    }
    var shipCount = UILabel().then {
        $0.text = "0"
    }
    private let shipWon = UILabel().then {
        $0.text = "원"
    }

    private let line = UIView().then {
        $0.backgroundColor = .lightGray
    }

    private let estimateSumLabel = UILabel().then {
        $0.text = "결제예정금액"
    }
    var estimateSumCount = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }

    private let estimateWon = UILabel().then {
        $0.text = "원"
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConfigure() {
        backgroundColor = .white
        [sumLabel, sumCount, discountLabel, discountCount, shipLabel, shipCount, line, estimateSumLabel, estimateSumCount, estimateWon, sumWon, discountWon, shipWon].forEach {
            addSubview($0)
        }

        sumLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(32)
            $0.leading.equalTo(self).offset(16)
        }

        sumCount.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.top)
            $0.trailing.equalTo(self).inset(36)
        }

        sumWon.snp.makeConstraints {
            $0.top.equalTo(sumCount.snp.top)
            $0.trailing.equalTo(self).inset(16)
        }

        discountLabel.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(16)
        }

        discountCount.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.top)
            $0.trailing.equalTo(self).inset(36)
        }

        discountWon.snp.makeConstraints {
            $0.top.equalTo(discountCount.snp.top)
            $0.trailing.equalTo(self).inset(16)
        }

        shipLabel.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(16)
        }

        shipCount.snp.makeConstraints {
            $0.top.equalTo(shipLabel.snp.top)
            $0.trailing.equalTo(self).inset(36)
        }

        shipWon.snp.makeConstraints {
            $0.top.equalTo(shipCount.snp.top)
            $0.trailing.equalTo(self).inset(16)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(shipLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self).offset(16).inset(16)
            $0.height.equalTo(1)
        }

        estimateSumLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(20)
            $0.leading.equalTo(self).offset(16)
        }

        estimateSumCount.snp.makeConstraints {
            $0.bottom.equalTo(estimateSumLabel.snp.bottom)
            $0.trailing.equalTo(self).inset(36)
        }

        estimateWon.snp.makeConstraints {
            $0.bottom.equalTo(estimateSumCount.snp.bottom)
            $0.trailing.equalTo(self).inset(16)
        }
    }
}
