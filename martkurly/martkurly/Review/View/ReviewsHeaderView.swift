//
//  ReviewsHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewsHeaderView: UIView {

    // MARK: - Properties

    private let sideInsetValue: CGFloat = 8
    private let lineInsetValue: CGFloat = 4

    private let orderTitleLabel = UILabel().then {
        $0.text = "주문번호"
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 12)
    }

    private let orderNumberLabel = UILabel().then {
        $0.text = "1597994321049"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let completeDateLabel = UILabel().then {
        $0.text = "08월 22일 배송완료"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
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
        self.backgroundColor = .clear

        [orderTitleLabel, orderNumberLabel, completeDateLabel].forEach {
            self.addSubview($0)
        }

        orderTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
        }

        orderNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(orderTitleLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(orderTitleLabel)
        }

        completeDateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.centerY.equalTo(orderTitleLabel)
        }
    }

    func configureAttributes() {

    }
}
