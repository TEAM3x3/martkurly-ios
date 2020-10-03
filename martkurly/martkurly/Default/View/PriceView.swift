//
//  PriceView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/16.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class PriceView: UITableViewCell {

    // MARK: - Propertise
    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    private let sumLabel = UILabel().then {
        $0.text = "상품금액"
    }

    // MARK: - 상품금액
    private let sumCount = UILabel().then { // 상품금액
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        let formatter = NumberFormatter().then {
            $0.numberStyle = .decimal    // 천 단위로 콤마(,)

            $0.minimumFractionDigits = 0    // 최소 소수점 단위
            $0.maximumFractionDigits = 0    // 최대 소수점 단위
        }

        var attribute = NSMutableAttributedString(
            string: (formatter.string(for: "0") ?? "0"),
            attributes: attributes)

        $0.attributedText = attribute
    }

    private let sumWon = UILabel().then {
        $0.text = "원"
    }

    private let discountLabel = UILabel().then {
        $0.text = "상품할인금액"
    }

    // MARK: - 상품할인금액
    private var discountCount = UILabel().then { // 상품할인금액
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        let formatter = NumberFormatter().then {
            $0.numberStyle = .decimal    // 천 단위로 콤마(,)

            $0.minimumFractionDigits = 0    // 최소 소수점 단위
            $0.maximumFractionDigits = 0    // 최대 소수점 단위
        }

        var attribute = NSMutableAttributedString(
            string: (formatter.string(for: "0") ?? "0"),
            attributes: attributes)

        $0.attributedText = attribute
    }
    private let discountWon = UILabel().then {
        $0.text = "원"
    }

    private let shipLabel = UILabel().then {
        $0.text = "배송비"
    }

    // MARK: - 배송비
    private var shipCount = UILabel().then { // 배송비
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        let formatter = NumberFormatter().then {
            $0.numberStyle = .decimal    // 천 단위로 콤마(,)

            $0.minimumFractionDigits = 0    // 최소 소수점 단위
            $0.maximumFractionDigits = 0    // 최대 소수점 단위
        }

        var attribute = NSMutableAttributedString(
            string: (formatter.string(for: "0") ?? "0"),
            attributes: attributes)

        $0.attributedText = attribute
    }

    private let shipWon = UILabel().then {
        $0.text = "원"
    }

    // MARK: - 배송비 기준 알려주기
    private var freeShipMoney1 = UILabel().then {
        let shippingMoneyAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: ColorManager.General.mainPurple.rawValue
        ]

        let formatter = NumberFormatter().then {
            $0.numberStyle = .decimal    // 천 단위로 콤마(,)

            $0.minimumFractionDigits = 0    // 최소 소수점 단위
            $0.maximumFractionDigits = 0    // 최대 소수점 단위
        }

        let attributeString = NSAttributedString(
            string: (formatter.string(for: "0") ?? "0"),
            attributes: shippingMoneyAttribute
        )

        $0.attributedText = attributeString
    }

    private let freeShipMoney2 = UILabel().then {
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.text = "원 추가주문 시,"
        $0.font = .systemFont(ofSize: 12)
    }

    private let freeShipMoney3 = UILabel().then {
        $0.text = "무료배송"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = .boldSystemFont(ofSize: 12)
    }

    private let line = UIView().then {
        $0.backgroundColor = .lightGray
    }

    private let estimateSumLabel = UILabel().then {
        $0.text = "결제예정금액"
    }

    private var estimate: Int = 0
    // MARK: - 결제예정금액
    private var estimateSumCount = UILabel().then {
        let estimateMoneyAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]

        let formatter = NumberFormatter().then {
            $0.numberStyle = .decimal    // 천 단위로 콤마(,)

            $0.minimumFractionDigits = 0    // 최소 소수점 단위
            $0.maximumFractionDigits = 0    // 최대 소수점 단위
        }

        let attributeString = NSAttributedString(
            string: (formatter.string(for: "0") ?? "0"),
            attributes: estimateMoneyAttribute
        )

        $0.attributedText = attributeString
    }

    private let estimateWon = UILabel().then {
        $0.text = "원"
    }

    private let cupon = UILabel().then {
        $0.text = "* 쿠폰, 적립금은 다음화면인 '주문서'에서 확인가능합니다."
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 10)
    }

    var hide = true {
        didSet {

        }
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConfigure() {
        contentView.backgroundColor = .white
        [sumLabel, sumCount, discountLabel, discountCount, shipLabel, shipCount, line, estimateSumLabel, estimateSumCount, estimateWon, sumWon, discountWon, shipWon, cupon].forEach {
            contentView.addSubview($0)
        }
        [sumLabel, sumCount, discountLabel, discountCount, shipLabel, shipCount, estimateSumLabel, estimateSumCount, estimateWon, sumWon, discountWon, shipWon, cupon].forEach {
            $0.textColor = .black
        }

        [freeShipMoney1, freeShipMoney2, freeShipMoney3].forEach {
            contentView.addSubview($0)
            $0.textColor = ColorManager.General.mainPurple.rawValue
            $0.snp.makeConstraints {
                $0.top.equalTo(shipWon.snp.bottom).offset(8)
            }
            $0.isHidden = true
        }

        sumLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(16)
        }

        sumCount.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.top)
            $0.trailing.equalToSuperview().inset(36)
        }

        sumWon.snp.makeConstraints {
            $0.top.equalTo(sumCount.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }

        discountLabel.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        discountCount.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.top)
            $0.trailing.equalToSuperview().inset(36)
        }

        discountWon.snp.makeConstraints {
            $0.top.equalTo(discountCount.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }

        shipLabel.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        shipCount.snp.makeConstraints {
            $0.top.equalTo(shipLabel.snp.top)
            $0.trailing.equalToSuperview().inset(36)
        }

        shipWon.snp.makeConstraints {
            $0.top.equalTo(shipCount.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }

        freeShipMoney1.snp.makeConstraints {
            $0.trailing.equalTo(freeShipMoney2.snp.leading).offset(-4)
        }

        freeShipMoney3.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
        }

        freeShipMoney2.snp.makeConstraints {
            $0.trailing.equalTo(freeShipMoney3.snp.leading).offset(-4)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(freeShipMoney3.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().offset(16).inset(16)
            $0.height.equalTo(1)
        }

        estimateSumLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }

        estimateSumCount.snp.makeConstraints {
            $0.bottom.equalTo(estimateSumLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(36)
        }

        estimateWon.snp.makeConstraints {
            $0.bottom.equalTo(estimateSumCount.snp.bottom)
            $0.trailing.equalToSuperview().inset(16)
        }
        cupon.snp.makeConstraints {
            $0.top.equalTo(estimateWon.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }

    }

    func configure(sumCount: Int, allSale: Int, ship: Int) {
        var sum: NSAttributedString {
            let sumTotalPriceAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.black
            ]

            return NSMutableAttributedString(
                string: (formatter.string(for: sumCount as NSNumber) ?? "0"),
                attributes: sumTotalPriceAttributes
            )
        }

        var sale: NSAttributedString {
            let saleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.black
            ]

            return NSMutableAttributedString(
                string: "-" + (formatter.string(for: allSale as NSNumber) ?? "0"),
                attributes: saleAttributes)

        }

        var shipPrice: NSAttributedString {
            let saleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.black
            ]

            if ship < 40000 {
                return NSMutableAttributedString(
                    string: "+" + (formatter.string(for: 3000 as NSNumber) ?? "0"),
                    attributes: saleAttributes)
            } else {
                return NSMutableAttributedString(
                    string: (formatter.string(for: "0") ?? "0"),
                    attributes: saleAttributes)
            }
        }

        self.sumCount.attributedText = sum
        self.discountCount.attributedText = sale
        self.shipCount.attributedText = shipPrice

        if ship > 40000 {
            [freeShipMoney1, freeShipMoney2, freeShipMoney3].forEach {
                $0.isHidden = true
            }
        } else {
            var freeShip: NSAttributedString {
                let saleAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: ColorManager.General.mainPurple.rawValue
                ]

                return NSMutableAttributedString(
                    string: (formatter.string(for: (40000 - ship) as NSNumber) ?? "0"),
                    attributes: saleAttributes)
            }

            self.freeShipMoney1.attributedText = freeShip
        }

        estimate = sumCount - allSale
        if freeShipMoney1.isHidden {
            estimate += 0
        } else {
            estimate += 3000
        }

        var estimateCount: NSAttributedString {
            let estimateAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 24),
                .foregroundColor: UIColor.black
            ]

            return NSMutableAttributedString(
                string: (formatter.string(for: estimate as NSNumber) ?? "0"),
                attributes: estimateAttributes)
        }

        self.estimateSumCount.attributedText = estimateCount
    }
}
