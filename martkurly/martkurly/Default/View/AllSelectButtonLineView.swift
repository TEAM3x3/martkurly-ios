//
//  EmptyCartView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/02.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class AllSelectButtonLineView: UITableViewCell {

    // MARK: - Properties
    private let emptyView = UIView().then {
        $0.backgroundColor = .white
    }

    private let emptyLabel = UILabel().then {
        $0.text = "장바구니에 담긴 상품이 없습니다."
        $0.textColor = .black
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
        [emptyView, emptyLabel].forEach {
            addSubview($0)
        }

        emptyView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(8).inset(8)
        }
        emptyView.backgroundColor = .white

        emptyLabel.snp.makeConstraints {
            $0.centerY.equalTo(emptyView.snp.centerY)
            $0.centerX.equalTo(emptyView.snp.centerX)
        }
    }

    @objc
    func btnTap(_ sender: UIButton) {
        sender.isSelected.toggle()
        print("toggle")
//        if sender.isSelected {
//            checkImg.image = UIImage(systemName: "checkmark.circle.fill")
//            checkImg.tintColor = ColorManager.General.mainPurple.rawValue
//        } else {
//            checkImg.image = UIImage(systemName: "checkmark.circle")
//            checkImg.tintColor = .lightGray
//        }
    }
}
