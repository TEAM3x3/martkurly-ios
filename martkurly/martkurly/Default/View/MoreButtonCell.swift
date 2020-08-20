//
//  MoreButton.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class MoreButtonCell: UITableViewCell {

    let moreButton = UIView().then {
        $0.backgroundColor = .systemBackground
    }

    private let line = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let buttonTitle = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = ColorManager.General.mainPurple.rawValue
    }

    var chevron = UIImageView().then {
        $0.tintColor = ColorManager.General.chevronGray.rawValue
    }

    lazy var moreView = CancelMoreNoticeView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    let thickLine = UIView().then {
        $0.backgroundColor = .systemBackground
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        [moreButton, line, chevron, buttonTitle, thickLine].forEach {
            self.addSubview($0)
        }

        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottom)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(50)
        }

        line.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(self.snp.width)
            $0.top.equalTo(moreButton.snp.top)
            $0.leading.equalTo(moreButton)
        }

        buttonTitle.snp.makeConstraints {
            $0.centerX.centerY.equalTo(moreButton)
        }

        chevron.snp.makeConstraints {
            $0.centerY.equalTo(moreButton)
            $0.trailing.equalTo(moreButton.snp.trailing).inset(8)
        }

        thickLine.snp.makeConstraints {
            $0.bottom.equalTo(moreButton.snp.bottom)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(10)
        }
    }

    func configure(text: String, image: UIImage, color: UIColor) {
        buttonTitle.text = text
        chevron.image = image
        thickLine.backgroundColor = color
    }
}
