//
//  ReviewCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/06.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ReviewCell"

    private let defaultInsetValue: CGFloat = 12

    var productReview: ReviewModel? {
        didSet { configure() }
    }

    private let reviewTitleLabel = UILabel().then {
        $0.text = "맛있어요"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let reviewWriterLabel = UILabel().then {
        $0.text = "천*운"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14)
    }

    private let reviewDateLabel = UILabel().then {
        $0.text = "2020.10.05"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let underLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

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
        self.backgroundColor = .white

        [reviewTitleLabel, reviewWriterLabel, reviewDateLabel, underLine].forEach {
            self.addSubview($0)
        }

        reviewTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(defaultInsetValue)
        }

        reviewWriterLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(defaultInsetValue)
            $0.leading.trailing.equalToSuperview().inset(defaultInsetValue)
        }

        reviewDateLabel.snp.makeConstraints {
            $0.top.equalTo(reviewWriterLabel.snp.bottom).offset(4)
            $0.leading.bottom.trailing.equalToSuperview().inset(defaultInsetValue)
        }

        underLine.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func configure() {
        guard let productReview = productReview else { return }
        reviewTitleLabel.text = productReview.title
        reviewWriterLabel.text = productReview.user.username

        let date = productReview.created_at.components(separatedBy: "T")[0]
        reviewDateLabel.text = date.replacingOccurrences(of: "-", with: ".")
    }
}
