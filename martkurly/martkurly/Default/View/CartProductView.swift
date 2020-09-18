//
//  CartProductView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/17.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartProductView: UIView {
    // MARK: - Properties
    var checkBtn = UIButton().then {
        $0.backgroundColor = .white
    }
    var checkImg = UIImageView()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConstraints() {
        backgroundColor = .white
        [checkBtn].forEach {
            addSubview($0)
        }
        checkBtn.addSubview(checkImg)

        checkBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
        }

        checkImg.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        checkImg.image = UIImage(systemName: "checkmark.circle")
        checkImg.tintColor = .lightGray
//        check.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
    }
}
