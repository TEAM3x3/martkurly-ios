//
//  RecommendReviewsProductCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/15.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RecommendReviewsProductCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RecommendReviewsProductCell"

    var tappedProductDetailEvent: ((Int) -> Void)?

    var reviewProducts: ReviewProductsModel? {
        didSet { productCollectionView.reloadData() }
    }

    private let lineSpacingValue: CGFloat = 32
    private let sideSpacingValue: CGFloat = 16
    private let itemSpacingValue: CGFloat = 8
    private let collectionViewInset: CGFloat = 4
    private let collectionViewHeight: CGFloat = (UIScreen.main.bounds.width * 1.28)

    private let productListTitleLabel = UILabel().then {
        $0.text = "후기가 좋은 간식"
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear
        configureLayout()
        configureCollectionView()
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

        productCollectionView.register(ReviewsProductCell.self,
                                       forCellWithReuseIdentifier: ReviewsProductCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendReviewsProductCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewProducts?.serializers.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewsProductCell.identifier,
            for: indexPath) as! ReviewsProductCell
        cell.reviewProduct = reviewProducts?.serializers[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendReviewsProductCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - (sideSpacingValue * 2)
        let height = collectionViewHeight - (collectionViewInset * 2)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionViewInset,
                            left: sideSpacingValue,
                            bottom: collectionViewInset,
                            right: sideSpacingValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacingValue
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let reviewProducts = reviewProducts else { return }
        tappedProductDetailEvent?(reviewProducts.serializers[indexPath.item].id)
    }
}

// MARK: - UIScrollViewDelegate

extension RecommendReviewsProductCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        // https://eunjin3786.tistory.com/203
        // 페이지마다 멈출 수 있게
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.productCollectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = self.productCollectionView.cellForItem(at: index)!
        let position = self.productCollectionView.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width / 2 {
           index.row = index.row + 1
        }
        self.productCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}
