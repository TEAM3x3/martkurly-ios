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

    // MARK: - Properties

    private var isInit = true
    private var categoryType: CategoryType = .fixInsetStyle
    var menuTitles = ["메뉴1", "메뉴2", "메뉴3", "메뉴4", "메뉴5"] {
        didSet { categoryCollectionView.reloadData() }
    }
    var moveCategoryIndex = 0 {
        didSet { moveCategoryEvent() }
    }

    var categorySelected: ((Int) -> Void)?

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var categoryCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout).then {
            $0.backgroundColor = .white
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self

            $0.register(CategoryCell.self,
                        forCellWithReuseIdentifier: CategoryCell.identifier)
    }

    private let underlineView = UIView().then {
        $0.backgroundColor = ColorManager.General.mainPurple.rawValue
    }

    private let rightFadeOutView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0
    }

    private let leftFadeOutView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0
    }

    // MARK: - LifeCycle

    init(categoryType: CategoryType) {
        super.init(frame: .zero)
        self.categoryType = categoryType
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if categoryType == .infinityStyle {
            leftFadeOutViewConfigure()
            rightFadeOutViewConfigure()
            fadeOutConfigure(categoryCollectionView.contentOffset.x)
        }
    }

    // MARK: - Helpers

    func moveCategoryEvent() {
        let indexPath = IndexPath(item: moveCategoryIndex, section: 0)
        categoryCollectionView.selectItem(at: indexPath,
                                          animated: true,
                                          scrollPosition: .centeredHorizontally)
        moveUnderLineVar(indexPath: indexPath)
    }

    func moveUnderLineVar(indexPath: IndexPath) {
        DispatchQueue.main.async {
            let cell = self.categoryCollectionView.cellForItem(at: indexPath)!

            UIView.animate(withDuration: 0.3) {
                self.underlineView.snp.remakeConstraints {
                    $0.centerX.equalTo(cell)
                    $0.width.equalTo(self.categoryType == .fixNonInsetsmallBarStyle ?
                        self.categoryType.underMoveLineWidth : cell)
                    $0.bottom.equalToSuperview().offset(-self.categoryType.bottomLineHeight)
                    $0.height.equalTo(self.categoryType.underMoveLineHeight)
                }
                if self.isInit { self.isInit.toggle(); return }
                self.layoutIfNeeded()
            }
        }
    }

    func leftFadeOutViewConfigure() {
        let gradient = CAGradientLayer()
        gradient.frame = leftFadeOutView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        leftFadeOutView.layer.mask = gradient
    }

    func rightFadeOutViewConfigure() {
        let gradient = CAGradientLayer()
        gradient.frame = rightFadeOutView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        rightFadeOutView.layer.mask = gradient
    }

    func fadeOutConfigure(_ presentOffsetX: CGFloat) {
        let contentOffSetMinX: CGFloat = 5
        let contentOffSetMaxX: CGFloat = (categoryCollectionView.contentSize.width - self.frame.width).rounded() - 5

        UIView.animate(withDuration: 0.3) {
            if presentOffsetX > contentOffSetMinX {
                self.leftFadeOutView.alpha = 1
            } else {
                self.leftFadeOutView.alpha = 0
            }

            if presentOffsetX < contentOffSetMaxX {
                self.rightFadeOutView.alpha = 1
            } else {
                self.rightFadeOutView.alpha = 0
            }
        }
    }

    func configureUI() {
        [categoryCollectionView, underlineView, leftFadeOutView, rightFadeOutView].forEach {
            self.addSubview($0)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        leftFadeOutView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(52)
        }

        rightFadeOutView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(52)
        }

        let topLine = UIView()
        let bottomLine = UIView()

        [topLine, bottomLine].forEach {
            self.addSubview($0)
            $0.backgroundColor = ColorManager.General.chevronGray.rawValue
        }

        topLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(categoryType.topLineHeight)
        }

        bottomLine.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(categoryType.bottomLineHeight)
        }

        let firstIndexPath = IndexPath(item: 0, section: 0)
        DispatchQueue.main.async {
            self.categoryCollectionView.selectItem(at: firstIndexPath,
                                                   animated: false,
                                                   scrollPosition: .centeredHorizontally)
        }
        moveUnderLineVar(indexPath: firstIndexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.identifier,
            for: indexPath) as! CategoryCell
        cell.titleText = menuTitles[indexPath.item]
        cell.categoryType = self.categoryType
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveUnderLineVar(indexPath: indexPath)
        categorySelected?(indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryMenuView: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fadeOutConfigure(scrollView.contentOffset.x)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: categoryType.sideInset,
                            bottom: 0,
                            right: categoryType.sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat!

        switch categoryType {
        case .fixNonInsetsmallBarStyle: fallthrough
        case .fixInsetStyle: fallthrough
        case .fixNonInsetStyle:
            width = (UIScreen.main.bounds.width - (categoryType.sideInset * 2))
                / CGFloat(menuTitles.count)
        case .infinityStyle:
            width = (menuTitles[indexPath.item] as NSString)
                .size(withAttributes: [NSAttributedString.Key.font: categoryType.nonSelectFont])
                .width + 24
        }
        return CGSize(width: width, height: self.frame.height)
    }
}

// MARK: - CategoryCell

class CategoryCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "CategoryCell"

    var titleText: String? {
        didSet { categoryLabel.text = titleText }
    }

    var categoryType: CategoryType = .fixInsetStyle {
        didSet { categoryLabel.font = categoryType.nonSelectFont }
    }

    override var isSelected: Bool {
        didSet {
            categoryLabel.textColor = isSelected ?
                ColorManager.General.mainPurple.rawValue :
                ColorManager.General.mainGray.rawValue
            categoryLabel.font = isSelected ?
                categoryType.selectFont :
                categoryType.nonSelectFont
        }
    }

    private lazy var categoryLabel = UILabel().then {
        $0.text = "컬리추천"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.textAlignment = .center
        $0.font = categoryType.nonSelectFont
        $0.numberOfLines = 2
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
            $0.edges.equalToSuperview()
        }
    }
}
