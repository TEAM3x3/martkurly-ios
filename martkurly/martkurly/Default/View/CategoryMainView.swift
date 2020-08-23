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

    private let backgroundView = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    let frequentlyButton = frequentlyProductButtonCell()
    let categoryButton = CategoryButtonView()

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionV = UICollectionView(
        frame: .zero, collectionViewLayout: layout
    )

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
        backgroundColor = ColorManager.General.backGray.rawValue
        [backgroundView, frequentlyButton, categoryButton].forEach {
            addSubview($0)
        }

        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(self)
            $0.height.equalTo(1600)
        }

        frequentlyButton.snp.makeConstraints {
            $0.top.equalTo(backgroundView).offset(16)
            $0.leading.equalTo(backgroundView)
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }

        categoryButton.snp.makeConstraints {
            $0.top.equalTo(frequentlyButton.snp.bottom).offset(16)
            $0.leading.equalTo(backgroundView)
            $0.width.equalToSuperview()
            $0.height.equalTo(900)
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
