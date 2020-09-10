//
//  ProductExplainImageCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainImageCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainImageCell"

    private let defaultPaddingValue: CGFloat = 20
    private let defaultBottomPaddingValue: CGFloat = 80

    private let belowTouchExpandButton = BelowTouchExpandButton()
    let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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

        [belowTouchExpandButton, productImageView].forEach {
            self.addSubview($0)
        }

        belowTouchExpandButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
            $0.height.equalTo(56)
        }
        belowTouchExpandButton.layer.cornerRadius = 56 / 2

        productImageView.snp.makeConstraints {
            $0.top.equalTo(belowTouchExpandButton.snp.bottom).offset(defaultPaddingValue)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-defaultBottomPaddingValue)
            $0.height.equalTo(500)
        }
    }
}
