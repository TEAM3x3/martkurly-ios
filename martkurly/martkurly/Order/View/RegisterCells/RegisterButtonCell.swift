//
//  RegisterButtonCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

enum DeliveryStatusType {
    case fastArea
    case basicArea
}

class RegisterButtonCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RegisterButtonCell"

    var tappedEvent: ((RegisterButtonCell) -> Void)?

    private let titleLabel = UILabel().then {
        $0.text = "받는 분 이름*"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)

    }

    private let deliveryStatusTextView = HalfCircleTextView().then {
        $0.configure(text: "샛별배송",
                     textColor: ColorManager.General.mainPurple.rawValue,
                     backgroundColor: .white,
                     borderColor: ColorManager.General.mainPurple.rawValue)
        $0.isHidden = true
    }

    private let inputTextField = UITextField().then {
        $0.placeholder = "이름을 입력해 주세요"
        $0.font = .systemFont(ofSize: 16)
        $0.borderStyle = .none
        $0.isEnabled = false
    }

    private lazy var inputCustomView = UIView().then {
        $0.addSubview(inputTextField)
        $0.addSubview(deliveryStatusTextView)
        inputTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(orderVCSideInsetValue)
        }

        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.backGray.rawValue.cgColor

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedTapEvent))
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
    }

    private let cellImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .black
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

    // MARK: - Selectors

    @objc
    func tappedTapEvent() {
        tappedEvent?(self)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [titleLabel, inputCustomView, cellImageView].forEach {
            self.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        inputCustomView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }

        cellImageView.snp.makeConstraints {
            $0.centerY.equalTo(inputCustomView)
            $0.trailing.equalTo(inputCustomView).offset(-12)
            $0.width.height.equalTo(20)
        }
    }

    func configure(titleText: String,
                   placeHolderText: String,
                   imageName: String) {
        titleLabel.text = titleText
        inputTextField.placeholder = placeHolderText
        cellImageView.image = UIImage(systemName: imageName)

        deliveryStatusTextView.isHidden =  true
        inputTextField.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(orderVCSideInsetValue)
        }
    }

    func configureDelivery(addressText: String,
                           deliveryType: DeliveryStatusType) {
        inputTextField.text = addressText

        if deliveryType == .basicArea {
            deliveryStatusTextView.configure(text: "택배배송",
                                             textColor: ColorManager.General.chevronGray.rawValue,
                                             backgroundColor: .white,
                                             borderColor: ColorManager.General.chevronGray.rawValue)
        } else {
            deliveryStatusTextView.configure(text: "샛별배송",
                                             textColor: ColorManager.General.mainPurple.rawValue,
                                             backgroundColor: .white,
                                             borderColor: ColorManager.General.mainPurple.rawValue)
        }

        deliveryStatusTextView.isHidden = false
        deliveryStatusTextView.snp.remakeConstraints {
            $0.top.leading.equalToSuperview().inset(orderVCSideInsetValue)
        }

        inputTextField.snp.remakeConstraints {
            $0.top.equalTo(deliveryStatusTextView.snp.bottom).offset(16)
            $0.leading.bottom.equalToSuperview().inset(orderVCSideInsetValue)
            $0.trailing.equalTo(cellImageView.snp.leading).offset(-4)
        }
    }

    func configureReceiveSpace(titleText: String) {
        inputTextField.text = titleText
    }
}
