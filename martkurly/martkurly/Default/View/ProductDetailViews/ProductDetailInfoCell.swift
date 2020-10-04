//
//  ProductDetailInfoCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductDetailInfoCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductDetailInfoCell"

    private let sideInsetValue: CGFloat = 12

    private let detailTableView = UITableView()

    var productDetailData: ProductDetail? {
        didSet { detailTableView.reloadData() }
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

    // MARK: - Actions

    func tableViewLayoutChanged() {
        detailTableView.beginUpdates()
        detailTableView.endUpdates()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue

        self.addSubview(detailTableView)
        detailTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        detailTableView.allowsSelection = false
        detailTableView.backgroundColor = .clear
        detailTableView.separatorStyle = .none

        detailTableView.dataSource = self
        detailTableView.delegate = self

        detailTableView.register(ProductDetailContentCell.self,
                                 forCellReuseIdentifier: ProductDetailContentCell.identifier)
        detailTableView.register(ProductDetailHappinessCenterCell.self,
                                 forCellReuseIdentifier: ProductDetailHappinessCenterCell.identifier)
        detailTableView.register(ProductDetailOrderGuideCell.self,
                                 forCellReuseIdentifier: ProductDetailOrderGuideCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ProductDetailInfoCell: UITableViewDataSource, UITableViewDelegate {
    enum ProductDetailType: Int, CaseIterable {
        case detailExplain
        case detailHappinessCenter
        case detailOrderGuide
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductDetailType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProductDetailType(rawValue: section)! {
        case .detailExplain:
            guard let productData = productDetailData else { return 0 }
            return productData.details.count
        default: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProductDetailType(rawValue: indexPath.section)! {
        case .detailExplain:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductDetailContentCell.identifier,
                for: indexPath) as! ProductDetailContentCell

            guard let productData = productDetailData else { return cell }
            cell.configure(titleText: productData.details[indexPath.row].detail_title,
                           contentsText: productData.details[indexPath.row].detail_desc)

            return cell
        case .detailHappinessCenter:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductDetailHappinessCenterCell.identifier,
                for: indexPath) as! ProductDetailHappinessCenterCell
            return cell
        case .detailOrderGuide:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductDetailOrderGuideCell.identifier,
                for: indexPath) as! ProductDetailOrderGuideCell
            cell.layoutChangedMethod = tableViewLayoutChanged
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if ProductDetailType.allCases.count - 1 == section {
            return 12
        }
        return .zero
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if ProductDetailType.allCases.count - 1 == section {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
}
