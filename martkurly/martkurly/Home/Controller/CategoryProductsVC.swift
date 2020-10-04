//
//  CategoryProductsVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/17.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CategoryProductsVC: UIViewController {

    // MARK: - Properties

    var eventProducts: MainEventProducts? {
        didSet { configure() }
    }

    private lazy var categoryMenuBar = CategoryMenuView(categoryType: .infinityStyle).then {
        $0.menuTitles = ["테스트", "테스트", "테스트"]
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
        configureCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: .pop,
                                    titleText: eventProducts?.title)
    }

    // MARK: - Actions

    func detailViewProduct(productID: Int) {
        KurlyService.shared.requestProductDetailData(productID: productID) { reponseData in
            let controller = ProductDetailVC()
            controller.hidesBottomBarWhenPushed = true
            controller.productDetailData = reponseData
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        [categoryMenuBar, categoryMenuCollectionView].forEach {
            view.addSubview($0)
        }

        categoryMenuBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        categoryMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryMenuBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func configureCollectionView() {
        categoryMenuCollectionView.backgroundColor = ColorManager.General.backGray.rawValue
        categoryMenuCollectionView.showsHorizontalScrollIndicator = false
        categoryMenuCollectionView.isPagingEnabled = true

        categoryMenuCollectionView.dataSource = self
        categoryMenuCollectionView.delegate = self

        categoryMenuCollectionView.register(ProductListCell.self,
                                            forCellWithReuseIdentifier: ProductListCell.identifier)
    }

    func configure() {
        guard let eventProducts = eventProducts else { return }

        categoryMenuBar.menuTitles.removeAll()
        eventProducts.event.forEach {
            categoryMenuBar.menuTitles.append($0.name)
        }
    }
}

extension CategoryProductsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let eventProducts = eventProducts else { return 0 }
        return eventProducts.event.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductListCell.identifier,
            for: indexPath) as! ProductListCell

        var products = [Product]()
        eventProducts?.event[indexPath.item].mainEvent.forEach {
            products.append($0.goods)
        }
        cell.detailViewProduct = detailViewProduct(productID:)

        cell.configure(headerType: .fastAreaAndCondition, products: products)
        return cell
    }
}

extension CategoryProductsVC: UICollectionViewDelegateFlowLayout {
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
        categoryMenuBar.moveCategoryIndex = currentPage
    }

    func categorySelected(item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        categoryMenuCollectionView.selectItem(at: indexPath,
                                              animated: true,
                                              scrollPosition: .centeredHorizontally)
        categoryMenuCollectionView.selectItem(at: nil,
                                              animated: false,
                                              scrollPosition: .centeredHorizontally)
    }
}
