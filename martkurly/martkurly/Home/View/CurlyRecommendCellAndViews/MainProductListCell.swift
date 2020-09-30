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

    var productsDetailDatas = [ProductDetail]() {
        didSet { productCollectionView.reloadData() }
    }

    enum ProductListTitleType {
        case none
        case rightAllow
        case rightAllowAndSubTitle
    }

    enum ProductDirectionType {
        case horizontal
        case vertical
    }

    private var directionType: ProductDirectionType = .horizontal {
        didSet {
            productCollectionView.isScrollEnabled = directionType == .horizontal ? true : false
            productCollectionView.reloadData()
        }
    }

    private let sidePaddingValue: CGFloat = 20
    private let collectionHCellWidth: CGFloat = 150
    private let collectionHCellHeight: CGFloat = 360
    private let collectionVCellHeight: CGFloat = 120
    private let bottomInsetValue: CGFloat = 60

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
        productCollectionView.backgroundColor = .clear
        productCollectionView.showsHorizontalScrollIndicator = false
        productCollectionView.showsVerticalScrollIndicator = false

        productCollectionView.dataSource = self
        productCollectionView.delegate = self

        productCollectionView.register(MainEachHProductCell.self,
                                       forCellWithReuseIdentifier: MainEachHProductCell.identifier)
        productCollectionView.register(MainEachVProductCell.self,
                                       forCellWithReuseIdentifier: MainEachVProductCell.identifier)
    }

    func configure(directionType: ProductDirectionType,
                   titleType: ProductListTitleType,
                   backgroundColor: UIColor,
                   titleText: String,
                   subTitleText: String? = nil,
                   isTopPadding: Bool = true) {
        productTitleLabel.text = titleText
        productSubTitleLabel.text = subTitleText
        self.directionType = directionType
        self.backgroundColor = backgroundColor

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

        switch titleType {
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

        /*
         1000JI
         레이아웃 관련 문제 해결
         https://rhino-developer.tistory.com/entry/iOS-%EC%98%A4%ED%86%A0%EB%A0%88%EC%9D%B4%EC%95%84%EC%9B%83-%EA%B0%80%EC%9D%B4%EB%93%9C-Debugging-Auto-Layout-Debugging-Tricks-and-Tips
         제약 조건과 충돌 하는 경우 해결 방법은 여러가지가 있겠지만 굳이 삭제하지 않고 priority를 999로 낮춰도 충돌 나지 않는다.
         아래에서 높이를 지정해주는데 높이는 Auto로 잡고 있는 부분이랑 충돌이 나는 듯 하다.
         따라서 아래와 같이 낮춰줬더니 워닝이 발생하지 않음 :) 그래도 한번 다시 체크는 해봐야 할 듯 하다.
         */
        amountStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(isTopPadding ? 52 : 12)
            $0.leading.equalToSuperview().offset(sidePaddingValue)
            $0.trailing.equalToSuperview().offset(-sidePaddingValue)
        }

        productCollectionView.snp.remakeConstraints {
            $0.top.equalTo(amountStackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()

            switch directionType {
            case .horizontal:
                $0.height.equalTo(collectionHCellHeight).priority(999)
            case .vertical:
                $0.height.equalTo((collectionVCellHeight * 3)
                    + (sidePaddingValue * 2)
                    + bottomInsetValue).priority(999)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MainProductListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch directionType {
        case .horizontal: return productsDetailDatas.count
        case .vertical: return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch directionType {
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainEachHProductCell.identifier,
                for: indexPath) as! MainEachHProductCell
            cell.productDetailData = productsDetailDatas[indexPath.item]
            return cell
        case .vertical:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainEachVProductCell.identifier,
                for: indexPath) as! MainEachVProductCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch directionType {
        case .horizontal:
            return CGSize(width: collectionHCellWidth, height: collectionHCellHeight)
        case .vertical:
            let collectionVViewWidth: CGFloat = UIScreen.main.bounds.width - (sidePaddingValue * 2)
            return CGSize(width: collectionVViewWidth, height: collectionVCellHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch directionType {
        case .horizontal:
            return UIEdgeInsets(top: 0,
                                left: sidePaddingValue,
                                bottom: 0,
                                right: sidePaddingValue)
        case .vertical:
            return UIEdgeInsets(top: 0,
                                left: sidePaddingValue,
                                bottom: bottomInsetValue,
                                right: sidePaddingValue)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sidePaddingValue
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch directionType {
        case .horizontal:
            NotificationCenter.default
                .post(name: .init(PRODUCT_DETAILVIEW_EVENT),
                      object: productsDetailDatas[indexPath.item].id)
        case .vertical:
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainProductListCell: UICollectionViewDelegateFlowLayout {

}
