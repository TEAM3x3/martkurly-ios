//
//  MyKurlyFrequentlyBuyingProductsTableViewCell.swift
//  martkurly
//
//  Created by Kas Song on 9/5/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyFrequentlyBuyingProductsTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MyKurlyFrequentlyBuyingProductsTableViewCell"

    private let productNameLabel = UILabel().then {
        $0.text = "제품명"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    private let rightAccessoryImageView = UIImageView().then {
        let image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        $0.image = image
    }
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private let productImageView = UIImageView().then {
        $0.backgroundColor = .backgroundGray
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let priceTitleLabel = UILabel().then {
        $0.text = "판매가"
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 14.5, weight: .regular)
    }
    private let priceLabel = UILabel().then {
        $0.text = "4,900원"
        $0.font = UIFont.systemFont(ofSize: 14.5, weight: .regular)
    }
    private let numberOfPurchasesTitleLabel = UILabel().then {
        $0.text = "구매 횟수"
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 14.5, weight: .regular)
    }
    private let numberOfPurchasesLabel = UILabel().then {
        $0.text = "1회"
        $0.font = UIFont.systemFont(ofSize: 14.5, weight: .regular)
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {
        [productNameLabel, rightAccessoryImageView, separator, productImageView, priceTitleLabel, priceLabel, numberOfPurchasesTitleLabel, numberOfPurchasesLabel].forEach {
            self.addSubview($0)
        }
        productNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        rightAccessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(productNameLabel)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        productImageView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(20)
            $0.leading.equalTo(productNameLabel)
            $0.width.equalTo(55)
            $0.height.equalTo(60)
        }
        priceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView).offset(2)
            $0.leading.equalTo(productImageView.snp.trailing).offset(20)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(priceTitleLabel.snp.trailing).offset(35)
            $0.centerY.equalTo(priceTitleLabel)
        }
        numberOfPurchasesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(priceTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(priceTitleLabel)
        }
        numberOfPurchasesLabel.snp.makeConstraints {
            $0.centerY.equalTo(numberOfPurchasesTitleLabel)
            $0.leading.equalTo(priceLabel)
        }
    }
}
