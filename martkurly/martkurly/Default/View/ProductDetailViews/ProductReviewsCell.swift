//
//  ProductReviewsCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductReviewsCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductReviewsCell"

    private let sideInsetValue: CGFloat = 12

    var productReviews = [ReviewModel]() {
        didSet { reviewsTableView.reloadData() }
    }

    private let reviewWriteButton = KurlyButton(title: "후기 쓰기", style: .white)
    private let reviewsTableView = UITableView()

    var tappedWriteReviewEvent: (() -> Void)?
    var tappedReviewDetail: ((ReviewModel) -> Void)?

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func tappedWriteReview(_ sender: UIButton) {
        tappedWriteReviewEvent?()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        [reviewWriteButton, reviewsTableView].forEach {
            self.addSubview($0)
        }
        reviewWriteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(44)
        }

        reviewsTableView.snp.makeConstraints {
            $0.top.equalTo(reviewWriteButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview()
        }
    }

    func configureAttributes() {
        reviewWriteButton.addTarget(self,
                                    action: #selector(tappedWriteReview(_:)),
                                    for: .touchUpInside)
    }

    func configureTableView() {
        reviewsTableView.backgroundColor = .clear
        reviewsTableView.separatorStyle = .none

        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self

        reviewsTableView.register(ReviewCell.self,
                                  forCellReuseIdentifier: ReviewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ProductReviewsCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productReviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        cell.productReview = productReviews[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 24
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

// MARK: - UITableViewDelegate

extension ProductReviewsCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        tappedReviewDetail?(productReviews[indexPath.row])
    }
}
