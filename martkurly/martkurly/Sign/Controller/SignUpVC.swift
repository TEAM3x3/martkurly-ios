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
    private let separtor = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .gray
    }
    let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    private var textFields = [UserTextFieldView]() // 아이디, 비밀번호, 비밀번호 확인, 이름, 이메일 순서로 들어있음
    private let idCheckButton = KurlyButton(title: StringManager.SignUp.checkDuplicate.rawValue, style: .white)
    private let phoneNumberCheckButton = KurlyButton(title: StringManager.SignUp.checkPhoneNumber.rawValue, style: .white)
    private let addressView = SignUpAddressView()
    private let birthdayTextField = UITextField()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
    }

    // MARK: - UI
    private func configureUI() {
        setScrollView()
        generateTextFields()
        setConstraints()
    }

    private func setConstraints() {
        guard
            let idTextField = textFields.first,
            let phoneNumberTextField = textFields.last
            else { return }
        idCheckButton.snp.makeConstraints {
            $0.trailing.equalTo(view).inset(20)
            $0.centerY.equalTo(idTextField)
            $0.height.equalTo(48)
            $0.width.equalTo(92)
        }
        phoneNumberCheckButton.snp.makeConstraints {
            $0.trailing.equalTo(view).inset(20)
            $0.centerY.equalTo(phoneNumberTextField)
            $0.height.equalTo(48)
            $0.width.equalTo(120)
        }
        addressView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(150)
        }
    }

    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(view.frame.width)
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(view.frame.height * 2)
            $0.width.equalTo(view)
        }
        [idCheckButton, phoneNumberCheckButton, addressView].forEach {
            contentView.addSubview($0)
        }
    }

    private func generateTextFields() {
        for info in StringManager().signUpTextFieldsInfo {
            guard let title = info.keys.first,
                let placeHolder = info[title]
                else { return }
            let titleLabel = SignUpTextFieldTitleView(title: title, mendatory: true)
            let textField = UserTextFieldView(placeholder: placeHolder, fontSize: 14)

            [titleLabel, textField].forEach {
                contentView.addSubview($0)
            }

            if textFields.isEmpty == true {
                titleLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(4)
                    $0.leading.trailing.equalTo(view).inset(20)
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
                    $0.leading.trailing.equalTo(view).inset(20)
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
                    $0.leading.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(48)
                }
            }
            textFields.append(textField)
        }
    }
}
