//
//  KurlyButton.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

// 높이는 55 로 사용할 것
class KurlyButton: UIButton {

    // MARK: - Properties

    // MARK: - Lifecycle
    init(title: String, style: ButtonStyle) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setColors(style: style)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }

    private func setConstraints() {

    }

    private func setColors(style: ButtonStyle) {
        switch style {
        case .purple:
            self.backgroundColor = ColorManager.General.mainPurple.rawValue
            self.setTitleColor(.white, for: .normal)
        case .white:
            self.backgroundColor = .white
            self.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
        }
    }

}

extension KurlyButton {

    enum ButtonStyle {
        case purple
        case white
    }

}
