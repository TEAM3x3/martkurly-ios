//
//  ProductExplainBuyButtonCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainBuyButtonCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainBuyButton"

    private let defaultPaddingValue: CGFloat = 12

    private let buyButton = KurlyButton(title: "구매하기", style: .purple)

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
        self.backgroundColor = .clear

        self.addSubview(buyButton)
        buyButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.bottom.trailing.equalToSuperview().offset(-defaultPaddingValue)
            $0.height.equalTo(52)
        }
    }
}
