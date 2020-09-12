//
//  ProductExplainCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainCell"

    private let explainTableView = UITableView()

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
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(explainTableView)
        explainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        explainTableView.backgroundColor = ColorManager.General.backGray.rawValue
        explainTableView.allowsSelection = false
        explainTableView.separatorStyle = .none

        explainTableView.dataSource = self
        explainTableView.delegate = self

        explainTableView.register(ProductExplainBasicCell.self,
                                  forCellReuseIdentifier: ProductExplainBasicCell.identifier)
        explainTableView.register(ProductExplainInfoCell.self,
                                  forCellReuseIdentifier: ProductExplainInfoCell.identifier)
        explainTableView.register(ProductExplainDeliveryInfoCell.self,
                                  forCellReuseIdentifier: ProductExplainDeliveryInfoCell.identifier)
        explainTableView.register(ProductExplainWhyCurlyCell.self,
                                  forCellReuseIdentifier: ProductExplainWhyCurlyCell.identifier)
        explainTableView.register(ProductExplainBuyButtonCell.self,
                                  forCellReuseIdentifier: ProductExplainBuyButtonCell.identifier)
        explainTableView.register(ProductExplainImageCell.self,
                                  forCellReuseIdentifier: ProductExplainImageCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ProductExplainCell: UITableViewDataSource {
    enum ExplainTableViewCase: Int, CaseIterable {
        case productBasic
        case productInfo
        case productDelivery
        case productImage
        case productWhyKurly
        case productBuyButton
    }

    enum ExplainTableInfoCase: Int, CaseIterable {
        case unit
        case weight
        case delivery
        case countryOfOrigin
        case packing
        case allergy
        case expiration

        var description: String {
            switch self {
            case .unit: return "판매단위"
            case .weight: return "중량/용량"
            case .delivery: return "배송구분"
            case .countryOfOrigin: return "원산지"
            case .packing: return "포장타입"
            case .allergy: return "알레르기정보"
            case .expiration: return "유통기한"
            }
        }

        var subContent: String? {
            switch self {
            case .packing: return "택배배송은 에코포장이 스티로폼으로 대체됩니다."
            default: return nil
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ExplainTableViewCase.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ExplainTableViewCase(rawValue: section)! {
        case .productInfo:
            return ExplainTableInfoCase.allCases.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ExplainTableViewCase(rawValue: indexPath.section)! {
        case .productBasic:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainBasicCell.identifier,
                for: indexPath) as! ProductExplainBasicCell
            return cell
        case .productInfo:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainInfoCell.identifier,
                for: indexPath) as! ProductExplainInfoCell
            cell.configure(
                titleText: ExplainTableInfoCase(rawValue: indexPath.row)!.description,
                subContent: ExplainTableInfoCase(rawValue: indexPath.row)?.subContent)
            return cell
        case .productDelivery:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainDeliveryInfoCell.identifier,
                for: indexPath) as! ProductExplainDeliveryInfoCell
            return cell
        case .productImage:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainImageCell.identifier,
                for: indexPath) as! ProductExplainImageCell
            return cell
        case .productWhyKurly:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainWhyCurlyCell.identifier,
                for: indexPath) as! ProductExplainWhyCurlyCell
            return cell
        case .productBuyButton:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainBuyButtonCell.identifier,
                for: indexPath) as! ProductExplainBuyButtonCell
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ProductExplainCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
