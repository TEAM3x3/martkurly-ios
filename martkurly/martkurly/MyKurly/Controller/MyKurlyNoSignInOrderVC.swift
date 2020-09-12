//
//  MyKurlyNoSignInOrderVC.swift
//  martkurly
//
//  Created by Kas Song on 8/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyNoSignInOrderVC: UIViewController {

    // MARK: - Properties
    private let nameTextField = NoSignInTextFeildView(placeholder: StringManager.MyKurly.nameOfOrderer.rawValue)
    private let orderNumberTextField = NoSignInTextFeildView(placeholder: StringManager.MyKurly.orderNumber.rawValue)
    private let checkButton = KurlyButton(title: StringManager.MyKurly.checkOrderStatus.rawValue, style: .purple)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurly.noSignInOrders.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
        setAttributes()
    }

    private func setAttributes() {
        checkButton.addTarget(self, action: #selector(handleCheckButton(_:)), for: .touchUpInside)
    }

    private func setContraints() {
        [nameTextField, orderNumberTextField, checkButton].forEach {
            view.addSubview($0)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(38)
        }
        orderNumberTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(38)
        }
        checkButton.snp.makeConstraints {
            $0.top.equalTo(orderNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    // MARK: - Selectors
    @objc
    private func handleCheckButton(_ sender: UIButton) {
        print(#function)
    }
}
