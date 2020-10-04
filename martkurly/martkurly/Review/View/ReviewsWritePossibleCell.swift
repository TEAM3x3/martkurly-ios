//
//  ReviewsWritePossibleCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewsWritePossibleCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ReviewsWritePossibleCell"

    private let reviewsTableView = UITableView()

    private let reviewsInfomationTextView = UITextView().then {
        let infoText = """
        후기 작성 시 사진후기 100원, 글 후기 50원을 적립해드립니다.

        - 퍼플, 더퍼플은 2배 적립 (사진 200원, 글 100원)
        - 주간 베스트 후기로 선정 시 5,000원을 추가 적립
        * 후기 작성은 배송 완료일로부터 30일 이내 가능합니다.
        """

        $0.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        $0.attributedText = NSAttributedString(string: infoText, attributes: attributes)
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configuteTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(reviewsTableView)
        reviewsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configuteTableView() {
        reviewsTableView.backgroundColor = .clear
        reviewsTableView.separatorStyle = .none

        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self

        reviewsTableView.register(ReviewsInfomationCell.self,
                                  forCellReuseIdentifier: ReviewsInfomationCell.identifier)
        reviewsTableView.register(ProductStatusReviewCell.self,
                                  forCellReuseIdentifier: ProductStatusReviewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ReviewsWritePossibleCell: UITableViewDataSource {
    enum ReviewsPossibleCellType: Int, CaseIterable {
        case reviewsInfomation
        case reviewsPossibleList
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ReviewsPossibleCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ReviewsPossibleCellType(rawValue: indexPath.section)! {
        case .reviewsInfomation:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ReviewsInfomationCell.identifier,
                for: indexPath) as! ReviewsInfomationCell
            return cell
        case .reviewsPossibleList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductStatusReviewCell.identifier,
                for: indexPath) as! ProductStatusReviewCell
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ReviewsWritePossibleCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch ReviewsPossibleCellType(rawValue: section)! {
        case .reviewsInfomation: return nil
        case .reviewsPossibleList:
            let reviewsHeaderView = ReviewsHeaderView()
            return reviewsHeaderView
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch ReviewsPossibleCellType(rawValue: section)! {
        case .reviewsInfomation: return .zero
        case .reviewsPossibleList: return UITableView.automaticDimension
        }
    }
}
