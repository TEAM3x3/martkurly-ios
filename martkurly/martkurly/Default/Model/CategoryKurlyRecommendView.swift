//
//  CategoryKurlyRecommend.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryKurlyRecommendView: UITableViewCell {

    // MARK: - Properties
    private let layout = UICollectionViewFlowLayout()
    lazy var collection = UICollectionView(
        frame: .zero, collectionViewLayout: layout
    )

    private let insetValue: CGFloat = 8
    private let paddingValue: CGFloat = 16

    var height: CGFloat = 0 {
        didSet {
//            CategoryMainView().collectionButton.reloadInputViews()
        }
    }
    private let titleData = StringManager().kurlyRecommend

    // MARK: - Lifecycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setConfigure()
//        largeContentTitle = "컬리의 선택"
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        addSubview(collection)
        setLayout()

        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.isSpringLoaded = true
        collection.isScrollEnabled = false
        collection.register(KurlyRecommendCell.self, forCellWithReuseIdentifier: KurlyRecommendCell.identifier)
        collection.register(SectionHeaderView.self,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

        collection.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1600)
        }
    }

    private func setLayout() {
        let width = (UIScreen.main.bounds.width - (insetValue) - (paddingValue * 2)) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = insetValue
        layout.minimumInteritemSpacing = insetValue
        layout.sectionInset = UIEdgeInsets(top: 0, left: paddingValue,
                                           bottom: 0, right: paddingValue)

        layout.sectionHeadersPinToVisibleBounds = true
    }
}

extension CategoryKurlyRecommendView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KurlyRecommendCell.identifier, for: indexPath) as! KurlyRecommendCell
        cell.configure(
            image: "TestImage",
            title: "  \(titleData[indexPath.row])")
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
//        header.configure(title: "컬리의 추천")
//        return header
//    }
}

extension CategoryKurlyRecommendView: UICollectionViewDelegateFlowLayout {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        height = scrollView.contentOffset.y
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
