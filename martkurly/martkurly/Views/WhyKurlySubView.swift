//
//  WhyKurlySubView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class WhyKurlySubView: UIView {

    // MARK: - Properties
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {

    }

    private func setConstraints() {

    }

}
