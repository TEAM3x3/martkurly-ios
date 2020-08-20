//
//  SignInVC.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    // MARK: - Properties
    private lazy var topBar = CustomNavigationBarView(title: StringManager.Sign.login.rawValue, viewController: self)
    private let idTextField = UserTextFieldView(placeholder: StringManager.Sign.idTextField.rawValue, fontSize: 15)
    private let pwTextField = UserTextFieldView(placeholder: StringManager.Sign.pwTextField.rawValue, fontSize: 15)
    private let loginButton = KurlyButton(title: StringManager.Sign.login.rawValue, style: .purple)

    private let forgotIDButton = UIButton().then {
        $0.setTitle(StringManager.Sign.forgotID.rawValue, for: .normal)
        $0.setTitleColor(ColorManager.General.mainGray.rawValue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    private let forgotPWButton = UIButton().then {
        $0.setTitle(StringManager.Sign.forgotPW.rawValue, for: .normal)
        $0.setTitleColor(ColorManager.General.mainGray.rawValue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    private let verticalSeparator = UIView().then {
        $0.backgroundColor = ColorManager.General.mainGray.rawValue
    }

    private let signUpButton = KurlyButton(title: StringManager.Sign.signUp.rawValue, style: .white)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }

    private func setPropertyAttributes() {
        [forgotIDButton, forgotPWButton].forEach {
            $0.addTarget(self, action: #selector(handleButtons(_:)), for: .touchUpInside)
        }
    }

    private func setConstraints() {
        [topBar, idTextField, pwTextField, loginButton, verticalSeparator, forgotIDButton, forgotPWButton, signUpButton].forEach {
            view.addSubview($0)
        }
        topBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
        verticalSeparator.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        forgotIDButton.snp.makeConstraints {
            $0.trailing.equalTo(verticalSeparator.snp.leading).offset(-10)
            $0.centerY.equalTo(verticalSeparator)
        }
        forgotPWButton.snp.makeConstraints {
            $0.leading.equalTo(verticalSeparator.snp.trailing).offset(10)
            $0.centerY.equalTo(verticalSeparator)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(verticalSeparator.snp.bottom).offset(52)
            $0.leading.trailing.equalTo(idTextField)
            $0.height.equalTo(idTextField)
        }
    }

    // MARK: - Selectors
    @objc
    private func handleButtons(_ sender: UIButton) {
        switch sender {
        case forgotIDButton:
            let nextVC = ForgotIDVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case forgotPWButton:
            let nextVC = ForgotPWVC()
            navigationController?.pushViewController(nextVC, animated: true)
        default:
            return
        }
    }
}
