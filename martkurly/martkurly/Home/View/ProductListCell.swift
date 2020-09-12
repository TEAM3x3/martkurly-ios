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

    private var productListView: ProductListView!

    var detailViewProductMove: ((Int) -> Void)?

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    func tappedProduct(productID: Int) {
        detailViewProductMove?(productID)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
    }

    func configureLayout() {
        [productListView].forEach {
            self.addSubview($0)
        }

        productListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(headerType: SortHeaderType, products: [Product]) {
        productListView = ProductListView(headerType: headerType)
        productListView.products = products
        productListView.tappedProduct = tappedProduct(productID:)
        configureLayout()
    }
}
