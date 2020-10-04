//
//  CurlyRecipeCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/06.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CurlyRecipeCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "CurlyRecipeCell"

    private let recipeImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let recipeTitleLabel = UILabel().then {
        $0.text = "티라미수"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
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
        self.backgroundColor = .clear

        [recipeImageView, recipeTitleLabel].forEach {
            self.addSubview($0)
        }

        recipeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        recipeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(recipeImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
