//
//  SignUpAddressInputView.swift
//  martkurly
//
//  Created by Kas Song on 8/25/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpAddressInputView: UIView {

    // MARK: - Properties
    private let addressLabel = UILabel().then {
        $0.text = "서울 중랑구 양원역로 1"
    }
    private let deliveryLabel = UILabel().then {
        $0.text = StringManager.SignUp.addtionalAddressInfo.rawValue
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    private let searchImageView = UIImageView(image: ImageManager.SignUp.search.rawValue)
    private var quickDeleveryAvailable = false

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
        setAttributes()
        setConstraints()
    }

    private func setAttributes() {
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorManager.General.placeholder.rawValue.cgColor
        self.layer.cornerRadius = 4
    }

    private func setConstraints() {
        [addressLabel, deliveryLabel, searchImageView].forEach {
            self.addSubview($0)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(4)
        }
        deliveryLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-4)
            $0.leading.equalTo(addressLabel)
        }
        searchImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
        }
    }
}
