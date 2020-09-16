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
    let addressLabel = UILabel().then {
        $0.text = " "
        $0.numberOfLines = 0
    }
    private let addressLabelPlaceholder = UILabel().then {
        $0.text = "도로명, 지번, 건물명 검색"
        $0.textColor = ColorManager.General.placeholder.rawValue
//        $0.font = UIFont.boldSystemFont(ofSize: 17)
    }
    private let deliveryLabel = UILabel().then {
        $0.text = "샛별배송"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    private let searchImageView = UIImageView(image: ImageManager.SignUp.search.rawValue)
    private var quickDeleveryAvailable = false {
        willSet {
            updateConstraints(newValue: newValue)
        }
    }

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
        addressLabel.addSubview(addressLabelPlaceholder)
        addressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(12)
        }
        addressLabelPlaceholder.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
        }
        searchImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(25)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Helpers
    func setQuickDeleveryAvailable() {
        quickDeleveryAvailable = true
    }

    private func updateConstraints(newValue: Bool) {
        switch newValue {
        case true:
            [addressLabel, searchImageView].forEach {
                $0.snp.removeConstraints()
            }
            addressLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(14)
                $0.leading.equalToSuperview().offset(12)
            }
            deliveryLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-14)
                $0.leading.equalTo(addressLabel)
            }
            searchImageView.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(14)
                $0.width.height.equalTo(25)
                $0.centerY.equalToSuperview()
            }
            addressLabelPlaceholder.isHidden = true
        case false:
            [addressLabel, deliveryLabel, searchImageView].forEach {
                $0.snp.removeConstraints()
            }
            addressLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(14)
                $0.leading.equalToSuperview().offset(12)
            }
            searchImageView.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(14)
                $0.width.height.equalTo(25)
                $0.centerY.equalToSuperview()
            }
            addressLabelPlaceholder.isHidden = false
        }
    }
}
