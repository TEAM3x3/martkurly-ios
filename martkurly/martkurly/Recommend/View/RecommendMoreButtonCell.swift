//
//  RecommendMoreButtonCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/07.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RecommendMoreButtonCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RecommendMoreButtonCell"

    private let titleLabel = UILabel().then {
        $0.text = "더 많은 상품이 궁금하다면?"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18)
    }

    let moreButton = UIButton(type: .system).then {
        $0.setTitle("다른 추천 받기", for: .normal)
        $0.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        $0.layer.cornerRadius = 4
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [titleLabel, moreButton].forEach {
            self.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }

        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
