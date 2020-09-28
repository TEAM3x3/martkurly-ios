//
//  KurlyChecker.swift
//  martkurly
//
//  Created by Kas Song on 9/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class KurlyChecker: UIView {

    // MARK: - Properties
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
    var isActive = false {
        willSet {
            emptyCircle.backgroundColor = newValue ? ColorManager.General.mainPurple.rawValue : .white
        }
    }

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
        setContraints()
    }

    private func setContraints() {
        [emptyCircle].forEach {
            self.addSubview($0)
        }
        emptyCircle.addSubview(filledCircle)
        emptyCircle.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        filledCircle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(10)
        }

    }
}
