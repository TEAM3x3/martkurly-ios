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

    private let detailTableView = UITableView()

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
        detailTableView.register(ProductExplainBuyButtonCell.self,
                                  forCellReuseIdentifier: ProductExplainBuyButtonCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ProductDetailInfoCell: UITableViewDataSource, UITableViewDelegate {
    enum ProductDetailType: Int, CaseIterable {
        case detailExplain
        case detailHappinessCenter
        case detailOrderGuide
        case detailBuyButton
    }

    enum DetailExplainType: Int, CaseIterable {
        case packingSize
        case relationLaw
        case producer
        case productCompose
        case countryOfOrigin
        case storageMethod
        case dateOfProduction
        case consumerCounseling

        var description: String {
            switch self {
            case .packingSize: return "포장단위별 용량(중량), 수량, 크기"
            case .relationLaw: return "관련법상 표시사항"
            case .producer: return "생산자, 수입품의 경우 수입자를 함께 표기"
            case .productCompose: return "상품구성"
            case .countryOfOrigin: return "농수산물의 원산지 표시에 관한 법률에 따른 원산지"
            case .storageMethod: return "보관방법 또는 취급방법"
            case .dateOfProduction: return "제조연월일(포장일 또는 생산연도), 유통기한 또는 품질유지기한"
            case .consumerCounseling: return "소비자상담 관련 전화번호"
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductDetailType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProductDetailType(rawValue: section)! {
        case .detailExplain: return DetailExplainType.allCases.count
        default: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ProductDetailType(rawValue: indexPath.section)! {
        case .detailExplain:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailContentCell.identifier,
                                                     for: indexPath) as! ProductDetailContentCell
            cell.configure(titleText: DetailExplainType(rawValue: indexPath.row)!.description,
                           contentsText: "CONTENTS TEXT")
            return cell
        case .detailHappinessCenter:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailHappinessCenterCell.identifier,
                                                     for: indexPath) as! ProductDetailHappinessCenterCell
            return cell
        case .detailOrderGuide:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailHappinessCenterCell.identifier,
                                                     for: indexPath) as! ProductDetailHappinessCenterCell
            return cell
        case .detailBuyButton:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainBuyButtonCell.identifier,
                for: indexPath) as! ProductExplainBuyButtonCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

import UIKit

class ProductDetailHappinessCenterCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductDetailHappinessCenterCell"

    private let topLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let happinessCenterView = HappinessCenterView()

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
        [topLine, happinessCenterView].forEach {
            self.addSubview($0)
        }

        topLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }

        happinessCenterView.snp.makeConstraints {
            $0.top.equalTo(topLine.snp.bottom).offset(44)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(728)
        }
    }
}
