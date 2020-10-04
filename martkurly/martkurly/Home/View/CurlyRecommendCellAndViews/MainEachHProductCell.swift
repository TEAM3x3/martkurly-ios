//
//  MainEachHProductCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/04.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

// 메인화면에서 보여주는 상품 셀(가로 경우)
class MainEachHProductCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "MainEachHProductCell"

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
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
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
        $0.backgroundColor = UIColor(red: 151/255,
                                     green: 87/255,
                                     blue: 187/255,
                                     alpha: 1)

        $0.addSubview(saleDisplayLabel)
        saleDisplayLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private let numberingTextLabel = UILabel().then {
        $0.text = "03"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40)

        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        $0.layer.shadowRadius = 0.1
        $0.layer.shadowOpacity = 0.2

        $0.isHidden = true
    }

    private lazy var cartButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(red: 110/255,
                                     green: 85/255,
                                     blue: 116/255,
                                     alpha: 0.8)

        let configuration = UIImage.SymbolConfiguration(
            pointSize: 12,
            weight: .medium,
            scale: .large)
        let symbolImage = UIImage(
            systemName: "cart",
            withConfiguration: configuration)

        $0.setImage(symbolImage, for: .normal)
        $0.tintColor = .white

        $0.addTarget(self, action: #selector(tappedCartButton), for: .touchUpInside)
        $0.isHidden = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[그린팬] 그린쉐프 토콰즈 프라이팬 6종"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }

    private let productSalePriceLabel = UILabel().then {
        $0.attributedText = NSAttributedString(
            string: "36,900원",
            attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                         NSAttributedString.Key.strikethroughColor: ColorManager.General.mainGray.rawValue,
                         NSAttributedString.Key.foregroundColor: ColorManager.General.mainGray.rawValue,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
    }

    private let productBasicPriceLabel = UILabel().then {
        $0.text = "29,520원"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
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
        self.backgroundColor = .clear
        configureLayout()
    }

    func configureLayout() {
        [productImageView, saleDisplayView, numberingTextLabel, cartButton].forEach {
            self.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.frame.height * 0.62)
        }

        saleDisplayView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(38)
            $0.width.equalTo(44)
        }

        numberingTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-4)
        }

        cartButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.bottom.trailing.equalTo(productImageView).offset(-8)
        }
        cartButton.layer.cornerRadius = 32 / 2

        let infoStack = UIStackView(arrangedSubviews: [productTitleLabel,
                                                       productBasicPriceLabel,
                                                       productSalePriceLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        infoStack.alignment = .leading

        self.addSubview(infoStack)
        infoStack.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().offset(-4)
        }
    }

    func configure(isShowRanking: Bool, isShowBasket: Bool) {
        numberingTextLabel.isHidden = !isShowRanking
        cartButton.isHidden = !isShowBasket
    }

    func configure() {
        guard let product = product else { return }
        let viewModel = ProductListViewModel(product: product)

        productImageView.kf.setImage(with: viewModel.imageURL)
        productTitleLabel.text = product.title
        productBasicPriceLabel.attributedText = viewModel.primeCostDisplayText
        productSalePriceLabel.attributedText = viewModel.saleCostDisplayText
        saleDisplayView.isHidden = viewModel.isShowSaleView
        saleDisplayLabel.attributedText = viewModel.saleDisplayText
    }
}
