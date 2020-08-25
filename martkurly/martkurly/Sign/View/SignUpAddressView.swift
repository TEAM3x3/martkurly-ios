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
    private let addressLabel = UILabel()
    private var quickDeliveryAvailable = true

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

    }

}
