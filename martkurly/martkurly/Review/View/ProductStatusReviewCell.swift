//
//  ProductStatusReviewCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductStatusReviewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductStatusReviewCell"

    var reviewItem: CartItem? {
        didSet { configure() }
    }

    private let defaultInsetValue: CGFloat = 8
    private let sideInsetValue: CGFloat = 12
    private let lineInsetValue: CGFloat = 12

    private let sideHeaderInsetValue: CGFloat = 12
    private let lineHeaderInsetValue: CGFloat = 4

    var handleReviewWrite: ((ProductStatusReviewCell) -> Void)?

    private let orderTitleLabel = UILabel().then {
        $0.text = "주문번호"
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 12)
    }

    private let orderNumberLabel = UILabel().then {
        $0.text = "1597994321049"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

    private let completeDateLabel = UILabel().then {
        $0.text = "08월 22일 배송완료"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
    }

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
        $0.isHidden = true
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func handleReviewWriteEvent(_ sender: UIButton) {
        handleReviewWrite?(self)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear
        configureLayout()
        configureAttributes()
    }

    func configureAttributes() {
        reviewWriteButton.addTarget(self,
                                    action: #selector(handleReviewWriteEvent(_:)),
                                    for: .touchUpInside)
    }

    func configureLayout() {
        [cellView, orderTitleLabel, orderNumberLabel, completeDateLabel].forEach {
            self.addSubview($0)
        }

        orderTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineHeaderInsetValue)
            $0.leading.equalToSuperview().offset(sideHeaderInsetValue)
        }

        orderNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(orderTitleLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(orderTitleLabel)
        }

        completeDateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-sideHeaderInsetValue)
            $0.centerY.equalTo(orderTitleLabel)
        }

        cellView.snp.makeConstraints {
            $0.top.equalTo(orderTitleLabel.snp.bottom).offset(defaultInsetValue + lineHeaderInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.bottom.equalToSuperview().offset(-defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
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
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.width.equalTo(productImageView.snp.height).multipliedBy(0.8)
        }

        productStack.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(sideInsetValue)
            $0.top.equalTo(productImageView)
        }

        reviewWriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
            $0.height.equalTo(36)
            $0.width.equalTo(92)
        }

        remainDayLabel.snp.makeConstraints {
            $0.bottom.equalTo(reviewWriteButton)
            $0.trailing.equalTo(reviewWriteButton.snp.leading).offset(-sideInsetValue)
        }
    }

    func configure() {
        guard let reviewItem = reviewItem else { return }

        let imageURL = URL(string: reviewItem.goods.img)
        productImageView.kf.setImage(with: imageURL)
        productTitleLabel.text = reviewItem.goods.title
        productBuyCountLabel.text = "\(reviewItem.quantity)개 구매"
    }
}
