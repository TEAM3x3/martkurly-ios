//
//  NoSignInTextFeild.swift
//  martkurly
//
//  Created by Kas Song on 8/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class NoSignInTextFeildView: UIView {

    // MARK: - Properties
    let textField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private let placeholder = UILabel().then {
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    private var separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private var isActive = false {
        willSet {
            configureTextFieldStatus(newValue: newValue)
        }
    }
    var text: String? { // 텍스트필드의 값을 반환
        get {
            return self.textField.text
        }
    }

    // MARK: - Lifecycle
    init(placeholder text: String) {
        super.init(frame: .zero)
        self.placeholder.text = text
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        self.textField.delegate = self
    }

    private func setConstraints() {
        [textField, placeholder, separator].forEach {
            self.addSubview($0)
        }
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(30)
        }
        placeholder.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    private func configureTextFieldStatus(newValue: Bool) {
        switch newValue {
        case true:
            self.placeholder.alpha = 0
        case false:
            self.placeholder.alpha = 1
        }
    }

}

// MARK: - UITextFieldDelegate
extension NoSignInTextFeildView: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.isActive = text?.isEmpty == true ? false : true
    }
}
