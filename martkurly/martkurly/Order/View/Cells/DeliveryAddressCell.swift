//
//  DeliveryAddressCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DeliveryAddressCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "DeliveryAddressCell"

    let selectButton = KurlyChecker()

    var userAddress: AddressModel? {
        didSet { configure() }
    }

    private let deliveryStatusTextView = HalfCircleTextView().then {
        $0.configure(text: "샛별배송",
                     textColor: ColorManager.General.mainPurple.rawValue,
                     backgroundColor: .white,
                     borderColor: ColorManager.General.mainPurple.rawValue)
    }

    private let defaultDeliveryTextView = HalfCircleTextView().then {
        $0.configure(text: "기본배송지",
                     textColor: ColorManager.General.mainPurple.rawValue,
                     backgroundColor: UIColor(red: 239, green: 229, blue: 239),
                     borderColor: .clear)
    }

    private let addressTextLabel = UILabel().then {
        $0.text = "경기 시흥시 대야동 1234, 패스트캠퍼스 123동 456호 [12345]"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 4)
    }

    private let receivePlaceLabel = UILabel().then {
        $0.text = "받으실 장소: 문 앞(출입방법: 공동현관 비밀번호)"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
    }

    private let ordererInfoLabel = UILabel().then {
        $0.text = "홍길동, 010-6698-2508"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
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

        [selectButton, deliveryStatusTextView, defaultDeliveryTextView, addressTextLabel].forEach {
            self.addSubview($0)
        }

        selectButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        deliveryStatusTextView.snp.makeConstraints {
            $0.centerY.equalTo(selectButton)
            $0.leading.equalTo(selectButton.snp.trailing).offset(12)
        }

        defaultDeliveryTextView.snp.makeConstraints {
            $0.centerY.equalTo(selectButton)
            $0.leading.equalTo(deliveryStatusTextView.snp.trailing).offset(4)
        }

        addressTextLabel.snp.makeConstraints {
            $0.top.equalTo(selectButton.snp.bottom).offset(12)
            $0.leading.equalTo(deliveryStatusTextView)
            $0.trailing.equalToSuperview().inset(28)
        }

        let stack = UIStackView(arrangedSubviews: [
            receivePlaceLabel, ordererInfoLabel
        ])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading

        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(addressTextLabel.snp.bottom).offset(12)
            $0.leading.equalTo(deliveryStatusTextView)
            $0.trailing.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }

    func configure() {
        guard let userAddress = userAddress else { return }
        let viewModel = AddressViewModel(address: userAddress)

        addressTextLabel.text = viewModel.totalAddressText
        if viewModel.isStarsDelivery {
            deliveryStatusTextView.configure(
                text: "샛별배송",
                textColor: ColorManager.General.mainPurple.rawValue,
                backgroundColor: .white,
                borderColor: ColorManager.General.mainPurple.rawValue)
        } else {
            deliveryStatusTextView.configure(
                text: "택배배송",
                textColor: UIColor.lightGray,
                backgroundColor: .white,
                borderColor: UIColor.lightGray)
        }

        defaultDeliveryTextView.isHidden = !viewModel.isDefaultDelivery
        ordererInfoLabel.text = viewModel.userDataText
        receivePlaceLabel.text = viewModel.receiveSpace
    }
}
