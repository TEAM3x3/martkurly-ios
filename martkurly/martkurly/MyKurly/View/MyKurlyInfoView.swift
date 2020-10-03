//
//  MyKurlyInfoView.swift
//  martkurly
//
//  Created by Kas Song on 9/3/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyInfoView: UIView {

    // MARK: - Properties
    private let userLevelLabel = UILabel().then {
        $0.text = "일반"
        $0.textColor = .martkurlyMainPurpleColor
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.layer.cornerRadius = 3
        $0.layer.borderColor = UIColor.martkurlyMainPurpleColor.cgColor
        $0.layer.borderWidth = 0.8
    }
    let userNameLabel = UILabel().then {
        $0.text = "송도영님"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18.5)
    }
    private let benefitsLabel = UILabel().then {
        $0.text = "적립 0.5%"
        $0.font = UIFont.systemFont(ofSize: 14.5)
        $0.textColor = .black
    }
    private let leftButton = UIButton().then {
        $0.setTitle("전체등급 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14.5, weight: .light)
        $0.backgroundColor = .buttonGray
        $0.layer.cornerRadius = 22
    }
    private let rightButton = UIButton().then {
        $0.setTitle("다음 달 예상등급 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14.5, weight: .light)
        $0.backgroundColor = .buttonGray
        $0.layer.cornerRadius = 22
    }
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [leftButton, rightButton]).then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 15
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {
        [userLevelLabel, userNameLabel, benefitsLabel, buttonStackView].forEach {
            self.addSubview($0)
        }
        userLevelLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(55)
        }
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userLevelLabel.snp.trailing).offset(15)
            $0.centerY.equalTo(userLevelLabel)
        }
        benefitsLabel.snp.makeConstraints {
            $0.leading.equalTo(userLevelLabel)
            $0.top.equalTo(userLevelLabel.snp.bottom).offset(25)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(benefitsLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
    }
}
