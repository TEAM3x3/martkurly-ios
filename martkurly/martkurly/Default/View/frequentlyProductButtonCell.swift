//
//  frequentlyProductButtonCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/22.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class frequentlyProductButtonCell: UIButton {

    // MARK: - Properties
    private let title = UILabel().then {
        $0.text = "자주 사는 상품"
        $0.textColor = ColorManager.General.mainPurple.rawValue
    }

    private let chevron = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = ColorManager.General.mainPurple.rawValue
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        self.backgroundColor = .white

        [title, chevron].forEach {
            self.addSubview($0)
        }

        title.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(16)
        }

        chevron.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).inset(16)
        }

        self.addTarget(self, action: #selector(selectMe(_:)), for: .touchUpInside)
    }

    @objc func selectMe(_ sender: UIButton) {
        print("a")
    }
}
