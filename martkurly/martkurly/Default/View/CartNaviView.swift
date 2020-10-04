//
//  CartNaviView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/02.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartNaviView: UIView {

    // MARK: - Properties
    private let bar = UIView().then {
        $0.backgroundColor = .white
    }

    private let title = UILabel().then {
        $0.text = "장바구니"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.sizeToFit()
    }

    let dismissBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
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
        [bar].forEach {
            addSubview($0)
        }

        [dismissBtn, title].forEach {
            bar.addSubview($0)
        }

        bar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(44)
        }

        dismissBtn.snp.makeConstraints {
            $0.leading.equalTo(bar.snp.leading).offset(16)
            $0.bottom.equalTo(bar.snp.bottom).inset(16)
        }
//        dismissBtn.contentVerticalAlignment = .bottom
//        dismissBtn.contentHorizontalAlignment = .left

        title.snp.makeConstraints {
            $0.centerX.equalTo(bar.snp.centerX)
            $0.bottom.equalTo(bar.snp.bottom).inset(16)
        }
        title.contentMode = .bottom
    }
}
