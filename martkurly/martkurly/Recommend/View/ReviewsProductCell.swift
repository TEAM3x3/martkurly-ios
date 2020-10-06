//
//  ReviewsProductCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/15.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewsProductCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ReviewsProductCell"

    private let sideInsetValue: CGFloat = 12
    private var reviewsCount: Int = 0

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[오늘의 일상] 홍차 베이스 3종"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let productPriceLabel = UILabel().then {
        $0.text = "12,000원" // "10% 21,600원 -24,000원-
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }

    private lazy var reviewsCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureReviewsCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc func nextReviews() {
        reviewsCount += 1
        let indexPath = IndexPath(item: reviewsCount % 5, section: 0)
        reviewsCollectionView.selectItem(at: indexPath,
                                         animated: true,
                                         scrollPosition: .centeredVertically)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5

        configureLayout()
        configureAttributes()
    }

    func configureAttributes() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(nextReviews),
                         name: .init(TimerSingleton.nextReviews),
                         object: nil)
    }

    func configureLayout() {
        [productImageView, reviewsCollectionView].forEach {
            self.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.height).multipliedBy(0.55)
        }

        let productInfoStack = UIStackView(arrangedSubviews: [
            productTitleLabel, productPriceLabel
        ])

        productInfoStack.axis = .vertical
        productInfoStack.spacing = 4

        self.addSubview(productInfoStack)
        productInfoStack.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(sideInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
        }

        let lineView = UIView()
        lineView.backgroundColor = .lightGray

        self.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.top.equalTo(productInfoStack.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(0.5)
        }

        reviewsCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview()
        }
    }

    func configureReviewsCollectionView() {
        reviewsCollectionView.backgroundColor = .clear
        reviewsCollectionView.showsVerticalScrollIndicator = false
        reviewsCollectionView.isPagingEnabled = true
        reviewsCollectionView.isScrollEnabled = false

        reviewsCollectionView.dataSource = self
        reviewsCollectionView.delegate = self

        reviewsCollectionView.register(ReviewsCell.self,
                                       forCellWithReuseIdentifier: ReviewsCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewsProductCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewsCell.identifier,
            for: indexPath) as! ReviewsCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReviewsProductCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - ReviewsCell

import UIKit

class ReviewsCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ReviewsCell"

    private let quotesImageView = UIImageView().then {
        $0.image = UIImage(systemName: "quote.bubble")
        $0.tintColor = ColorManager.General.chevronGray.rawValue

        $0.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
    }

    private let reviewContents = UILabel().then {
        $0.text = "우유에 희석해서 먹는 거라 양도 많아요. 따뜻한 우유에 넣어 먹으면 더 맛있을 것 같은 느낌!"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }

    private let reviewWriter = UILabel().then {
        $0.text = "홍*빈"
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear

        let stack = UIStackView(arrangedSubviews: [
            quotesImageView, reviewContents, reviewWriter
        ])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center

        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.centerY.leading.trailing.equalToSuperview()
        }
    }
}
