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
    private lazy var frequentryProduct = UIButton().then {
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
    }
    private let title = UILabel().then {
        $0.text = StringManager.CategoryTitle.frequentlyProduct.rawValue
        $0.textColor = ColorManager.General.mainPurple.rawValue
    }

    private let chevron = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = ColorManager.General.mainPurple.rawValue
    }

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

    // MARK: - ButtonAction
    @objc func nextPage(_ sender: UIButton) {
        print("a")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
        setCollectionLayout()
    }

    private func setConstraints() {
        self.backgroundColor = ColorManager.General.backGray.rawValue
        [frequentryProduct, title, chevron].forEach {
            self.addSubview($0)
        }

        frequentryProduct.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(16)
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }

        title.snp.makeConstraints {
            $0.centerY.equalTo(frequentryProduct)
            $0.leading.equalTo(frequentryProduct).offset(16)
        }

        chevron.snp.makeConstraints {
            $0.centerY.equalTo(frequentryProduct)
            $0.trailing.equalTo(frequentryProduct).inset(16)
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
