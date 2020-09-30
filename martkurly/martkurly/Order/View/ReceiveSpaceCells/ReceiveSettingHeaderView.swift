//
//  ReceiveSettingHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/30.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReceiveSettingHeaderView: UITableViewHeaderFooterView {

    // MARK: - Properties

    static let identifier = "ReceiveSettingHeaderView"

    private let headerBackgroundView = UIView()

    let productInfomationLabel = UILabel().then {
        $0.text = "상품정보"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    // MARK: - LifeCycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        headerBackgroundView.backgroundColor = .white

        [headerBackgroundView, productInfomationLabel].forEach {
            self.addSubview($0)
        }

        headerBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        productInfomationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }
    }

    func configureAttributes() {

    }
}
