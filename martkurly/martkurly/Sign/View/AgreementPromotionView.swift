//
//  AgreementPromotionView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/21/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class AgreementPromotionView: UIView {

    // MARK: - Properties
    let label = UILabel().then {
        let string = StringManager().agreementPromotion[0]
        let color = ColorManager.General.mainPurple.rawValue
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)

        let string2 = StringManager().agreementPromotion[1]
        let color2 = ColorManager.General.chevronGray.rawValue
        let font2 = UIFont.systemFont(ofSize: 13.5, weight: .light)
        let attributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: color2,
            .font: font2
        ]
        let attributedString2 = NSMutableAttributedString(string: string2, attributes: attributes2)
        attributedString.append(attributedString2)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attributes3 = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        attributedString.addAttributes(attributes3, range: NSRange(location: 0, length: attributedString.length))
        $0.attributedText = attributedString
        $0.numberOfLines = 0
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
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        self.layer.borderColor = ColorManager.General.backGray.rawValue.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
    }

    private func setConstraints() {
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }

}
