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
        collection.register(KurlyRecommendCell.self, forCellWithReuseIdentifier: KurlyRecommendCell.identifier)
        collection.register(SectionHeaderView.self,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

        collection.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1450)
        }
    }

    private func setLayout() {
        let width = UIScreen.main.bounds.width / 2 - 16

        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

//        layout.headerReferenceSize = CGSize(width: 50, height: 50)
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

extension CategoryKurlyRecommendView: UICollectionViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        height = scrollView.contentOffset.y
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
