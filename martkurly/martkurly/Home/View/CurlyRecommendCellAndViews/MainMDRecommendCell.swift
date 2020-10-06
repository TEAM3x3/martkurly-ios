//
//  MainMDRecommendCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/06.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MainMDRecommendCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainMDRecommendCell"

    private let sidePaddingValue: CGFloat = 20
    private let lineInsetValue: CGFloat = 24

    var mdRecommendProducts = [MDRecommendModel]() {
        didSet {
            categoryMenuBar.menuTitles = mdRecommendProducts.map { return $0.name }
            categoryContentsCollectionView.reloadData()
        }
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "MD의 추천"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20)
    }

    private lazy var categoryMenuBar = CategoryMenuView(categoryType: .infinityTBLineStyle).then {
        $0.menuTitles = ["추석 선물세트", "채소", "과일・견과・쌀", "수산・해산・건어물",
                         "정육・계란", "국・반찬・메인요리", "샐러드・간편식", "면・양념・오일",
                         "음료・우유・떡・간식", "베이커리・치즈・델리", "건강식품", "생활용품・리빙",
                         "뷰티・바디케어", "주방용품", "가전제품", "베이비・키즈", "반려동물"]
        $0.categorySelected = categorySelected(item:)
    }

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var categoryContentsCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    private lazy var allListViewButton = UIButton(type: .system).then {
        $0.setTitle("채소 전체 보기  〉", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.backgroundColor = ColorManager.General.backGray.rawValue
        $0.layer.cornerRadius = 8
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureContentsCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    func categorySelected(item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        categoryContentsCollectionView.selectItem(at: indexPath,
                                              animated: true,
                                              scrollPosition: .centeredHorizontally)
        categoryContentsCollectionView.selectItem(at: nil, animated: false, scrollPosition: .centeredHorizontally)

        let buttonTitle = mdRecommendProducts[item].name + " 전체 보기  〉"
        allListViewButton.setTitle(buttonTitle, for: .normal)
    }

    // MARK: - Helpers

    func configureContentsCollectionView() {
        categoryContentsCollectionView.backgroundColor = .clear
        categoryContentsCollectionView.isPagingEnabled = true
        categoryContentsCollectionView.showsHorizontalScrollIndicator = false

        categoryContentsCollectionView.dataSource = self
        categoryContentsCollectionView.delegate = self

        categoryContentsCollectionView.register(MDRecommendProductListCell.self,
                                                forCellWithReuseIdentifier: MDRecommendProductListCell.identifier)
    }

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        [productTitleLabel, categoryMenuBar, categoryContentsCollectionView, allListViewButton].forEach {
            self.addSubview($0)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(sidePaddingValue)
            $0.trailing.equalToSuperview().offset(-sidePaddingValue)
        }

        categoryMenuBar.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        categoryContentsCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryMenuBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((280 * 2) + lineInsetValue)
        }

        allListViewButton.snp.makeConstraints {
            $0.top.equalTo(categoryContentsCollectionView.snp.bottom)
            $0.leading.equalToSuperview().offset(sidePaddingValue)
            $0.trailing.equalToSuperview().offset(-sidePaddingValue)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-60)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MainMDRecommendCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMenuBar.menuTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MDRecommendProductListCell.identifier,
            for: indexPath) as! MDRecommendProductListCell
        cell.mdRecommendProduct = mdRecommendProducts[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - (sidePaddingValue * 2)
        let height = collectionView.frame.height - lineInsetValue
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: lineInsetValue, left: sidePaddingValue,
                            bottom: .zero, right: sidePaddingValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sidePaddingValue * 2
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainMDRecommendCell: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width)
        categoryMenuBar.moveCategoryIndex = currentPage

        let buttonTitle = mdRecommendProducts[currentPage].name + " 전체 보기  〉"
        allListViewButton.setTitle(buttonTitle, for: .normal)
    }
}
