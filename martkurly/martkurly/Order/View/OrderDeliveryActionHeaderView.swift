//
//  OrderDeliveryActionHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrderDeliveryActionHeaderView: UIView {

    // MARK: - Properties

    var isShowActionList = false {
        didSet {
            showListButton.image = isShowActionList ?
                UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            actionContentsLabel.isHidden = isShowActionList
        }
    }

    private let actionTitleLabel = UILabel().then {
        $0.text = "상품 미배송 시 조치*"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let actionContentsLabel = UILabel().then {
        $0.text = "결제수단으로 환불"
        $0.textColor = .black
        $0.textAlignment = .right
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

        [actionTitleLabel, actionContentsLabel, showListButton].forEach {
            self.addSubview($0)
        }

        actionTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        actionContentsLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(actionTitleLabel.snp.trailing).offset(orderVCSideInsetValue)
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
