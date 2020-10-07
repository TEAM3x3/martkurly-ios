//
//  ProductInfomationCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductInfomationCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductInfomationCell"

    var data: CartItem? {
        didSet {
            configure()
        }
    }

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[은하수산] 딱새우 회 130g(냉동)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 2
    }

    private let productEachLabel = UILabel().then {
        $0.text = "수량  1개"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let productAmountPriceLabel = UILabel().then {
        $0.text = "합계  11,635원"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let underLine = UIView().then {
        $0.backgroundColor = ColorManager.General.chevronGray.rawValue
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [productImageView, underLine].forEach {
            self.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.height.equalTo(56)
            $0.width.equalTo(48)
        }

        let infoStack = UIStackView(arrangedSubviews: [productEachLabel, productAmountPriceLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4

        let amountStack = UIStackView(arrangedSubviews: [productTitleLabel, infoStack])
        amountStack.axis = .vertical
        amountStack.spacing = 12
        amountStack.alignment = .leading

        self.addSubview(amountStack)
        amountStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(productImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }

        underLine.snp.makeConstraints {
            $0.top.equalTo(amountStack.snp.bottom).offset(orderVCSideInsetValue)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.trailing.bottom.equalToSuperview().offset(-orderVCSideInsetValue)
            $0.height.equalTo(0.5)
        }
    }

    func configure() {
        guard let data = data else { return }
        let orderViewModel = OrderDataViewModel(orderItem: data)

        productImageView.kf.setImage(with: orderViewModel.imageURL)
        productTitleLabel.attributedText = orderViewModel.productTitle
        productEachLabel.attributedText = orderViewModel.productEach
        productAmountPriceLabel.attributedText = orderViewModel.productAmountPrice
    }
}
