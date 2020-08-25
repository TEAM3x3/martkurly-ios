//
//  SignUpVC.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: - Properties
    private var textFields = [UserTextFieldView]() // 아이디, 비밀번호, 비밀번호 확인, 이름, 이메일 순서로 들어있음
    private let idCheckButton = KurlyButton(title: StringManager.SignUp.checkDuplicate.rawValue, style: .white)
    private let phoneNumberCheckButton = KurlyButton(title: StringManager.SignUp.checkPhoneNumber.rawValue, style: .white)
    private let addressTitleView = SignUpTextFieldTitleView(title: StringManager.SignUp.address.rawValue, mendatory: true)
    private let addressTextField = UITextField()
    private let birthdayTextField = UITextField()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setNavigationBarStatus(type: .whiteType,
                               isShowCart: false,
                               leftBarbuttonStyle: .pop,
                               titleText: StringManager.Sign.signUp.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        generateTextFields()
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {}

    private func setConstraints() {
        guard
            let idTextField = textFields.first,
            let phoneNumberTextField = textFields.last
            else { return }
        idCheckButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(idTextField)
            $0.height.equalTo(48)
            $0.width.equalTo(92)
        }
        phoneNumberCheckButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(phoneNumberTextField)
            $0.height.equalTo(48)
            $0.width.equalTo(120)
        }
    }

    private func generateTextFields() {
        [idCheckButton, phoneNumberCheckButton].forEach {
            view.addSubview($0)
        }
        for info in StringManager().signUpTextFieldsInfo {
            guard let title = info.keys.first,
                let placeHolder = info[title]
                else { return }
            let titleLabel = SignUpTextFieldTitleView(title: title, mendatory: true)
            let textField = UserTextFieldView(placeholder: placeHolder, fontSize: 14)

            [titleLabel, textField].forEach {
                view.addSubview($0)
            }

            if textFields.isEmpty == true {
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(view.safeAreaLayoutGuide)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalToSuperview().inset(20)
                    $0.trailing.equalTo(idCheckButton.snp.leading).offset(-10)
                    $0.height.equalTo(48)
                }
            } else if textFields.count == 5 {
                // 휴대폰 입력 텍스트필드
                guard
                    let firstObject = textFields.first,
                    let lastObject = textFields.last else { return }
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(lastObject.snp.bottom).offset(8)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalTo(phoneNumberCheckButton.snp.leading).offset(-10)
                    $0.height.equalTo(48)
                }
            } else {
                guard
                    let firstObject = textFields.first,
                    let lastObject = textFields.last else { return }
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(lastObject.snp.bottom).offset(8)
                    $0.leading.trailing.equalToSuperview().inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalToSuperview().inset(20)
                    $0.height.equalTo(48)
                }
            }
            textFields.append(textField)
        }
    }

}
