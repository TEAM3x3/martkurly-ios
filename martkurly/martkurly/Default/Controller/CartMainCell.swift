//
//  CartMainCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CartMainCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "CartMainCell"

    private var cartView = CartView()

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
        [cartView].forEach {
            contentView.addSubview($0)
        }

        cartView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(contentView)
        }
    }

    func configure(data: [Cart]) {
        cartView.cartData = data
    }
}
