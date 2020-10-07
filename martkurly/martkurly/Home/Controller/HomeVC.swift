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
    private var bestProducts = [Product]()
    private var eventList = [EventModel]()

    private var mainEventList = [MainEvent]()
    private var recommendProducts = [Product]()
    private var sqaureEvents = [EventSqaureModel]()
    private var salesProducts = [Product]()
    private var newProducts = [Product]()
    private var healthProducts = [Product]()
    private var mdRecommendProducts = [MDRecommendModel]()

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
        fetchMainCategoryProducts()
        fetchHomeCategoryList()

        group.notify(queue: queue) {
            self.stopIndicate()
            self.categoryMenuCollectionView.reloadData()
        }
    }

    func fetchMainDatas() {
        group.enter()
        KurlyService.shared.fetchMainEventList { mainEventList in
            self.group.leave()
            self.mainEventList = mainEventList
        }

        group.enter()
        KurlyService.shared.fetchRecommendProducts { products in
            self.group.leave()
            self.recommendProducts = products
        }
    }

    func fetchMainCategoryProducts() {
        group.enter()
        KurlyService.shared.fetchProducts(requestURL: REF_SALES_PRODUCTS) { products in
            self.group.leave()
            self.salesProducts = products
        }

        group.enter()
        KurlyService.shared.fetchProducts(requestURL: REF_HEALTH_PRODUCTS) { products in
            self.group.leave()
            self.healthProducts = products
        }

        group.enter()
        KurlyService.shared.fetchSqaureEventList { sqaureEvents in
            self.group.leave()
            self.sqaureEvents = sqaureEvents
        }

        group.enter()
        KurlyService.shared.fetchMDRecommendProducts { recommendProducts in
            self.mdRecommendProducts = recommendProducts
            self.group.leave()
        }
    }

    func fetchHomeCategoryList() {
        group.enter()
        KurlyService.shared.fetchNewProducts { products in
            self.group.leave()
            self.newProducts = products
        }

        group.enter()
        KurlyService.shared.fetchCheapProducts { products in
            self.group.leave()
            self.cheapProducts = products
        }

        group.enter()
        KurlyService.shared.fetchBestProducts { products in
            self.group.leave()
            self.bestProducts = products
        }

        group.enter()
        KurlyService.shared.fetchEventList { eventList in
            self.group.leave()
            self.eventList = eventList
        }
    }

    // MARK: - Selectors

    @objc
    func moveProductDetailView(_ noti: Notification) {
        guard let productID = noti.object as? Int else { return }
        detailViewProduct(productID: productID)
    }

    @objc
    func moveSqaureEventView(_ noti: Notification) {
        guard let eventID = noti.object as? Int else { return }
        let controller = EventProductDetailListVC()
        controller.hidesBottomBarWhenPushed = true
        controller.eventProducts = EventProducts(id: sqaureEvents[eventID].id,
                                                 title: sqaureEvents[eventID].title,
                                                 goods: sqaureEvents[eventID].goods)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Actions

    func detailViewProduct(productID: Int) {
        self.showIndicate()
        KurlyService.shared.requestProductDetailData(productID: productID) { reponseData in
            self.stopIndicate()
            let controller = ProductDetailVC()
            controller.hidesBottomBarWhenPushed = true
            controller.productDetailData = reponseData
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tappedEventItem(eventID: Int) {
        self.showIndicate()
        KurlyService.shared.fetchEventProducts(eventID: eventID) { eventProducts in
            self.stopIndicate()
            guard let eventProducts = eventProducts else { return }
            let controller = EventProductDetailListVC()
            controller.hidesBottomBarWhenPushed = true
            controller.eventProducts = eventProducts
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tappedMainEvent(eventID: Int) {
        self.showIndicate()
        KurlyService.shared.fetchMainEventProducts(eventID: eventID) { eventProducts in
            self.stopIndicate()
            let controller = CategoryProductsVC()
            controller.eventProducts = eventProducts
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Helpers

    func configureAttributes() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(moveProductDetailView),
                         name: .init(PRODUCT_DETAILVIEW_EVENT),
                         object: nil)

        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(moveSqaureEventView(_:)),
                         name: .init(SQAURE_EVENT),
                         object: nil)
    }

    func configureNavigationBar() {
        let titleImageView = UIImageView(image: .martcurlyMainTitleWhiteImage)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }

    func configureUI() {
        configureAttributes()
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
            cell.tappedMainEvent = tappedMainEvent
            cell.tappedBannerEvent = tappedEventItem(eventID:)
            cell.configure(mainEventList: mainEventList,
                           recommendProducts: recommendProducts,
                           salesProducts: salesProducts,
                           bannerEvent: eventList,
                           healthProducts: healthProducts,
                           sqaureEvents: sqaureEvents,
                           mdRecommendProducts: mdRecommendProducts)
            return cell
        case .newProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
            cell.configure(headerType: .fastAreaAndCondition, products: newProducts)
            cell.detailViewProduct = detailViewProduct(productID:)
            return cell
        case .baseProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
            cell.configure(headerType: .fastAreaAndCondition, products: bestProducts)
            cell.detailViewProduct = detailViewProduct(productID:)
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
            cell.tappedEventItem = tappedEventItem(eventID:)
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
                                              animated: true, scrollPosition: .centeredHorizontally)
        categoryMenuCollectionView.selectItem(at: nil,
                                              animated: false,
                                              scrollPosition: .centeredHorizontally)

//        let controller = ReviewRegisterVC()
//        let naviVC = UINavigationController(rootViewController: controller)
//        naviVC.modalPresentationStyle = .fullScreen
//        self.present(naviVC, animated: true)

        let controller = ProductOrderVC()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
