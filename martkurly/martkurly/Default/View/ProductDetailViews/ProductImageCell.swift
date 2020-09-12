//
//  ProductImageCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductImageCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductImageCell"
    private let sideInsetValue: CGFloat = 12

    private let imageTableView = UITableView()
    private let productBuyButton = KurlyButton(title: "구매하기", style: .purple)

    var productDetailData: ProductDetail? {
        didSet { imageTableView.reloadData() }
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue

        [imageTableView, productBuyButton].forEach {
            self.addSubview($0)
        }

        imageTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        productBuyButton.snp.makeConstraints {
            $0.top.equalTo(imageTableView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-24)
            $0.height.equalTo(52)
        }
    }

    func configureTableView() {
        imageTableView.backgroundColor = .clear
        imageTableView.separatorStyle = .none
        imageTableView.allowsSelection = false

        imageTableView.dataSource = self
        imageTableView.delegate = self

        imageTableView.register(ProductExplainImageCell.self,
                                  forCellReuseIdentifier: ProductExplainImageCell.identifier)
    }
}

extension ProductImageCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductExplainImageCell.identifier,
            for: indexPath) as! ProductExplainImageCell

        guard let productDetailData = productDetailData,
            let imageURL = URL(string: productDetailData.info_img) else { return cell }
        cell.productImageView.kf.setImage(with: imageURL)

        return cell
    }
}
