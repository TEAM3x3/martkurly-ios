//
//  DoorFrontUsageCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DoorFrontUsageCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "DoorFrontUsageCell"

    private let checkButton = KurlyChecker()
    private let spaceTitleLabel = UILabel().then {
        $0.text = "테스트"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let inputTextField = UITextField().then {
        $0.placeholder = "예: #1234*"
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

        [checkButton, spaceTitleLabel].forEach {
            self.addSubview($0)
        }
    }

    func configure(titleText: String?,
                   isActive: Bool,
                   type: DoorFrontUsage,
                   placeHolder: String? = nil) {
        spaceTitleLabel.text = titleText
        checkButton.isActive = isActive
        inputTextField.placeholder = placeHolder
        inputCustomView.isHidden = true

        [checkButton, spaceTitleLabel, inputCustomView].forEach {
            $0.snp.removeConstraints()
        }

        if isActive {
            switch type {
            case .commonDoor: fallthrough
            case .theOthers:
                checkButton.snp.remakeConstraints {
                    $0.leading.equalToSuperview().inset(orderVCSideInsetValue)
                    $0.top.equalToSuperview().inset(12)
                }

                spaceTitleLabel.snp.remakeConstraints {
                    $0.leading.equalTo(checkButton.snp.trailing).offset(12)
                    $0.centerY.equalTo(checkButton)
                }

                inputCustomView.isHidden = false
                self.addSubview(inputCustomView)
                inputCustomView.snp.remakeConstraints {
                    $0.top.equalTo(checkButton.snp.bottom).offset(12)
                    $0.leading.trailing.equalToSuperview().inset(orderVCSideInsetValue)
                    $0.bottom.equalToSuperview().inset(12).priority(999)
                }
            case .enterFree:
                basicLayoutSetup()
            }
        } else {
            basicLayoutSetup()
        }
    }

    func basicLayoutSetup() {
        checkButton.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(orderVCSideInsetValue)
            $0.top.bottom.equalToSuperview().inset(12).priority(999)
        }

        spaceTitleLabel.snp.remakeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(12)
            $0.centerY.equalTo(checkButton)
        }
    }
}
