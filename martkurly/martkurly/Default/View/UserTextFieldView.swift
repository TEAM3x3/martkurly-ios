//
//  UserTextFieldView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class UserTextFieldView: UIView {

    // MARK: - Properties
    private let textField = UITextField()
    private let placeholder = UILabel().then {
        $0.textColor = ColorManager.General.placeholder.rawValue
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
    init(placeholder: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.placeholder.text = placeholder
        self.placeholder.font = UIFont.systemFont(ofSize: fontSize)
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
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorManager.General.placeholder.rawValue.cgColor
        self.layer.cornerRadius = 4

        self.textField.delegate = self
    }

    private func setConstraints() {
        [textField, placeholder].forEach {
            self.addSubview($0)
        }
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
        placeholder.snp.makeConstraints {
            $0.leading.equalTo(textField)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Helpers
    private func configureTextFieldStatus(newValue: Bool) {
        switch newValue {
        case true:
            self.placeholder.alpha = 0
        case false:
            self.placeholder.alpha = 1
        }
    }

}

extension UserTextFieldView: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.isActive = text?.isEmpty == true ? false : true
    }

}
