//
//  ProductExplainWhyCurlyCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainWhyCurlyCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainWhyCurlyCell"

    private let defaultPaddingValue: CGFloat = 20

    private let whyKurlyView = WhyKurlyView()

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

        self.addSubview(whyKurlyView)
        whyKurlyView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.bottom.equalToSuperview().offset(-defaultPaddingValue)
            $0.height.equalTo(800)
        }
    }
}
