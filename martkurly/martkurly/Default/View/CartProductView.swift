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
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = .lightGray
        $0.backgroundColor = .white
    }

    var title = UILabel()

    var image = UIImageView().then {
        $0.backgroundColor = .purple
    }

    var condition = UILabel()

    var discount = 0

    private lazy var discountMoney = UILabel().then {
        let discountAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.lightGray,
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.lightGray
                ]

        let attributeString = NSAttributedString(
                    string: "\(discount)",
                    attributes: discountAttributes)

        $0.attributedText = attributeString
    }

    var product = 19000
    private lazy var productPrice = UILabel().then {
        $0.text = "\(product)원"
        $0.font = .boldSystemFont(ofSize: 13)
    }

    private let dismissBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .gray
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
        backgroundColor = .white
        [checkBtn, title, dismissBtn, image, condition, productPrice, discountMoney].forEach {
            self.addSubview($0)
        }

        checkBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(8)
            $0.width.height.equalTo(30)
        }

//        check.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)

        title.snp.makeConstraints {
            $0.centerY.equalTo(checkBtn.snp.centerY)
            $0.leading.equalTo(checkBtn.snp.trailing).offset(8)
        }
        title.text = "퍼플 삼겹살"

        image.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.leading.equalTo(title.snp.leading)
            $0.height.equalTo(65)
            $0.width.equalTo(50)
        }

        condition.snp.makeConstraints {
            $0.centerX.equalTo(image.snp.centerX)
            $0.top.equalTo(image.snp.bottom).offset(8)
        }
        condition.text = "냉동"

        discountMoney.snp.makeConstraints {
            $0.bottom.equalTo(productPrice.snp.top).offset(8)
            $0.leading.equalTo(productPrice.snp.leading)
        }

        productPrice.snp.makeConstraints {
            $0.bottom.equalTo(image.snp.bottom)
            $0.leading.equalTo(image.snp.trailing).offset(8)
        }

        dismissBtn.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.trailing.equalToSuperview().inset(8)
        }
        dismissBtn.addTarget(self, action: #selector(xmark), for: .touchUpInside)
        dismissBtn.clipsToBounds = true
        dismissBtn.sizeToFit()
    }

    // MARK: - Action
    @objc
    func xmark(_ sender: UIButton) {
        print("hey")
    }
}
