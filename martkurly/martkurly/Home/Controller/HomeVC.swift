//
//  HomeVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Properties

    private var cheapProducts = [Product]()
    private var eventList = [EventModel]()
    private var mainEventList = [MainEvent]()
    private var recommendProducts = [ProductDetail]()

    private lazy var menuCategory = CategoryMenuView(categoryType: .fixInsetStyle).then {
        $0.menuTitles = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "이벤트"]
        $0.categorySelected = categorySelected(item:)
    }

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var categoryMenuCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        requestMainData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .purpleType,
                               isShowCart: true,
                               leftBarbuttonStyle: .none)
    }

    // MARK: - API

    private let group = DispatchGroup.init()
    private let queue = DispatchQueue.main

    func requestMainData() {
        self.showIndicate()

        fetchMainDatas()
        fetchCheapProducts()
        fetchEventList()

        group.notify(queue: queue) {
            self.stopIndicate()
            self.categoryMenuCollectionView.reloadData()
        }
    }

    func fetchMainDatas() {
        group.enter()
        CurlyService.shared.fetchMainEventList { mainEventList in
            self.group.leave()
            self.mainEventList = mainEventList
        }

        group.enter()
        CurlyService.shared.fetchRecommendProducts { products in
            self.group.leave()
            self.recommendProducts = products
        }
    }

    func fetchCheapProducts() {
        group.enter()
        CurlyService.shared.fetchCheapProducts { products in
            self.group.leave()
            self.cheapProducts = products
        }
    }

    func fetchEventList() {
        group.enter()
        CurlyService.shared.fetchEventList { eventList in
            self.group.leave()
            self.eventList = eventList
        }
    }

    // MARK: - Actions

    func detailViewProduct(productID: Int) {
        self.showIndicate()
        CurlyService.shared.requestProductDetailData(productID: productID) { reponseData in
            self.stopIndicate()
            let controller = ProductDetailVC()
            controller.hidesBottomBarWhenPushed = true
            controller.productDetailData = reponseData
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tappedEventItem(section: Int) {
        self.showIndicate()
        CurlyService.shared.fetchEventProducts(eventID: eventList[section].id) { eventProducts in
            self.stopIndicate()
            guard let eventProducts = eventProducts else { return }
            let controller = EventProductDetailListVC()
            controller.hidesBottomBarWhenPushed = true
            controller.eventProducts = eventProducts
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tappedEvent(eventID: Int) {
        self.showIndicate()
        CurlyService.shared.fetchMainEventProducts(eventID: eventID) { eventProducts in
            self.stopIndicate()
            let controller = CategoryProductsVC()
            controller.eventProducts = eventProducts
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Helpers

    func configureNavigationBar() {
        // 이미지 이상함...ㅋㅋㅋ 한번 확인 필요
        let titleImageView = UIImageView(image: .martcurlyMainTitleWhiteImage)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }

    func configureUI() {
        view.backgroundColor = .white

        configureNavigationBar()
        configureLayout()
        configureCollectionView()
    }

    func configureLayout() {
        [menuCategory, categoryMenuCollectionView].forEach {
            view.addSubview($0)
        }

        menuCategory.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        categoryMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(menuCategory.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureCollectionView() {
        categoryMenuCollectionView.dataSource = self
        categoryMenuCollectionView.delegate = self
        categoryMenuCollectionView.showsHorizontalScrollIndicator = false
        categoryMenuCollectionView.isPagingEnabled = true
        categoryMenuCollectionView.backgroundColor = .white

        categoryMenuCollectionView.register(CurlyRecommendCell.self,
                                            forCellWithReuseIdentifier: CurlyRecommendCell.identifier)
        categoryMenuCollectionView.register(ProductListCell.self,
                                            forCellWithReuseIdentifier: ProductListCell.identifier)
        categoryMenuCollectionView.register(EventListCell.self,
                                            forCellWithReuseIdentifier: EventListCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainCategoryType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MainCategoryType(rawValue: indexPath.item)! {
        case .curlyRecommend:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurlyRecommendCell.identifier,
                for: indexPath) as! CurlyRecommendCell
            cell.tappedEvent = tappedEvent
            cell.configure(mainEventList: mainEventList,
                           recommendProducts: recommendProducts)
            return cell
        case .newProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
            cell.configure(headerType: .fastAreaAndCondition, products: [])
            return cell
        case .baseProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
                cell.configure(headerType: .fastAreaAndCondition, products: [])
            return cell
        case .cheapProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
                cell.configure(headerType: .fastAreaAndBenefit, products: cheapProducts)
                cell.detailViewProduct = detailViewProduct(productID:)
            return cell
        case .eventProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EventListCell.identifier,
                for: indexPath) as! EventListCell
            cell.tappedEventItem = tappedEventItem(section:)
            cell.eventList = eventList
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categoryMenuCollectionView.frame.width,
                      height: categoryMenuCollectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width)
        menuCategory.moveCategoryIndex = currentPage
    }

    func categorySelected(item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        categoryMenuCollectionView.selectItem(at: indexPath,
                                              animated: true,
                                              scrollPosition: .centeredHorizontally)
        categoryMenuCollectionView.selectItem(at: nil,
                                              animated: false,
                                              scrollPosition: .centeredHorizontally)

//        let controller = ReviewRegisterVC()
//        let naviVC = UINavigationController(rootViewController: controller)
//        naviVC.modalPresentationStyle = .fullScreen
//        self.present(naviVC, animated: true)

//        let controller = ProductOrderVC()
//        controller.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(controller, animated: true)
    }
}
