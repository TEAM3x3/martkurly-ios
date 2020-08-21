//
//  CategoryMainView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryMainView: UIScrollView {

    // MARK: - Properties
    private let frequentryProduct = UIButton()
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(
        frame: .zero, collectionViewLayout: layout
    )

    let categoryImage = ["thanksGivingDayGift", "Vagetable", "fruitNutRice", "seaFood", "meetEgg", "soupSideDishMainCook", "saladConvenienceFood", "noodleSourceOil", "drinkMilkTteokSnack", "bakeryCheese", "healthFood", "dailyNecessities", "beautyBodycare", "kitchen", "appliances", "babyKid", "companionAnimal"]

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
        setCollectionLayout()
    }

    private func setConstraints() {
        self.backgroundColor = ColorManager.General.backGray.rawValue
        [frequentryProduct].forEach {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
            }
        }
        
        frequentryProduct.backgroundColor = .white
        frequentryProduct.setTitle(StringManager.CategoryTitle.frequentlyProduct.rawValue, for: .normal)
        frequentryProduct.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
        frequentryProduct.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        frequentryProduct.semanticContentAttribute = .forceLeftToRight
        frequentryProduct.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -300)

        frequentryProduct.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(16)
            $0.height.equalTo(50)
        }
    }

    private func setCollectionLayout() {

    }
}

// MARK: - CollectionviewDataSource
//extension CategoryMainView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//    
//    
//}

extension CategoryMainView: UICollectionViewDelegate {

}
