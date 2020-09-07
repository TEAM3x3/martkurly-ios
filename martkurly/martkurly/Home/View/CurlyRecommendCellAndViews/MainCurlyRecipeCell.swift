//
//  MainCurlyRecipeCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/06.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MainCurlyRecipeCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainCurlyRecipeCell"

    private let sidePaddingValue: CGFloat = 20
    private let insetValue: CGFloat = 16

    private let productTitleLabel = UILabel().then {
        $0.text = "컬리의 레시피"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20)
    }

    private let rightAllowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = ColorManager.General.chevronGray.rawValue
        $0.snp.makeConstraints {
            $0.width.equalTo(12)
        }
    }

    private let flowLayout = UICollectionViewFlowLayout().then { $0.scrollDirection = .horizontal }
    private lazy var recipeCollectionView = UICollectionView(frame: .zero,
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
        self.backgroundColor = .white

        let titleStackView = UIStackView(arrangedSubviews:
            [productTitleLabel, rightAllowImageView]).then {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.spacing = 8
        }

        [titleStackView, recipeCollectionView].forEach {
            self.addSubview($0)
        }

        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(sidePaddingValue)
        }

        recipeCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(240)
            $0.bottom.equalToSuperview().offset(-52)
        }
    }

    func configureCollectionView() {
        recipeCollectionView.backgroundColor = .clear
        recipeCollectionView.showsHorizontalScrollIndicator = false

        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self

        recipeCollectionView.register(CurlyRecipeCell.self,
                                      forCellWithReuseIdentifier: CurlyRecipeCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension MainCurlyRecipeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurlyRecipeCell.identifier,
                                                      for: indexPath) as! CurlyRecipeCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainCurlyRecipeCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 240
        let height = collectionView.frame.height - (insetValue * 2)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insetValue, left: sidePaddingValue,
                            bottom: insetValue, right: sidePaddingValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
