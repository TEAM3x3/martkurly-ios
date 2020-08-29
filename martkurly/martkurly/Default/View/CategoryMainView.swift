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
    let coverView = UIView()
    let collectionButton = CategoryKurlyRecommendView()

    var headerViewHeightConstraint: NSLayoutConstraint!
    let headerViewMaxHeight: CGFloat = 250
    let headerViewMinHeight: CGFloat = 44

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
//        let guide = self.safeAreaLayoutGuide

        backgroundColor = ColorManager.General.backGray.rawValue
        [backgroundView, frequentlyButton, categoryButton, coverView].forEach {
            addSubview($0)
        }

        coverView.addSubview(collectionButton)

        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        frequentlyButton.snp.makeConstraints {
            $0.top.equalTo(backgroundView).offset(16)
            $0.leading.equalTo(backgroundView)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(categoryButton.snp.top).offset(-16)
        }

        categoryButton.snp.makeConstraints {
            $0.top.equalTo(frequentlyButton.snp.bottom).offset(16)
            $0.width.leading.equalTo(backgroundView)
            $0.bottom.equalToSuperview().offset(-16)
        }

        coverView.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(16)
            $0.height.equalTo((UIScreen.main.bounds.width / 2 * 8) + 16)
            $0.leading.trailing.width.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottom).offset(-16)
        }

//        collectionButton.snp.makeConstraints {
//            $0.top.equalTo(guide.snp.bottom)
//            $0.leading.width.equalToSuperview()
//            $0.height.equalTo((UIScreen.main.bounds.width / 2 * 8) + 16)
//            $0.bottom.equalTo(self.snp.bottom).offset(-16)
//        }

        collectionButton.snp.makeConstraints {
//          $0.top.equalTo(guide.snp.bottom)
            $0.top.leading.width.height.equalToSuperview()
        }
    }
}

extension CategoryMainView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

//        let guide = self.safeAreaLayoutGuide
        print(950 - scrollView.contentOffset.y)
        print(collectionButton.height)
//        print(collectionButton.frame.size.height - collectionButton.height)
        if 950 - scrollView.contentOffset.y < 0 {
            coverView.snp.remakeConstraints {
                $0.top.leading.trailing.bottom.width.height.equalToSuperview()
            }
        }

        print(collectionButton.collection.contentOffset.y)
//        else {
//            coverView.snp.remakeConstraints {
//                $0.top.equalTo(categoryButton.snp.bottom).offset(16)
//                $0.height.equalTo((UIScreen.main.bounds.width / 2 * 8) + 16)
//                $0.leading.trailing.width.equalToSuperview()
//                $0.bottom.equalTo(self.snp.bottom).offset(-16)
//            }
//        }
    }
}
