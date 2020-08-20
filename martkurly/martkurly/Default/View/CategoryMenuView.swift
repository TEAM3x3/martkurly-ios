//
//  CategoryCollectionView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

// 상단에 들어가는 카테고리 메뉴
import UIKit

class CategoryMenuView: UIView {

    let tempTitleArray = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "이벤트"]

    // MARK: - Properties

    private let sideInsetValue: CGFloat = 12
    private var isInit = true

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var categoryCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout).then {
            $0.backgroundColor = .white
            $0.dataSource = self
            $0.delegate = self

            $0.register(CategoryCell.self,
                        forCellWithReuseIdentifier: CategoryCell.identifier)
    }

    private let underlineView = UIView().then {
        $0.backgroundColor = ColorManager.General.mainPurple.rawValue
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

    func moveUnderLineVar(indexPath: IndexPath) {
        DispatchQueue.main.async {
            let cell = self.categoryCollectionView.cellForItem(at: indexPath)!

            UIView.animate(withDuration: 0.3) {
                self.underlineView.snp.remakeConstraints {
                    $0.centerX.width.equalTo(cell)
                    $0.bottom.equalToSuperview().offset(-0.3)
                    $0.height.equalTo(4)
                }
                if self.isInit { self.isInit.toggle(); return }
                self.layoutIfNeeded()
            }
        }
    }

    func configureUI() {
        [categoryCollectionView, underlineView].forEach {
            self.addSubview($0)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let bottomLine = UIView()
        bottomLine.backgroundColor = ColorManager.General.chevronGray.rawValue

        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.3)
        }

        let firstIndexPath = IndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: firstIndexPath,
                                          animated: false,
                                          scrollPosition: .centeredHorizontally)
        moveUnderLineVar(indexPath: firstIndexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempTitleArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.identifier,
            for: indexPath) as! CategoryCell
        cell.titleText = tempTitleArray[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveUnderLineVar(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: sideInsetValue, bottom: 0, right: sideInsetValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - (sideInsetValue * 2)) / CGFloat(tempTitleArray.count)
        return CGSize(width: width, height: self.frame.height)
    }
}

// MARK: - UICollectionViewCell

class CategoryCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "CategoryCell"

    var titleText: String? {
        didSet { categoryLabel.text = titleText }
    }

    override var isSelected: Bool {
        didSet {
            categoryLabel.textColor = isSelected ?
                ColorManager.General.mainPurple.rawValue :
                ColorManager.General.mainGray.rawValue
            categoryLabel.font = isSelected ?
                .boldSystemFont(ofSize: 16) :
                .systemFont(ofSize: 16)
        }
    }

    private let categoryLabel = UILabel().then {
        $0.text = "컬리추천"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
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
        self.backgroundColor = .white

        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

enum CategoryType {
    case fixInsetStyle
    case fixNonInsetStyle
    case infinityStyle

//    var sideInset: CGFloat {
//        switch self {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
}
