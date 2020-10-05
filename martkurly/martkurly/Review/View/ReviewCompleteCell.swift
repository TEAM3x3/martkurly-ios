//
//  ReviewCompleteCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewCompleteCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ReviewCompleteCell"

    private let defaultInsetValue: CGFloat = 12
    private let lineInsetValue: CGFloat = 6

    var reviewItem: ReviewModel? {
        didSet { configure() }
    }

    private let completeView = UIView().then {
        $0.backgroundColor = .white
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[간식엔] 우리쌀로 만든 호두과자 (냉동)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let underLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let reviewTitleLabel = UILabel().then {
        $0.text = "맛있어요!"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
    }

    private let reviewContentsLabel = UILabel().then {
        $0.text = "맛있게 잘 먹었습니당ㅎㅎㅎ"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let reviewDateLabel = UILabel().then {
        $0.text = "20.09.19 작성"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14)
    }

    private let reviewImageCountLabel = UILabel().then {
        $0.text = "3"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
        $0.isHidden = true
    }

    private lazy var reviewImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true

        $0.addSubview(reviewImageCountLabel)
        reviewImageCountLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.height.width.equalTo(20)
        }
    }

    private let reviewRecommendCountLabel = UILabel().then {
        $0.text = "도움이 돼요 0"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 14)
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
        self.backgroundColor = ColorManager.General.backGray.rawValue
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(completeView)
        completeView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineInsetValue)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
        }

        [productTitleLabel, underLine, reviewTitleLabel, reviewContentsLabel, reviewDateLabel, reviewImageView, reviewRecommendCountLabel].forEach {
            completeView.addSubview($0)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultInsetValue)
        }

        underLine.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.height.equalTo(0.5)
        }

        reviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
        }

        reviewContentsLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
        }

        reviewDateLabel.snp.makeConstraints {
            $0.top.equalTo(reviewContentsLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.bottom.equalToSuperview().offset(-defaultInsetValue)
        }

        reviewRecommendCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-defaultInsetValue)
        }

        reviewImageView.snp.makeConstraints {
            $0.bottom.equalTo(reviewRecommendCountLabel.snp.top).offset(-16)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.width.equalTo(64)
            $0.height.equalTo(52)
        }
    }

    func configure() {
        guard let reviewItem = reviewItem else { return }
        productTitleLabel.text = reviewItem.goods.title
        reviewTitleLabel.text = reviewItem.title
        reviewContentsLabel.text = reviewItem.content

        let imageURL = URL(string: reviewItem.goods.img)
        reviewImageView.kf.setImage(with: imageURL)
    }
}
