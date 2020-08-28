//
//  SignUpBirthdayTextFieldView.swift
//  martkurly
//
//  Created by Kas Song on 8/26/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpBirthdayTextFieldView: UIView {

    // MARK: - Properties
    private let textFeild = UITextField().then {
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    private let placeholder = UILabel().then {
        $0.textColor = ColorManager.General.placeholder.rawValue
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    // MARK: - Lifecycle
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder.text = placeholder
        configureUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {
        [textFeild, placeholder].forEach {
            self.addSubview($0)
        }
        textFeild.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        placeholder.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
