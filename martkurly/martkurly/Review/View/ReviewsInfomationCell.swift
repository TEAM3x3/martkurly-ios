//
//  ReviewsInfomationCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewsInfomationCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ReviewsInfomationCell"

    private let sideInsetValue: CGFloat = 8
    private let lineInsetValue: CGFloat = 20

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear

        let contentsStack = UIStackView()
        contentsStack.axis = .vertical
        contentsStack.spacing = 4

        [ReviewsStringManager.General.purpleSaveInfoText,
         ReviewsStringManager.General.additionSaveInfoText,
         ReviewsStringManager.General.reviewInfoText].forEach {
            contentsStack.addArrangedSubview(makeInfomationLabel(attributedText: $0))
         }

        let amountStack = UIStackView(arrangedSubviews: [
            makeInfomationLabel(attributedText: ReviewsStringManager.General.pointTitleText),
            contentsStack
        ])
        amountStack.axis = .vertical
        amountStack.spacing = 16
        amountStack.addBackground(color: .white)
        amountStack.isLayoutMarginsRelativeArrangement = true
        amountStack.directionalLayoutMargins =
            NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        self.addSubview(amountStack)
        amountStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
        }
    }

    func makeInfomationLabel(attributedText: NSAttributedString) -> UILabel {
        let label = UILabel()
        label.attributedText = attributedText
        return label
    }
}
