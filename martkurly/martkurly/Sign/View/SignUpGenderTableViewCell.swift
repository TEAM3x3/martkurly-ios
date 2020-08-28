//
//  SignUpTableViewCell.swift
//  martkurly
//
//  Created by Kas Song on 8/26/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpGenderTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "SignUpGenderTableViewCell"

    private let emptyCircle = UIView().then {
        $0.layer.cornerRadius = 25 / 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.placeholder.rawValue.cgColor
        $0.backgroundColor = .white
    }
    private let filledCircle = UIView().then {
        $0.layer.cornerRadius = 10 / 2
        $0.backgroundColor = .white
    }
    private let label = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    var isActive = false {
        willSet {
            emptyCircle.backgroundColor = newValue ? ColorManager.General.mainPurple.rawValue : .white
        }
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        self.selectionStyle = .none
        setContraints()
    }

    private func setContraints() {
        [emptyCircle, label].forEach {
            self.addSubview($0)
        }
        emptyCircle.addSubview(filledCircle)
        emptyCircle.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        filledCircle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(10)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(emptyCircle.snp.trailing).offset(12)
            $0.centerY.equalTo(emptyCircle)
        }
    }

    // MARK: - Helpers
    func configureCell(title text: String) {
        self.label.text = text
    }

}
