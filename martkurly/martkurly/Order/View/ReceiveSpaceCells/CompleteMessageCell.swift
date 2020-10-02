//
//  CompleteMessageCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CompleteMessageCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "CompleteMessageCell"

    private var selectedLeft: Bool = true {
        didSet {
            deliveryAfterCheckButton.isActive = selectedLeft
            sevenAMCheckButton.isActive = !selectedLeft
        }
    }

    private let deliveryAfterCheckButton = KurlyChecker()
    private let deliveryAfterLabel = UILabel().then {
        $0.text = "배송 직후"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let deliveryAfterView = UIView()

    private let sevenAMCheckButton = KurlyChecker()
    private let sevenAMCheckButtonLabel = UILabel().then {
        $0.text = "오전 7시"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let sevenAMCheckButtonView = UIView()

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
    func tappedEvent(_ sender: UITapGestureRecognizer) {
        guard let index = Int(sender.name ?? "0") else { return }
        if index == 0 { selectedLeft = true } else { selectedLeft = false }
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [deliveryAfterCheckButton, deliveryAfterLabel].forEach {
            deliveryAfterView.addSubview($0)
        }

        [sevenAMCheckButton, sevenAMCheckButtonLabel].forEach {
            sevenAMCheckButtonView.addSubview($0)
        }

        deliveryAfterCheckButton.snp.remakeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        deliveryAfterLabel.snp.remakeConstraints {
            $0.leading.equalTo(deliveryAfterCheckButton.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        sevenAMCheckButton.snp.remakeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        sevenAMCheckButtonLabel.snp.remakeConstraints {
            $0.leading.equalTo(sevenAMCheckButton.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        [deliveryAfterView, sevenAMCheckButtonView].forEach {
            self.addSubview($0)
        }

        deliveryAfterView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(orderVCSideInsetValue)
        }

        sevenAMCheckButtonView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(self.snp.centerX).inset(orderVCSideInsetValue)
        }
    }

    func configureAttributes() {
        deliveryAfterCheckButton.isActive = true

        [deliveryAfterView, sevenAMCheckButtonView].enumerated().forEach {
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(tappedEvent(_:)))
            tapGesture.name = "\($0.offset)"
            $0.element.addGestureRecognizer(tapGesture)
            $0.element.isUserInteractionEnabled = true
        }
    }
}
