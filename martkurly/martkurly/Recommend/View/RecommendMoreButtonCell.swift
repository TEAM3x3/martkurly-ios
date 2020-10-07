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
        $0.backgroundColor = .white
    }

    let animationView1 = UIView().then {
        $0.backgroundColor = .martkurlyMainPurpleColor
        $0.alpha = 0.3
        $0.layer.cornerRadius = 2
    }
    let animationView2 = UIView().then {
        $0.backgroundColor = .martkurlyMainPurpleColor
        $0.alpha = 0.3
        $0.layer.cornerRadius = 2
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        beginAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        [titleLabel, animationView1, animationView2, moreButton].forEach {
            self.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
        animationView1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.height.equalTo(moreButton)
            $0.bottom.equalToSuperview().inset(40)
        }
        animationView2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.height.equalTo(moreButton)
            $0.bottom.equalToSuperview().inset(40)
        }
        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(40)
        }
        self.bringSubviewToFront(moreButton)
        self.sendSubviewToBack(animationView2)
        self.sendSubviewToBack(animationView1)
    }

    private func beginAnimating() {
        UIView.animate(withDuration: 2.3,
                       delay: 0,
                       options: [.repeat, .allowUserInteraction],
                       animations: {
                        self.animationView1.transform = CGAffineTransform(scaleX: 1.7, y: 1.6)
                        self.animationView1.alpha = 0
        },
                       completion: nil
        )
        UIView.animate(withDuration: 2.3,
                       delay: 0.6,
                       options: [.repeat, .allowUserInteraction],
                       animations: {
                        self.animationView2.transform = CGAffineTransform(scaleX: 1.7, y: 1.6)
                        self.animationView2.alpha = 0
        },
                       completion: nil
        )

    }
}
