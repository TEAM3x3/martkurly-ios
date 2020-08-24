//
//  CategoryDetailButtonCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class DetailCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let btn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitleColor(.black, for: .normal)
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        addSubview(btn)
        btn.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

    func configure(title: String) {
        btn.setTitle(title, for: .normal)
    }
}
