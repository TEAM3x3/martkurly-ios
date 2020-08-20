//
//  IncorrectInputWarningView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class IncorrectInputWarningView: UIView {

    // MARK: - Properties
    let title = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }

    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        self.title.text = title
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
        self.layer.cornerRadius = 8
        self.backgroundColor = .warningPink
    }

    private func setConstraints() {
        self.addSubview(title)
        self.title.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Helpers
    func setText(text: String) {
        title.text = text
    }
}
