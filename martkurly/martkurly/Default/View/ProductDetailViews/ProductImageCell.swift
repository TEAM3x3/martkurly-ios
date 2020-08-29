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
    private let imageTableView = UITableView()

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

        self.addSubview(imageTableView)
        imageTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        imageTableView.register(ProductExplainBuyButtonCell.self,
                                forCellReuseIdentifier: ProductExplainBuyButtonCell.identifier)
    }
}

extension ProductImageCell: UITableViewDataSource, UITableViewDelegate {
    enum ExplainTableViewCase: Int, CaseIterable {
        case productImage
        case productBuyButton
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ExplainTableViewCase.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ExplainTableViewCase(rawValue: indexPath.section)! {
        case .productImage:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainImageCell.identifier,
                for: indexPath) as! ProductExplainImageCell
            return cell
        case .productBuyButton:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainBuyButtonCell.identifier,
                for: indexPath) as! ProductExplainBuyButtonCell
            return cell
        }
    }
}
