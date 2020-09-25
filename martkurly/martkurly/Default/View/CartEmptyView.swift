//
//  CartEmptyView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartEmptyView: UITableViewCell {
    // MARK: - Propertise

    private let empty = UILabel().then {
        $0.text = "장바구니에 담긴 상품이 없습니다"
        $0.textAlignment = .center
        $0.backgroundColor = .white
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setUI() {
        contentView.backgroundColor = ColorManager.General.backGray.rawValue
        contentView.addSubview(empty)
        empty.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().offset(8).inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
