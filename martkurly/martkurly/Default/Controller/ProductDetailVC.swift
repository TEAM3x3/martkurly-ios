//
//  ProductDetailVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    // MARK: - Properties

    private let sideInsetValue: CGFloat = 12

    private lazy var catogoryMenuBar = CategoryMenuView(categoryType: .fixNonInsetStyle).then {
        $0.menuTitles = ProductCategoryType.getAllCases(reviewsCount: 50)
        $0.categorySelected = categorySelected(item:)
    }

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var categoryMenuCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    private let productBuyButton = KurlyButton(title: "구매하기", style: .purple)

    var productDetailData: ProductDetail? {
        didSet { categoryMenuCollectionView.reloadData() }
    }

    var isNaviDismiss: Bool = false

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestProductReviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: isNaviDismiss ? .dismiss : .pop,
                                    titleText: productDetailData?.title)
    }

    // MARK: - API

    func requestProductReviews() {
        guard let productDetailData = productDetailData else { return }

        self.showIndicate()
        ReviewService.shared.requestProductReviews(productID: productDetailData.id) { reviews in
            print(reviews)
            self.stopIndicate()
        }
    }

    // MARK: - Selectors

    @objc
    func tappedProductBuyButton(_ sender: UIButton) {
        let controller = ChooseProductsVC()
        controller.productDetailData = productDetailData
        let naviVC = UINavigationController(rootViewController: controller)
        self.present(naviVC, animated: true)
    }

    // MARK: - Actions

    func productReviewWrite() {
        let controller = ProductReviewsListVC()
        let naviVC = UINavigationController(rootViewController: controller)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureLayout()
        configureAttributes()
        configureCollectionView()
    }

    func configureLayout() {
        [catogoryMenuBar, categoryMenuCollectionView, productBuyButton].forEach {
            view.addSubview($0)
        }

        catogoryMenuBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        categoryMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(catogoryMenuBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        productBuyButton.snp.makeConstraints {
            $0.top.equalTo(categoryMenuCollectionView.snp.bottom)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-sideInsetValue)
            $0.height.equalTo(52)
        }
    }

    func configureAttributes() {
        productBuyButton.addTarget(self,
                                   action: #selector(tappedProductBuyButton(_:)),
                                   for: .touchUpInside)
    }

    func configureCollectionView() {
        categoryMenuCollectionView.dataSource = self
        categoryMenuCollectionView.delegate = self
        categoryMenuCollectionView.showsHorizontalScrollIndicator = false
        categoryMenuCollectionView.isPagingEnabled = true
        categoryMenuCollectionView.backgroundColor = .white

        categoryMenuCollectionView.register(ProductExplainCell.self,
                                            forCellWithReuseIdentifier: ProductExplainCell.identifier)
        categoryMenuCollectionView.register(ProductImageCell.self,
                                            forCellWithReuseIdentifier: ProductImageCell.identifier)
        categoryMenuCollectionView.register(ProductDetailInfoCell.self,
                                            forCellWithReuseIdentifier: ProductDetailInfoCell.identifier)
        categoryMenuCollectionView.register(ProductReviewsCell.self,
                                            forCellWithReuseIdentifier: ProductReviewsCell.identifier)
        categoryMenuCollectionView.register(ProductInquiryCell.self,
                                            forCellWithReuseIdentifier: ProductInquiryCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductCategoryType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch ProductCategoryType(rawValue: indexPath.item)! {
        case .productExplain:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductExplainCell.identifier,
                for: indexPath) as! ProductExplainCell
            cell.productDetailData = productDetailData
            return cell
        case .productImage:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductImageCell.identifier,
                for: indexPath) as! ProductImageCell
            cell.productDetailData = productDetailData
            return cell
        case .productDetailInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductDetailInfoCell.identifier,
                for: indexPath) as! ProductDetailInfoCell
            cell.productDetailData = productDetailData
            return cell
        case .productReviews:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductReviewsCell.identifier,
                for: indexPath) as! ProductReviewsCell
            cell.tappedWriteReviewEvent = productReviewWrite
            return cell
        case .productInquiry:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductInquiryCell.identifier,
                for: indexPath) as! ProductInquiryCell
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
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
        catogoryMenuBar.moveCategoryIndex = currentPage
    }

    func categorySelected(item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        categoryMenuCollectionView.selectItem(at: indexPath,
                                              animated: true,
                                              scrollPosition: .centeredHorizontally)
        categoryMenuCollectionView.selectItem(at: nil, animated: false, scrollPosition: .centeredHorizontally)
    }
}
