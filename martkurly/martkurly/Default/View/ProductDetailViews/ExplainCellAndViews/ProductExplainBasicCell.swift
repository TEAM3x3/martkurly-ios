//
//  ProductExplainCellInTitleImageCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainBasicCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainCellInBasicCell"

    private let sideInsetValue: CGFloat = 20

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[김구원선생] 무농약 콩나물 200g"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 20)
        $0.numberOfLines = 0
    }

    private let productDetailSubTitleLabel = UILabel().then {
        $0.text = "무농약 콩으로 재배한 콩나물(1봉/200g)"
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let shareButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "link"), for: .normal)
        $0.backgroundColor = .clear
        $0.tintColor = .black
        $0.layer.borderColor = ColorManager.General.chevronGray.rawValue.cgColor
        $0.layer.borderWidth = 1

        $0.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        $0.layer.cornerRadius = 40 / 2
    }

    private let pruductPriceLabel = UILabel().then {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSMutableAttributedString(
            string: "1,300", attributes: boldAttributes)
        attributeString.append(NSAttributedString(
            string: "원", attributes: attributes))

        $0.attributedText = attributeString
    }

    private let savingPersentLabel = UITextView().then {
        $0.text = "일반 7%"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textContainerInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        $0.isScrollEnabled = false
        $0.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        $0.layer.borderWidth = 1
    }

    private let savingWonLabel = UILabel().then {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        let attributeString = NSMutableAttributedString(
            string: "개당 ", attributes: attributes)
        attributeString.append(NSAttributedString(
            string: "91원 적립", attributes: boldAttributes))

        $0.attributedText = attributeString
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        savingPersentLabel.layer.cornerRadius = savingPersentLabel.frame.height / 2
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        let width = UIScreen.main.bounds.width

        [productImageView, shareButton, pruductPriceLabel, savingPersentLabel, savingWonLabel].forEach {
            self.addSubview($0)
        }
        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(width * (4/3))
        }

        let titleStack = UIStackView(arrangedSubviews: [productTitleLabel, productDetailSubTitleLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 8

        self.addSubview(titleStack)
        titleStack.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalTo(shareButton.snp.leading).offset(-24)
        }

        shareButton.snp.makeConstraints {
            $0.top.equalTo(titleStack)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
        }

        pruductPriceLabel.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
        }

        savingPersentLabel.snp.makeConstraints {
            $0.top.equalTo(pruductPriceLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(sideInsetValue)
        }

        savingWonLabel.snp.makeConstraints {
            $0.leading.equalTo(savingPersentLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(savingPersentLabel)
        }

        let underLine = UIView()
        underLine.backgroundColor = .separatorGray

        self.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.top.equalTo(savingPersentLabel.snp.bottom).offset(sideInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
    }
}
