//
//  ProductCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/24.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductCell"

    var product: Product? {
        didSet { configure() }
    }

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let saleDisplayLabel = UILabel().then {
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.white
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]

        var stringValue = NSMutableAttributedString(string: "SAVE\n", attributes: attributes)
        stringValue.append(NSAttributedString(string: "40", attributes: boldAttributes))
        stringValue.append(NSAttributedString(string: "%", attributes: attributes))

        $0.attributedText = stringValue
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }

    private lazy var saleDisplayView = UIView().then {
        $0.backgroundColor = UIColor(red: 147/255,
                                     green: 83/255,
                                     blue: 185/255,
                                     alpha: 0.8)

        $0.addSubview(saleDisplayLabel)
        saleDisplayLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private lazy var cartButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(red: 110/255,
                                     green: 85/255,
                                     blue: 116/255,
                                     alpha: 0.8)

        let configuration = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .medium,
            scale: .large)
        let symbolImage = UIImage(
            systemName: "cart",
            withConfiguration: configuration)

        $0.setImage(symbolImage, for: .normal)
        $0.tintColor = .white

        $0.addTarget(self, action: #selector(tappedCartButton), for: .touchUpInside)
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[남향푸드또띠아] 간편 간식 브리또 8종"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 2
    }

    private let productPriceLabel = UILabel().then {
        $0.text = "2,800원"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }

    private let productStatsLeftLabel = UILabel().then {
        let mainColor = ColorManager.General.mainPurple.rawValue
        $0.text = "  Kurly only  "
        $0.textColor = mainColor
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.layer.borderColor = mainColor.cgColor
        $0.layer.borderWidth = 1
    }

    private let productStatsRightLabel = UILabel().then {
        let mainColor = ColorManager.General.mainPurple.rawValue
        $0.text = "  한정수량  "
        $0.textColor = mainColor
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.layer.borderColor = mainColor.cgColor
        $0.layer.borderWidth = 1
    }

    private lazy var infoView = UIView().then {
        $0.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [
            productTitleLabel, productPriceLabel
        ])
        stack.axis = .vertical
        stack.spacing = 4

        $0.addSubview(stack)

        stack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        let statsStack = UIStackView(arrangedSubviews: [
            productStatsLeftLabel, productStatsRightLabel
        ])
        statsStack.spacing = 2
        statsStack.axis = .horizontal

        $0.addSubview(statsStack)
        statsStack.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc func tappedCartButton(_ sender: UIButton) {

    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [productImageView, infoView, cartButton, saleDisplayView].forEach {
            self.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(infoView.snp.top).offset(-16)
        }

        saleDisplayView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(56)
        }

        cartButton.snp.makeConstraints {
            $0.width.height.equalTo(52)
            $0.bottom.trailing.equalTo(productImageView).offset(-12)
        }
        cartButton.layer.cornerRadius = 52 / 2

        infoView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(88)
        }
    }

    func configure() {
        guard let product = product else { return }
        let viewModel = ProductViewModel(product: product)

        saleDisplayView.isHidden = viewModel.isShowSaleView
        saleDisplayLabel.attributedText = viewModel.saleDisplayText

        productTitleLabel.text = product.title
        productImageView.kf.setImage(with: viewModel.imageURL)
        productPriceLabel.attributedText = viewModel.priceDisplayText

        productStatsLeftLabel.isHidden = viewModel.isShowleftTag
        productStatsLeftLabel.text = viewModel.leftTagText
        productStatsRightLabel.isHidden = viewModel.isShowRightTag
        productStatsRightLabel.text = viewModel.rightTagText
    }
}
