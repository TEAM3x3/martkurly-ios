//
//  RegisterInputCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RegisterInputCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RegisterInputCell"

    var inputTextData: String? {
        set {
            inputTextField.text = newValue
        }
        get {
            return inputTextField.text
        }
    }

    private let titleLabel = UILabel().then {
        $0.text = "받는 분 이름*"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let inputTextField = UITextField().then {
        $0.placeholder = "이름을 입력해 주세요"
        $0.font = .systemFont(ofSize: 16)
        $0.borderStyle = .none
    }

    private lazy var inputCustomView = UIView().then {
        $0.addSubview(inputTextField)
        inputTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(orderVCSideInsetValue)
        }

        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.backGray.rawValue.cgColor
    }

    private let textCountLabel = UILabel().then {
        $0.text = "0자 / 99자"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func changedTextField(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 99 {
            sender.text?.removeLast()
            return
        }
        textCountLabel.text = "\(sender.text?.count ?? 0)자 / 99자"
    }

    // MARK: - Helpers

    func configureUI() {
        configureAttributes()
        self.backgroundColor = .white

        [titleLabel, inputCustomView, textCountLabel].forEach {
            self.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
        }

        inputCustomView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }

        textCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(inputCustomView.snp.top).offset(-4)
            $0.trailing.equalTo(inputCustomView)
        }
    }

    func configureAttributes() {
        inputTextField.addTarget(self,
                                 action: #selector(changedTextField),
                                 for: .editingChanged)
    }

    func configure(titleText: String,
                   placeHolderText: String,
                   isShowCount: Bool,
                   keyboardType: UIKeyboardType) {
        titleLabel.text = titleText
        inputTextField.placeholder = placeHolderText
        inputTextField.keyboardType = keyboardType
        textCountLabel.isHidden = !isShowCount
    }
}
