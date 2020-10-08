//
//  ReviewDetailVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/05.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewDetailVC: UIViewController {

    // MARK: - Properties

    var reviewData: ReviewModel? {
        didSet { configure() }
    }

    private let defaultInsetValue: CGFloat = 20

    private let reviewDetailScrollView = UIScrollView()
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }

    // ContentView

    private let productTitleLabel = UILabel().then {
        $0.text = "현미 크리스피"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
    }

    private let topLineView = UIView().then {
        $0.backgroundColor = .lightGray
    }

    private let reviewTitleLabel = UILabel().then {
        $0.text = "맛있어요"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
    }

    private let reviewContentLabel = UILabel().then {
        $0.text = "맛있어요"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }

    private let reviewDateLabel = UILabel().then {
        $0.text = "20.10.05 작성"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let betterHelpButton = UIButton(type: .system).then {
        $0.setTitle("도움이 돼요 0", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12)
    }

    private let bottomLineView = UIView().then {
        $0.backgroundColor = .lightGray
    }

    private let reportButton = UIButton(type: .system).then {
        $0.setTitle("🚨 신고", for: .normal)
        $0.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12)
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .pop,
                                    titleText: "상품 후기 상세")
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = .white

        view.addSubview(reviewDetailScrollView)
        reviewDetailScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        reviewDetailScrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.width.equalToSuperview()
        }

        [productTitleLabel, topLineView, betterHelpButton, bottomLineView, reportButton].forEach {
            contentView.addSubview($0)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(defaultInsetValue)
        }

        topLineView.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(defaultInsetValue)
            $0.height.equalTo(1)
        }

        let contentsStack = UIStackView(arrangedSubviews: [
            reviewTitleLabel, reviewContentLabel, reviewDateLabel
        ])
        contentsStack.alignment = .leading
        contentsStack.spacing = defaultInsetValue
        contentsStack.axis = .vertical

        contentView.addSubview(contentsStack)
        contentsStack.snp.makeConstraints {
            $0.top.equalTo(topLineView.snp.bottom).offset(defaultInsetValue)
            $0.leading.trailing.equalToSuperview().inset(defaultInsetValue)
        }

        betterHelpButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(contentsStack)
        }

        bottomLineView.snp.makeConstraints {
            $0.top.equalTo(contentsStack.snp.bottom).offset(defaultInsetValue)
            $0.leading.trailing.equalToSuperview().inset(defaultInsetValue)
            $0.height.equalTo(1)
        }

        reportButton.snp.makeConstraints {
            $0.top.equalTo(bottomLineView.snp.bottom).offset(defaultInsetValue)
            $0.trailing.bottom.equalToSuperview().inset(defaultInsetValue)
        }
    }

    func configureAttributes() {
        reviewDetailScrollView.backgroundColor = ColorManager.General.backGray.rawValue

        reviewDetailScrollView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }

    func configure() {
        guard let reviewData = reviewData else { return }
        productTitleLabel.text = reviewData.goods.title
        reviewTitleLabel.text = reviewData.title
        reviewContentLabel.text = reviewData.content

        let date = reviewData.created_at.components(separatedBy: "T")[0]
        reviewDateLabel.text = date.replacingOccurrences(of: "-", with: ".") + " 작성"
    }
}
