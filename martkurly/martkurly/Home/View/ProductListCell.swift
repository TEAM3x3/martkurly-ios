//
//  ProductListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductListCell"

    private let sideInset: CGFloat = 8
    private let lineInset: CGFloat = 24

    enum ProductListType {
        case newType
        case bestType
        case cheapType
    }

    enum SortType: String {
        case fastArea
        case quality
        case price
    }

    private lazy var fastAreaButton = makeSortStackView(title: "샛별지역상품",
                                                        type: .fastArea)
    private lazy var qualityaButton = makeSortStackView(title: "신상품순",
                                                        type: .fastArea)
    private lazy var priceButton = makeSortStackView(title: "혜택순",
                                                        type: .fastArea)

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var productListCollectionView = UICollectionView(frame: .zero,
                                                                  collectionViewLayout: flowLayout)

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func tappedSortEvent(_ sender: UITapGestureRecognizer) {
        guard let gestureName = sender.name else { return }
        switch SortType(rawValue: gestureName)! {
        case .fastArea:
            print("fastArea")
//            fastAreaButton.subviews.forEach {
//                if let imageView = $0 as? UIImageView {
//                    imageView.backgroundColor = .red
//                }
//            }
        case .quality:
            print("quality")
        case .price:
            print("price")
        }
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue
        configureLayout()
        configureCollectionView()
    }

    func configureLayout() {
        self.addSubview(productListCollectionView)
        productListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureCollectionView() {
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.backgroundColor = .clear

        productListCollectionView.register(ProductCell.self,
                                           forCellWithReuseIdentifier: ProductCell.identifier)
    }

    func makeSortStackView(title: String, type: SortType) -> UIStackView {
        let titleLabel = UILabel().then {
            $0.text = title
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16)
            $0.textAlignment = .center
        }

        let imageView = UIImageView().then {
            $0.image = UIImage(systemName: "chevron.down")
            $0.tintColor = .black
            $0.snp.makeConstraints {
                $0.width.height.equalTo(16)
            }
        }

        let stack = UIStackView(arrangedSubviews: [titleLabel, imageView])
        stack.axis = .horizontal
        stack.spacing = 4

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedSortEvent))
        tapGesture.name = type.rawValue
        stack.addGestureRecognizer(tapGesture)
        stack.isUserInteractionEnabled = true

        return stack
    }
}

// MARK: - UICollectionViewDataSource

extension ProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - (sideInset * 3)) / 2
        return CGSize(width: width, height: width * 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: lineInset, left: sideInset,
                            bottom: lineInset, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
}

// MARK: - ProductCell

class ProductCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductCell"

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let saleDisplayView = UIView().then {
        $0.backgroundColor = UIColor(red: 151/255, green: 87/255, blue: 187/255, alpha: 0.8)
    }

    private lazy var cartButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(red: 110/255, green: 85/255, blue: 116/255, alpha: 0.8)

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

    private let productNoticeLabel = UILabel().then {
        let mainColor = ColorManager.General.mainPurple.rawValue
        $0.text = "  Kurly only  "
        $0.textColor = mainColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.layer.borderColor = mainColor.cgColor
        $0.layer.borderWidth = 2
    }

    private lazy var infoView = UIView().then {
        $0.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [
            productTitleLabel, productPriceLabel
        ])
        stack.axis = .vertical
        stack.spacing = 4

        $0.addSubview(stack)
        $0.addSubview(productNoticeLabel)

        stack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        productNoticeLabel.snp.makeConstraints {
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
            $0.width.height.equalTo(60)
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
}
