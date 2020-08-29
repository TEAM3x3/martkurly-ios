//
//  BelowTouchExpandButton.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class BelowTouchExpandButton: UIView {

    // MARK: - Properties

    private let buttonTitleLabel = UILabel().then {
        $0.text = "아래 이미지를 터치하면 확대해서 볼 수 있습니다."
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
    }

    private let buttonImageView = UIImageView().then {
        $0.image = UIImage(systemName: "hand.draw")
        $0.tintColor = ColorManager.General.chevronGray.rawValue

        $0.snp.makeConstraints {
            $0.width.height.equalTo(44)
        }
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue

        let stack = UIStackView(arrangedSubviews: [buttonTitleLabel, buttonImageView])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center

        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
