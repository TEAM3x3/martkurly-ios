//
//  SameOrdererCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SameOrdererCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SameOrdererCell"

    private let sameChecker = AgreementCheckMarkView()
    private let sameTitleLabel = UILabel().then {
        $0.text = "주문자 정보와 동일"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureAttributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func tappedSameEvent() {
        sameChecker.isActive.toggle()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
            $0.height.equalTo(32)
        }

        [sameChecker, sameTitleLabel].forEach {
            view.addSubview($0)
        }

        sameChecker.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.width.height.equalTo(32)
        }

        sameTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(sameChecker.snp.trailing).offset(12)
        }

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedSameEvent))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }

    func configureAttributes() {

    }

    func configure(titleText: String) {
        sameTitleLabel.text = titleText
    }
}
