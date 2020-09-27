//
//  CartHeaderView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartHeaderView: UIView {

    // MARK: - Properties
    private let truckImg = UIImageView().then {
        $0.image = UIImage(named: "truck")
        $0.sizeToFit()
    }
    var storage = ""

    var shipping = UILabel().then {
        $0.text = " 박스로 배송됩니다"
        $0.textColor = .black
    }

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
        setConfigure()
    }

    private func setConfigure() {
        [truckImg, shipping].forEach {
            self.addSubview($0)
        }

        truckImg.snp.makeConstraints {
            $0.centerY.equalTo(shipping.snp.centerY)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }

        shipping.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(truckImg.snp.trailing).offset(4)
        }

        backgroundColor = ColorManager.General.backGray.rawValue
    }

    func configure(txt: String) {
        shipping.text = txt
    }
}
