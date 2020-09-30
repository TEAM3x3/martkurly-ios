//
//  CurlyRecommendCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

protocol CurlyRecommendDelegate: class {
    func tappedItem(selectedID: Int)
}

class CurlyRecommendCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "CurlyRecommendCell"

    private let bannerHeightValue: CGFloat = 80

    private let recommendTableView = UITableView()

    var tappedEvent: ((Int) -> Void)?

    private var mainEventList = [MainEvent]()
    private var recommendProducts = [ProductDetail]()

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
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(recommendTableView)
        recommendTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        recommendTableView.backgroundColor = .white
        recommendTableView.separatorStyle = .none
        recommendTableView.allowsSelection = false

        recommendTableView.dataSource = self
        recommendTableView.delegate = self

        recommendTableView.register(RecommendImageSliderCell.self,
                                    forCellReuseIdentifier: RecommendImageSliderCell.identifier)
        recommendTableView.register(MainProductListCell.self,
                                    forCellReuseIdentifier: MainProductListCell.identifier)
        recommendTableView.register(MainBannerViewCell.self,
                                    forCellReuseIdentifier: MainBannerViewCell.identifier)
        recommendTableView.register(MainMDRecommendCell.self,
                                    forCellReuseIdentifier: MainMDRecommendCell.identifier)
        recommendTableView.register(MainCurlyRecipeCell.self,
                                    forCellReuseIdentifier: MainCurlyRecipeCell.identifier)
        recommendTableView.register(MainCurlyInfomationCell.self,
                                    forCellReuseIdentifier: MainCurlyInfomationCell.identifier)
    }

    func configure(mainEventList: [MainEvent],
                   recommendProducts: [ProductDetail]) {
        self.mainEventList = mainEventList
        self.recommendProducts = recommendProducts

        self.recommendTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CurlyRecommendCell: UITableViewDataSource {
    enum RecommendCellType: Int, CaseIterable {
        case imageSlideCell
        case productRecommendCell
        case eventNewsCell
        case frugalCell
        case firstBannerCell
        case mdRecommendCell
        case secondBannerCell
        case todayNewerCell
        case hotProductsCell
        case deadlineSaleCell
        case immunityProductsCell
        case curlyRecipeCell
        case deliveryInfoCell
        case curlyInfomationCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return RecommendCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch RecommendCellType(rawValue: section)! {
        case .curlyInfomationCell: return InfoCellType.allCases.count
        default: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch RecommendCellType(rawValue: indexPath.section)! {
        case .imageSlideCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendImageSliderCell.identifier,
                for: indexPath) as! RecommendImageSliderCell
            cell.mainEventList = mainEventList
            cell.delegate = self
            return cell
        case .productRecommendCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .none,
                           backgroundColor: .white,
                           titleText: "이 상품 어때요?")
            cell.productsDetailDatas = recommendProducts
            return cell
        case .eventNewsCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .vertical,
                           titleType: .rightAllow,
                           backgroundColor: ColorManager.General.backGray.rawValue,
                           titleText: "이벤트 소식")
            return cell
        case .frugalCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .rightAllow,
                           backgroundColor: .white,
                           titleText: "알뜰 상품")
            return cell
        case .firstBannerCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainBannerViewCell.identifier,
                for: indexPath) as! MainBannerViewCell
            cell.backgroundColor = .systemRed
            return cell
        case .mdRecommendCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainMDRecommendCell.identifier,
                for: indexPath) as! MainMDRecommendCell
            return cell
        case .secondBannerCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainBannerViewCell.identifier,
                for: indexPath) as! MainBannerViewCell
            cell.backgroundColor = .systemBlue
            return cell
        case .todayNewerCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .rightAllowAndSubTitle,
                           backgroundColor: .white,
                           titleText: "오늘의 신상품",
                           subTitleText: "매일 정오, 컬리의 새로운 상품을 만나보세요")
            return cell
        case .hotProductsCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .rightAllow,
                           backgroundColor: ColorManager.General.backGray.rawValue,
                           titleText: "지금 가장 핫한 상품")
            return cell
        case .deadlineSaleCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .rightAllow,
                           backgroundColor: .white,
                           titleText: "마감세일")
            return cell
        case .immunityProductsCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .rightAllow,
                           backgroundColor: .white,
                           titleText: "면역력 증진",
                           isTopPadding: false)
            return cell
        case .curlyRecipeCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainCurlyRecipeCell.identifier,
                for: indexPath) as! MainCurlyRecipeCell
            return cell
        case .deliveryInfoCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainBannerViewCell.identifier,
                for: indexPath) as! MainBannerViewCell
            cell.backgroundColor = .systemPurple
            return cell
        case .curlyInfomationCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainCurlyInfomationCell.identifier,
                for: indexPath) as! MainCurlyInfomationCell
            cell.configure(cellType: InfoCellType(rawValue: indexPath.row)!)
            return cell
        }
    }
}

extension CurlyRecommendCell: CurlyRecommendDelegate {
    func tappedItem(selectedID: Int) {
        tappedEvent?(selectedID)
    }
}

// MARK: - UITableViewDelegate

extension CurlyRecommendCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch RecommendCellType(rawValue: indexPath.section)! {
        case .imageSlideCell:
            let screenWidth = UIScreen.main.bounds.width
            return screenWidth * 0.92
        case .firstBannerCell, .secondBannerCell, .deliveryInfoCell:
            return bannerHeightValue
        case .curlyInfomationCell:
            let cellType = InfoCellType(rawValue: indexPath.row)!
            switch cellType.cellStyle {
            case .basic, .lastHighlight, .centerHighlight: return 18
            case .custom: return 68
            default: return 20
            }
        default: return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
}
