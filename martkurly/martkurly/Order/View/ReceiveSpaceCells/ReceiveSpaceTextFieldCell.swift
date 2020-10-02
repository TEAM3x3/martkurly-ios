//
//  ReceiveSpaceTextFieldCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReceiveSpaceTextFieldCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ReceiveSpaceTextFieldCell"

    var textData: String? {
        return inputTextField.text
    }

    private let inputTextField = UITextField().then {
        $0.placeholder = "택배함 위치 / 택배함 번호, 비밀번호"
        $0.font = .systemFont(ofSize: 16)
        $0.borderStyle = .none
    }

    private lazy var inputCustomView = UIView().then {
        $0.addSubview(inputTextField)
        inputTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(orderVCSideInsetValue).priority(999)
        }

        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.backGray.rawValue.cgColor
    }

    private let spaceContentsLabel = UILabel().then {
        $0.text = "지정되지 않은 택배함은 위치만 적어주세요. 배송 완료 후 택배함 번호와 비밀번호를 알려드려요."
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
        $0.numberOfLines = 0
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [inputCustomView, spaceContentsLabel].forEach {
            self.addSubview($0)
        }

        inputCustomView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }

        spaceContentsLabel.snp.makeConstraints {
            $0.top.equalTo(inputCustomView.snp.bottom).offset(8)
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }
    }
}
