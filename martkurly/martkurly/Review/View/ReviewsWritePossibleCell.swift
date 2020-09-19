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

import UIKit

class ProductStatusReviewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductStatusReviewCell"

    private let defaultInsetValue: CGFloat = 8
    private let lineInsetValue: CGFloat = 12

    private let cellView = UIView().then {
        $0.backgroundColor = .white
    }

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = ColorManager.General.backGray.rawValue
        $0.clipsToBounds = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[간식엔] 우리쌀로 만든 호두과자 (냉동)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18)
    }

    private let productBuyCountLabel = UILabel().then {
        $0.text = "2개 구매"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let reviewWriteButton = UIButton().then {
        $0.setTitle("후기 쓰기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        $0.backgroundColor = ColorManager.General.mainPurple.rawValue
    }

    private let remainDayLabel = UILabel().then {
        $0.text = "2일 남음"
        $0.textColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        $0.font = .systemFont(ofSize: 12)
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
        self.backgroundColor = .clear
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(cellView)
        cellView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.bottom.equalToSuperview().offset(-defaultInsetValue)
            $0.height.equalTo(100)
        }

        let productStack = UIStackView(arrangedSubviews: [
            productTitleLabel, productBuyCountLabel
        ])
        productStack.axis = .vertical
        productStack.spacing = 4

        [productImageView, productStack, reviewWriteButton, remainDayLabel].forEach {
            cellView.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.width.equalTo(productImageView.snp.height).multipliedBy(0.8)
        }

        productStack.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(defaultInsetValue)
            $0.top.equalTo(productImageView)
        }

        reviewWriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
            $0.height.equalTo(36)
            $0.width.equalTo(92)
        }

        remainDayLabel.snp.makeConstraints {
            $0.bottom.equalTo(reviewWriteButton)
            $0.trailing.equalTo(reviewWriteButton.snp.leading).offset(-defaultInsetValue)
        }
    }
}
