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
    private let textField = UITextField().then {
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    private let placeholder = UILabel().then {
        $0.textColor = ColorManager.General.placeholder.rawValue
        $0.font = UIFont.systemFont(ofSize: 16)
    }

    private var maxCount: Int?

    // MARK: - Lifecycle
    init(placeholder: String, maxCount: Int) {
        super.init(frame: .zero)
        self.placeholder.text = placeholder
        self.maxCount = maxCount
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
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        textField.delegate = self
    }

    private func setContraints() {
        [textField, placeholder].forEach {
            self.addSubview($0)
        }
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        placeholder.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    // MARK: - Helpers
    private func hidePlaceholder(textField: UITextField, count: Int) {
        switch count {
        case 0:
            placeholder.isHidden = false
        default:
            placeholder.isHidden = true
        }
    }
}

extension SignUpBirthdayTextFieldView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        hidePlaceholder(textField: textField, count: textField.text!.count)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard let maxCount = maxCount else { return false }
        let count = textField.text?.count ?? 0
        guard count < maxCount else { return false }
        return true
    }
}
