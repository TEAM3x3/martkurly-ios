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
    private lazy var stackView = UIStackView(arrangedSubviews: [yearTextField, separator1, monthTextField, separator2, dayTextField]).then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 10
    }
    private let yearTextField = SignUpBirthdayTextFieldView(placeholder: "YYYY")
    private let monthTextField = SignUpBirthdayTextFieldView(placeholder: "MM")
    private let dayTextField = SignUpBirthdayTextFieldView(placeholder: "DD")
    private let separator1 = UILabel().then {
        $0.text = "/"
        $0.textColor = ColorManager.General.placeholder.rawValue
    }
    private let separator2 = UILabel().then {
        $0.text = "/"
        $0.textColor = ColorManager.General.placeholder.rawValue
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
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
//        [yearTextField, monthTextField, dayTextField, separator1, separator2].forEach {
//            self.addSubview($0)
        //        }
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        yearTextField.snp.makeConstraints {
            $0.width.equalTo(85)
            $0.height.equalTo(50)
        }
        monthTextField.snp.makeConstraints {
            $0.width.equalTo(yearTextField)
            $0.height.equalTo(yearTextField)
        }
        dayTextField.snp.makeConstraints {
            $0.width.equalTo(yearTextField)
            $0.height.equalTo(yearTextField)
        }
    }
}
