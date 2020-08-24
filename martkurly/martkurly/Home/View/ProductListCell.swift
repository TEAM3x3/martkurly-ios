//
//  ProductListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductListCell"

    private let sideInset: CGFloat = 8
    private let lineInset: CGFloat = 24

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var productListCollectionView = UICollectionView(frame: .zero,
                                                                  collectionViewLayout: flowLayout)

    var sortType: SortType = .fastAreaAndBenefit {
        didSet { sortListTableView.reloadData() }
    }

    private let rowHeightValue: CGFloat = 52
    private lazy var sortListTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false

        $0.dataSource = self
        $0.delegate = self

        $0.rowHeight = rowHeightValue
        $0.backgroundColor = .white
        $0.separatorStyle = .none

        $0.register(SortCell.self,
                    forCellReuseIdentifier: SortCell.identifier)
    }

    private var sortHeaderView: SortHeaderView!
    private lazy var containerView = UIView().then {
        $0.addSubview(sortListTableView)
        $0.isHidden = true

        $0.layer.shadowColor = ColorManager.General.chevronGray.rawValue.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 1.0
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }

    func configureLayout() {
        self.addSubview(productListCollectionView)
        productListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.addSubview(containerView)
    }

    func configureCollectionView() {
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        productListCollectionView.backgroundColor = .clear

        productListCollectionView.register(ProductCell.self,
                                           forCellWithReuseIdentifier: ProductCell.identifier)
        productListCollectionView.register(SortHeaderView.self,
                                           forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                           withReuseIdentifier: SortHeaderView.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        sortHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SortHeaderView.identifier, for: indexPath) as? SortHeaderView
        sortHeaderView.delegate = self
        sortHeaderView.sortType = sortType
        return sortHeaderView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch sortType {
        case .fastArea: fallthrough
        case .fastAreaAndCondition: fallthrough
        case .fastAreaAndBenefit:
            return CGSize(width: collectionView.frame.width, height: 64)
        case .notSort:
            return .zero
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductListCell: UICollectionViewDelegateFlowLayout {
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

extension ProductListCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortType.sortList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SortCell.identifier, for: indexPath) as! SortCell
        cell.sortTitleLabel.text = sortType.sortList[indexPath.row]

        switch sortType {
        case .fastArea:
            cell.sortTitleLabel.textAlignment = .left
        case .fastAreaAndCondition: fallthrough
        case .fastAreaAndBenefit:
            cell.sortTitleLabel.textAlignment = .right
        case .notSort: break
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProductListCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! SortCell
//        print(cell.sortTitleLabel.text)
    }
}

// MARK: - ProductListCell

extension ProductListCell: SortHeaderViewDelegate {
    func tappedSortButton(type: SortType, sortButtonFrame: CGRect, isShow: Bool) {
        if isShow {
            sortType = type

            var xValue: CGFloat = 0
            switch type {
            case .fastArea:
                xValue = sideInset
            case .fastAreaAndCondition: fallthrough
            case .fastAreaAndBenefit:
                xValue = sortButtonFrame.maxX + 8 - 132
            case .notSort:
                xValue = .zero
            }

            containerView.isHidden = false
            containerView.frame = CGRect(x: xValue,
                                         y: sortButtonFrame.maxY + 8,
                                         width: 132,
                                         height: rowHeightValue * CGFloat(type.sortList.count))
            sortListTableView.frame = containerView.bounds
        } else {
            containerView.isHidden = true
        }
    }
}

// MARK: - SortCell

class SortCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SortCell"

    let sortTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }

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
        self.addSubview(sortTitleLabel)
        sortTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
