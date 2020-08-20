//
//  ForgotPWVC.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ForgotPWVC: UIViewController {

    // MARK: - Properties
    private let nameTextField = UserTextFieldView(placeholder: StringManager.Sign.nameTextField.rawValue, fontSize: 15)
    private let idTextField = UserTextFieldView(placeholder: StringManager.Sign.idTextField.rawValue, fontSize: 15)
    private let emailTextField = UserTextFieldView(placeholder: StringManager.Sign.emailTextField.rawValue, fontSize: 15)
    private let confirmButton = KurlyButton(title: StringManager.Sign.confirm.rawValue, style: .purple)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setNavigationBarStatus(type: .whiteType, isShowCart: false, isShowBack: true, titleText: StringManager.Sign.forgotPW.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        confirmButton.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
    }

    private func setConstraints() {
        [nameTextField, idTextField, emailTextField, confirmButton].forEach {
            view.addSubview($0)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(35)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(nameTextField)
            $0.height.equalTo(nameTextField)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(nameTextField)
            $0.height.equalTo(nameTextField)
        }
    }

    // MARK: - Selectors
    @objc
    private func handleConfirmButton() {
        print(#function)
    }

}
