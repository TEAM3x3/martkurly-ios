//
//  ProductDetailHappinessCenterCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/31.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductDetailHappinessCenterCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductDetailHappinessCenterCell"

    private let topLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let happinessCenterView = HappinessCenterView()

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
        configureLayout()
    }

    func configureLayout() {
        [topLine, happinessCenterView].forEach {
            self.addSubview($0)
        }

        topLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }

        happinessCenterView.snp.makeConstraints {
            $0.top.equalTo(topLine.snp.bottom).offset(44)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(728)
        }
    }
}
