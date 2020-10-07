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
    private var statusArr = Set<String>()

    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.black
    ]

    private let truckImg = UIImageView().then {
        $0.image = UIImage(named: "truck")
        $0.sizeToFit()
    }

    private var shipping = UILabel().then {
        let estimateMoneyAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSAttributedString(
            string: "0",
            attributes: estimateMoneyAttribute
        )

        $0.attributedText = attributeString
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
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
        }

        shipping.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(truckImg.snp.trailing).offset(8)
        }

        backgroundColor = ColorManager.General.backGray.rawValue
    }

    func configure(text: String) {
        self.statusArr.insert(text)

        var statusText = ""
        for i in statusArr {
            statusText += "\(i)" + "∙"
        }
        statusText.removeLast(1)

        let attributedString = NSMutableAttributedString(string: statusText + " 박스로 배송됩니다", attributes: attributes)
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(red: 104, green: 183, blue: 148), range: (text as NSString).range(of: "냉장"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(red: 107, green: 170, blue: 245), range: (text as NSString).range(of: "냉동"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(red: 220, green: 123, blue: 85), range: (text as NSString).range(of: "상온"))

        self.shipping.attributedText = attributedString

    }
}
