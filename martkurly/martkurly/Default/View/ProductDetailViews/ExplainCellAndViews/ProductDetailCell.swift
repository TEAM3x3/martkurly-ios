//
//  ProductDetailCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/11.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductDetailCell"

    private let defaultInsetValue: CGFloat = 20

    var productDetailData: ProductDetail? {
        didSet { configure() }
    }

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "무농약 콩으로 기른 장인의 나물"
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textAlignment = .center
    }

    private let productContextLabel = UILabel().then {
        $0.text = "[김구원선생] 무농약 콩나물"
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
    }

    private let productDescriptionLabel = UILabel().then {
        $0.text = "4대 쨰 두부 장인의 전통을 이어온 브랜드, 김구원선생의..."
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.setLineSpacing(lineSpacing: 6)
        $0.textAlignment = .left
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
        configureLayout()
    }

    func configureLayout() {
        [productImageView, productTitleLabel, productContextLabel, productDescriptionLabel].forEach {
            self.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.height.equalTo(productImageView.snp.width).multipliedBy(0.8)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
        }

        productContextLabel.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
        }

        let lineView = UIView()
        lineView.backgroundColor = ColorManager.General.chevronGray.rawValue

        self.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.top.equalTo(productContextLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.height.equalTo(1)
        }

        productDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(defaultInsetValue)
            $0.trailing.equalToSuperview().offset(-defaultInsetValue)
            $0.bottom.equalToSuperview().offset(-60)
        }
    }

    func configure() {
        guard let productDetailData = productDetailData else { return }
        let detailData = productDetailData.explains[0]

        let imageURL = URL(string: detailData.img)
        productImageView.kf.setImage(with: imageURL)
        productTitleLabel.text = detailData.text_title
        productContextLabel.text = detailData.text_context
        productDescriptionLabel.text = detailData.text_description
    }
}
