//
//  ProductListView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductListView: UIView {

    // MARK: - Properties

    private let sideInset: CGFloat = 12
    private let lineInset: CGFloat = 24

    private let headerType: SortHeaderType
    private var sortHeaderView: ProductListHeaderView!
    private var sortTitleSet: ((String) -> Void)?

    private var seletedType: SortType = .fastArea {
        didSet { sortListTableView.reloadData() }
    }

    private var fastAreaSelectType: FastAreaType = .샛별지역상품
    private var conditionSelectType: ConditionType = .신상품순
    private var benefitSelectType: BenefitType = .혜택순

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var productListCollectionView =
        UICollectionView(frame: .zero,
                         collectionViewLayout: flowLayout)

    private let rowHeightValue: CGFloat = 52
    private let sortListTableView = UITableView()
    private let containerView = UIView()

    var tappedProduct: ((Int) -> Void)?
    var products = [Product]() {
        didSet { productListCollectionView.reloadData() }
    }

    // MARK: - LifeCycle

    init(headerType: SortHeaderType) {
        self.headerType = headerType
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue

        configureLayout()
        configureCollectionView()
        configureSortListTableView()
    }

    func configureLayout() {
        [productListCollectionView, containerView].forEach {
            self.addSubview($0)
        }

        productListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureSortListTableView() {
        sortListTableView.showsVerticalScrollIndicator = false
        sortListTableView.isScrollEnabled = false

        sortListTableView.dataSource = self
        sortListTableView.delegate = self

        sortListTableView.rowHeight = rowHeightValue
        sortListTableView.backgroundColor = .white
        sortListTableView.separatorStyle = .none

        sortListTableView.register(SortListCell.self,
                    forCellReuseIdentifier: SortListCell.identifier)

        containerView.addSubview(sortListTableView)
        containerView.isHidden = true

        containerView.layer.shadowColor = ColorManager.General.chevronGray.rawValue.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 1.0
    }

    func configureCollectionView() {
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.backgroundColor = .clear

        productListCollectionView.register(ProductListHeaderView.self,
                                           forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                           withReuseIdentifier: ProductListHeaderView.identifier)
        productListCollectionView.register(ProductCell.self,
                                           forCellWithReuseIdentifier: ProductCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCell.identifier,
            for: indexPath) as! ProductCell
        cell.product = products[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        sortHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProductListHeaderView.identifier, for: indexPath) as? ProductListHeaderView
        sortHeaderView.initSortType = self.headerType
        sortHeaderView.delegate = self

        sortTitleSet = sortHeaderView.setSortButtonTitle(titleText:)
        return sortHeaderView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 64)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productID = products[indexPath.item].id
        tappedProduct?(productID)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - (sideInset * 3)) / 2
        return CGSize(width: width, height: width * 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: sideInset,
                            bottom: lineInset, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sideInset
    }
}

// MARK: - UITableViewDataSource

extension ProductListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seletedType.sortList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortListCell.identifier, for: indexPath) as! SortListCell

        let cellText = seletedType.sortList[indexPath.row]
        var isSelected = false

        switch seletedType {
        case .fastArea:
            isSelected = cellText == fastAreaSelectType.rawValue ? true : false
        case .condition:
            isSelected = cellText == conditionSelectType.rawValue ? true : false
        case .benefit:
            isSelected = cellText == benefitSelectType.rawValue ? true : false
        }

        cell.configure(cellText: cellText, isSelected: isSelected)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortKey = seletedType.sortList[indexPath.row]

        sortTitleSet?(sortKey)
        containerView.isHidden = true

        switch seletedType {
        case .fastArea:
            fastAreaSelectType = FastAreaType(rawValue: sortKey)!
        case .condition:
            conditionSelectType = ConditionType(rawValue: sortKey)!
        case .benefit:
            benefitSelectType = BenefitType(rawValue: sortKey)!
        }
    }
}

// MARK: - ProductListHeaderViewDelegate

extension ProductListView: ProductListHeaderViewDelegate {
    func tappedSortButton(type: SortType, sortButtonFrame: CGRect, isShow: Bool) {
        containerView.isHidden = !isShow

        if isShow {
            seletedType = type

            containerView.frame = CGRect(x: sortButtonFrame.minX,
                                         y: sortButtonFrame.maxY + 8,
                                         width: sortButtonFrame.width,
                                         height: rowHeightValue * CGFloat(type.sortList.count))
            sortListTableView.frame = containerView.bounds
        }
    }
}
