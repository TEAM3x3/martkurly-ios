//
//  RecommendProductListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/15.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RecommendProductListCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RecommendProductListCell"

    private let lineSpacingValue: CGFloat = 32
    private let sideSpacingValue: CGFloat = 16
    private let itemSpacingValue: CGFloat = 8
    private let collectionViewHeight: CGFloat = 240

    private let cellCount: Int = 10

    private var productsType: RecommendationType = .basicProductList {
        didSet { productCollectionView.reloadData() }
    }

    private let productListTitleLabel = UILabel().then {
        $0.text = "인기 신상품 랭킹"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18)
    }

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }

    private lazy var productCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear
        configureLayout()
    }

    func configureLayout() {
        [productListTitleLabel, productCollectionView].forEach {
            self.addSubview($0)
        }

        productListTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineSpacingValue)
            $0.leading.equalToSuperview().offset(sideSpacingValue)
        }

        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(productListTitleLabel.snp.bottom).offset(sideSpacingValue)
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(collectionViewHeight)
        }
    }

    func configureCollectionView() {
        productCollectionView.backgroundColor = .clear
        productCollectionView.showsHorizontalScrollIndicator = false

        productCollectionView.dataSource = self
        productCollectionView.delegate = self

        productCollectionView.register(MainEachHProductCell.self,
                                       forCellWithReuseIdentifier: MainEachHProductCell.identifier)
    }

    func configure(titleText: String, productsType: RecommendationType) {
        self.productsType = productsType
        productListTitleLabel.text = titleText
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainEachHProductCell.identifier,
            for: indexPath) as! MainEachHProductCell

        switch self.productsType {
        case .basicProductList:
            cell.configure(isShowRanking: false, isShowBasket: true)
        default:
            cell.configure(isShowRanking: true, isShowBasket: true)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendProductListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: sideSpacingValue, bottom: 0, right: sideSpacingValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacingValue
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width
            - (sideSpacingValue * 2)
            - (itemSpacingValue * 2)) / 3
        return CGSize(width: width, height: self.collectionViewHeight)
    }
}

extension RecommendProductListCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.productCollectionView.indexPathsForVisibleItems
        indexes.sort()

        guard let indexPath = indexes.first else { return }
        let cell = self.productCollectionView.cellForItem(at: indexPath)!

        let item = indexPath.row + ((cell.center.x > scrollView.contentOffset.x) ? 1 : 2)
        let moveIndexPath = IndexPath(item: item,
                                      section: indexPath.section)
        guard self.productCollectionView.cellForItem(at: moveIndexPath) != nil else { return }
        self.productCollectionView.selectItem(at: moveIndexPath,
                                              animated: true,
                                              scrollPosition: .centeredHorizontally)
    }
}
