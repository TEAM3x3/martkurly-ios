//
//  MainProductListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/04.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MainProductListCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainProductListCell"

    private let sidePaddingValue: CGFloat = 20

    enum ProductListCellType {
        case none
        case rightAllow
        case rightAllowAndSubTitle
    }

    var cellType: ProductListCellType = .none {
        didSet { configure() }
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "오늘의 신상품"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20)
    }

    private let rightAllowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = ColorManager.General.chevronGray.rawValue
        $0.isHidden = true
        $0.snp.makeConstraints {
            $0.width.equalTo(12)
            $0.height.equalTo(20)
        }
    }

    private let productSubTitleLabel = UILabel().then {
        $0.text = "매일 정오, 컬리의 새로운 상품을 만나보세요"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = .systemFont(ofSize: 16)
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
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
    }

    func configureCollectionView() {
        productCollectionView.backgroundColor = .systemPink
    }

    func configure() {
        let titleStackView = UIStackView(arrangedSubviews:
            [productTitleLabel, rightAllowImageView]).then {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.spacing = 8
        }

        let amountStackView = UIStackView(arrangedSubviews: [titleStackView])
        amountStackView.axis = .vertical
        amountStackView.spacing = 8
        amountStackView.alignment = .leading

        switch cellType {
        case .none: break
        case .rightAllowAndSubTitle:
            amountStackView.addArrangedSubview(productSubTitleLabel)
            fallthrough
        case .rightAllow:
            rightAllowImageView.isHidden = false
        }

        [amountStackView, productCollectionView].forEach {
            self.addSubview($0)
        }

        amountStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(sidePaddingValue)
            $0.trailing.equalToSuperview().offset(-sidePaddingValue)
        }

        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(amountStackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(280)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MainProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainProductListCell: UICollectionViewDelegateFlowLayout {

}
