//
//  SingUpBirthdayView.swift
//  martkurly
//
//  Created by Kas Song on 8/25/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SingUpBirthdayView: UIView {

    // MARK: - Properties
    private let title = SignUpTextFieldTitleView(title: StringManager.SignUp.birthday.rawValue, mendatory: false)
    private let yearTextField = UITextField()
    private let monthTextField = UITextField()
    private let dayTextField = UITextField()
    private let separator1 = UILabel()
    private let separator2 = UILabel()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorManager.General.placeholder.rawValue.cgColor
        self.layer.cornerRadius = 4
    }

    private func setContraints() {

    }
}
