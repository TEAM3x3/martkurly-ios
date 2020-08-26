//
//  SignUpTableViewCell.swift
//  martkurly
//
//  Created by Kas Song on 8/26/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {

    // MARK: - Properties
    private let emptyCircle = UIView()
    private let filledCircle = UIView()
    private let label = UILabel()

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
        setContraints()
    }

    private func setContraints() {

    }

}
