//
//  SignUpAddressView.swift
//  martkurly
//
//  Created by Kas Song on 8/25/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpAddressView: UIView {

    // MARK: - Properties
    private let textFieldTitle = SignUpTextFieldTitleView(title: StringManager.SignUp.address.rawValue, mendatory: true)
    let addressLabel = SignUpAddressInputView()
    private let specificAddress = UserTextFieldView(placeholder: StringManager.SignUp.addtionalAddress.rawValue, fontSize: 16)
    private let infoLabel = UILabel().then {
        $0.text = StringManager.SignUp.addtionalAddressInfo.rawValue
        $0.textColor = ColorManager.General.placeholder.rawValue
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    var quickDeliveryAvailable = false {
        willSet {
            updateConstraints(newValue: newValue)
            addressLabel.setQuickDeleveryAvailable()
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    private func configureUI() {
        setConstraints()
    }

    private func setConstraints() {
        [textFieldTitle, addressLabel, infoLabel].forEach {
            self.addSubview($0)
        }
        textFieldTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(textFieldTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
    }

    // MARK: - Helpers
    private func updateConstraints(newValue: Bool) {
        switch newValue {
        case true:
            self.addSubview(specificAddress)
            addressLabel.snp.updateConstraints {
                $0.top.equalTo(textFieldTitle.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(72)
            }
            specificAddress.snp.makeConstraints {
                $0.top.equalTo(addressLabel.snp.bottom).offset(12)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(48)
            }
            infoLabel.snp.removeConstraints()
            infoLabel.snp.makeConstraints {
                $0.top.equalTo(specificAddress.snp.bottom).offset(8)
                $0.leading.equalToSuperview()
            }
        case false:
            break
        }
    }
}
