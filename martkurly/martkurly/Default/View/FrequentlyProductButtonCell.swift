//
//  frequentlyProductButtonCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/22.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class FrequentlyProductButtonCell: UITableViewCell {

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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        [title, chevron].forEach {
            self.addSubview($0)
        }

        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }

        chevron.snp.makeConstraints {
            $0.centerY.equalTo(title)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
