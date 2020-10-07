//
//  OrderProductInfomationHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderProductInfomationHeaderView: UIView {

    // MARK: - Properties

    var isShowProductList = false {
        didSet {
            showListButton.image = isShowProductList ?
                UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            productTitleLabel.isHidden = isShowProductList
            productCountLabel.isHidden = isShowProductList
        }
    }

    private let productInfomationLabel = UILabel().then {
        $0.text = "상품정보"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[은하수산] 딱새우 회 130g(냉동)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let productCountLabel = UILabel().then {
        $0.text = "외 2건"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
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

        [productInfomationLabel, productTitleLabel, productCountLabel, showListButton].forEach {
            self.addSubview($0)
        }

        productInfomationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        productTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(productInfomationLabel.snp.trailing).offset(60)
            $0.trailing.equalTo(productCountLabel.snp.leading).offset(-8)
        }

        productCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(40)
            $0.trailing.equalTo(showListButton.snp.leading).offset(-8)
        }

        showListButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-orderVCSideInsetValue)
        }
    }

    func configureAttributes() {

    }
}
