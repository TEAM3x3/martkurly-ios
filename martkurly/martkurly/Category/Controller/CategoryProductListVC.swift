//
//  CategoryProductListVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CategoryProductListVC: UIViewController {

    // MARK: - Properties

    private var category: Category?

    private let categoryMenuBar = CategoryMenuView(categoryType: .infinityStyle)

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var categoryMenuCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let category = category else { return }
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: .pop,
                                    titleText: category.name)
    }

    // MARK: - Actions

    func tappedProductDetail(productID: Int) {
        self.showIndicate()

        KurlyService.shared.requestProductDetailData(productID: productID) { productDetailData in
            self.stopIndicate()
            let controller = ProductDetailVC()
            controller.hidesBottomBarWhenPushed = true
            controller.productDetailData = productDetailData
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = ColorManager.General.backGray.rawValue

        [categoryMenuBar, categoryMenuCollectionView].forEach {
            self.view.addSubview($0)
        }

        categoryMenuBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        categoryMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryMenuBar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureAttributes() {
        categoryMenuBar.categorySelected = categorySelected(item:)

        categoryMenuCollectionView.dataSource = self
        categoryMenuCollectionView.delegate = self
        categoryMenuCollectionView.showsHorizontalScrollIndicator = false
        categoryMenuCollectionView.isPagingEnabled = true
        categoryMenuCollectionView.backgroundColor = .white

        categoryMenuCollectionView.register(ProductListCell.self,
                                            forCellWithReuseIdentifier: ProductListCell.identifier)
    }

    func configure(category: Category?,
                   categoryTypeNumbering: Int) {
        guard let category = category else { return }
        self.category = category
        categoryMenuBar.menuTitles = category.types.map { $0.name }
        categoryMenuBar.moveCategoryIndex = categoryTypeNumbering

        DispatchQueue.main.async {
            self.categoryMenuCollectionView.selectItem(
                at: IndexPath(item: categoryTypeNumbering, section: 0),
                animated: false,
                scrollPosition: .centeredHorizontally)
        }
    }
}

extension CategoryProductListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.types.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductListCell.identifier,
            for: indexPath) as! ProductListCell
        cell.configure(headerType: .fastAreaAndRecommend,
                       products: category?.types[indexPath.item].products ?? [])
        cell.detailViewProduct = tappedProductDetail(productID:)
        return cell
    }
}

extension CategoryProductListVC: UICollectionViewDelegateFlowLayout {
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
