//
//  OrdererInfomationHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class OrdererInfomationHeaderView: UIView {

    // MARK: - Properties

    var isShowOrdererList = false {
        didSet {
            showListButton.image = isShowOrdererList ?
                UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            ordererBasicInfoLabel.isHidden = isShowOrdererList
        }
    }

    private let ordererInfomationLabel = UILabel().then {
        $0.text = "주문자 정보*"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let ordererBasicInfoLabel = UILabel().then {
        $0.text = "천지운, 010-1234-5678"
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

        [ordererInfomationLabel, ordererBasicInfoLabel, showListButton].forEach {
            self.addSubview($0)
        }

        ordererInfomationLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        ordererBasicInfoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(ordererInfomationLabel.snp.trailing).offset(orderVCSideInsetValue)
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
