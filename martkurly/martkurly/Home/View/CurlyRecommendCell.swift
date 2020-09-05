//
//  CurlyRecommendCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CurlyRecommendCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "CurlyRecommendCell"

    private let bannerHeightValue: CGFloat = 80

    private let recommendTableView = UITableView()

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
        case deliveryInfoCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return RecommendCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch RecommendCellType(rawValue: indexPath.section)! {
        case .imageSlideCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendImageSliderCell.identifier,
                for: indexPath) as! RecommendImageSliderCell
            return cell
        case .productRecommendCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.configure(directionType: .horizontal,
                           titleType: .none,
                           backgroundColor: .white,
                           titleText: "이 상품 어때요?")
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
                           titleText: "면역력 증진")
            return cell
        case .deliveryInfoCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainBannerViewCell.identifier,
                for: indexPath) as! MainBannerViewCell
            cell.backgroundColor = .systemPurple
            return cell
        }
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
        default: return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
}

import UIKit

class MainMDRecommendCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainMDRecommendCell"

    private let sidePaddingValue: CGFloat = 20

    private let productTitleLabel = UILabel().then {
        $0.text = "MD의 추천"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20)
    }

    private let categoryMenuBar = CategoryMenuView(categoryType: .infinityTBLineStyle).then {
        $0.menuTitles = ["추석 선물세트", "채소", "과일・견과・쌀", "수산・해산・건어물",
                         "정육・계란", "국・반찬・메인요리", "샐러드・간편식", "면・양념・오일",
                         "음료・우유・떡・간식", "베이커리・치즈・델리", "건강식품", "생활용품・리빙",
                         "뷰티・바디케어", "주방용품", "가전제품", "베이비・키즈", "반려동물"]
    }

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
        [productTitleLabel, categoryMenuBar].forEach {
            self.addSubview($0)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(sidePaddingValue)
            $0.trailing.equalToSuperview().offset(-sidePaddingValue)
        }

        categoryMenuBar.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}

import UIKit

class MainBannerViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainBannerViewCell"

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
    }
}
