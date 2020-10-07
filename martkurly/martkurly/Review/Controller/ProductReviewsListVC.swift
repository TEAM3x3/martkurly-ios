//
//  ProductReviewsListVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductReviewsListVC: UIViewController {

    // MARK: - Properties

    private var userPossibleReviews = [CartItem]()
    private var userCompleteReviews = [ReviewModel]()

    private lazy var categoryMenuBar = CategoryMenuView(categoryType: .fixNonInsetTBLineStyle).then {
        $0.menuTitles = ReviewsCategoryType.categoryTitles
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
                                    isShowCart: false,
                                    leftBarbuttonStyle: .dismiss,
                                    titleText: "상품 후기")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestReviewsAPI()
    }

    // MARK: - API

    private let group = DispatchGroup.init()
    private let queue = DispatchQueue.main

    func requestReviewsAPI() {
        self.showIndicate()

        requestPossibleReviews()
        requestCompleteReviews()

        group.notify(queue: queue) {
            self.stopIndicate()
            self.categoryMenuBar.menuTitles = [
                "\(ReviewsCategoryType.possibleReviews.description) (\(self.userPossibleReviews.count))",
                "\(ReviewsCategoryType.completeReviews.description) (\(self.userCompleteReviews.count))"
            ]
            self.categoryMenuBar.moveCategoryIndex = 0
            self.categoryMenuCollectionView.reloadData()
        }
    }

    func requestPossibleReviews() {
        self.group.enter()
        ReviewService.shared.requestUserPossibleReviews { cartItems in
            self.group.leave()
            self.userPossibleReviews = cartItems
        }
    }

    func requestCompleteReviews() {
        self.group.enter()
        ReviewService.shared.requestUserCompleteReviews { reviews in
            self.group.leave()
            self.userCompleteReviews = reviews
        }
    }

    // MARK: - Actions

    func reviewWriteEvent(reviewItem: CartItem) {
        let controller = ReviewRegisterVC()
        controller.reviewItem = reviewItem
        let naviVC = UINavigationController(rootViewController: controller)
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true)
    }

    func moveProductDetailPage(productID: Int) {
        self.showIndicate()
        KurlyService.shared.requestProductDetailData(productID: productID) { productDetailData in
            let controller = ProductDetailVC()
            controller.productDetailData = productDetailData
            controller.isNaviDismiss = true
            let naviVC = UINavigationController(rootViewController: controller)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true, completion: nil)
        }
    }

    func moveReviewDetailPage(reviewData: ReviewModel) {
        let controller = ReviewDetailVC()
        controller.reviewData = reviewData
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = ColorManager.General.backGray.rawValue
        configureLayout()
        configureAttributes()
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
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureAttributes() {

    }

    func configureCollectionView() {
        categoryMenuCollectionView.backgroundColor = .clear
        categoryMenuCollectionView.isPagingEnabled = true

        categoryMenuCollectionView.dataSource = self
        categoryMenuCollectionView.delegate = self

        categoryMenuCollectionView.register(ReviewsWritePossibleCell.self,
                                            forCellWithReuseIdentifier: ReviewsWritePossibleCell.identifier)
        categoryMenuCollectionView.register(ReviewsWriteCompleteCell.self,
                                            forCellWithReuseIdentifier: ReviewsWriteCompleteCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductReviewsListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMenuBar.menuTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch ReviewsCategoryType(rawValue: indexPath.item)! {
        case .possibleReviews:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewsWritePossibleCell.identifier,
                for: indexPath) as! ReviewsWritePossibleCell
            cell.reviewRegisterExecute = reviewWriteEvent
            cell.moveProductDetailPage = moveProductDetailPage(productID:)
            cell.reviewItems = userPossibleReviews
            return cell
        case .completeReviews:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewsWriteCompleteCell.identifier,
                for: indexPath) as! ReviewsWriteCompleteCell
            cell.reviewItems = userCompleteReviews
            cell.moveReviewDetailPage = moveReviewDetailPage(reviewData:)
            return cell
        }
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

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductReviewsListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
