//
//  MDRecommendProductListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/06.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MDRecommendProductListCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "MDRecommendProductListCell"

    private let itemSpacingValue: CGFloat = 8
    private let itemHeight: CGFloat = 280

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var mdProductsCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear

        [mdProductsCollectionView].forEach {
            self.addSubview($0)
        }

        mdProductsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureCollectionView() {
        mdProductsCollectionView.backgroundColor = .clear
        mdProductsCollectionView.isScrollEnabled = false

        mdProductsCollectionView.dataSource = self
        mdProductsCollectionView.delegate = self

        mdProductsCollectionView.register(MainEachHProductCell.self,
                                          forCellWithReuseIdentifier: MainEachHProductCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension MDRecommendProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainEachHProductCell.identifier, for: indexPath) as! MainEachHProductCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - (itemSpacingValue * 2)) / 3
        return CGSize(width: width, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacingValue
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MDRecommendProductListCell: UICollectionViewDelegateFlowLayout {

}
