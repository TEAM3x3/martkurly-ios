//
//  MoreButton.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class MoreButton: UITableViewCell {

    static let identifier = "MoreButton"

    lazy var moreButton = UIButton().then {
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
    }

    private let line = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let buttonTitle = UILabel().then {
        $0.text = "자세히 보기"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = ColorManager.General.mainPurple.rawValue
    }

    private let chevron = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = ColorManager.General.chevronGray.rawValue
    }

    lazy var moreView = CancelMoreNoticeView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let thickLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selector
    @objc func selectButton(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            chevron.image = UIImage(systemName: "chevron.up")
            self.addSubview(moreView)
            moreView.snp.makeConstraints {
                $0.top.equalTo(moreButton.snp.bottom)
                $0.leading.equalToSuperview()
                $0.width.equalTo(self.snp.width)
                $0.height.equalTo(350)
            }
        } else {
            chevron.image = UIImage(systemName: "chevron.down")
            moreView.removeFromSuperview()
        }
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
            $0.top.leading.equalTo(moreButton)
        }

        buttonTitle.snp.makeConstraints {
            $0.centerX.centerY.equalTo(moreButton)
        }

        chevron.snp.makeConstraints {
            $0.centerY.equalTo(moreButton)
            $0.trailing.equalTo(moreButton.snp.trailing).inset(8)
        }

        thickLine.snp.makeConstraints {
            $0.top.equalTo(moreButton.snp.bottom)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
}
