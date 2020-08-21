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
//    let testView = CancelMoreNoticeView()
//    private let menuCategory = CategoryMenuView()

    private lazy var menuCategory = CategoryMenuView(categoryType: .infinityStyle).then {
        $0.menuTitles = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "이벤트", "추가메뉴"]
        $0.categorySelected = categorySelected(item:)
    }
//    private let mainImageCollectionView = HomeMainImageCollectionView()

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .purpleType,
                               isShowCart: true,
                               leftBarbuttonStyle: .none)
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

    enum MainCategoryType: Int, CaseIterable {
        case curlyRecommend
        case newProduct
        case baseProduct
        case cheapProduct
        case eventProduct
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
            return cell
        case .newProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
            return cell
        case .baseProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
            return cell
        case .cheapProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.identifier,
                for: indexPath) as! ProductListCell
            return cell
        case .eventProduct:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EventListCell.identifier,
                for: indexPath) as! EventListCell
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
    }
}
