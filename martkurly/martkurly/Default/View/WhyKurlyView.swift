//
//  WhyKurlyView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class WhyKurlyView: UIView {

    // MARK: - Properties
    private let data = StringManager().whyKurly

    private let whyKurlyLabel = UILabel().then {
        $0.text = StringManager.whyKurly.title.rawValue
        $0.textColor = ColorManager.General.whyKurlyText.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    private let whyKurlyLine = UIView().then {
        $0.backgroundColor = ColorManager.General.separator.rawValue
    }
    private var whyKurlySubviews = [WhyKurlySubView]() // Why Kurly 의 내용이 담긴 Subviews

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
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {

    }

    private func setConstraints() {
        [whyKurlyLabel, whyKurlyLine].forEach {
            self.addSubview($0)
        }
        whyKurlyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        whyKurlyLine.snp.makeConstraints {
            $0.leading.equalTo(whyKurlyLabel.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(whyKurlyLabel)
            $0.height.equalTo(1)
        }
        generateSubviews()
    }

    private func generateSubviews() {
        var isContainInfo = false
        for index in data.indices {
            guard
                let imageName = data[index]["imageName"],
                let iconImage = UIImage(named: imageName),
                let title = data[index]["title"],
                let content = data[index]["content"],
                let info = data[index]["info"]
                else { return }

            let subview = WhyKurlySubView()
            subview.configureView(iconImage: iconImage, title: title, content: content, info: info)
            whyKurlySubviews.append(subview)
            isContainInfo = info == "" ? false : true
            setConstraintsForSubviews(index: index, isContainInfo: isContainInfo)
        }
    }

    private func setConstraintsForSubviews(index: Int, isContainInfo: Bool) {
        self.addSubview(whyKurlySubviews[index])
        if index == 0 {
            whyKurlySubviews[index].snp.makeConstraints {
                $0.top.equalTo(whyKurlyLine.snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview()
                if isContainInfo {
                    $0.height.equalTo(140)
                } else {
                    $0.height.equalTo(125)
                }
            }
        } else {
            whyKurlySubviews[index].snp.makeConstraints {
                $0.top.equalTo(whyKurlySubviews[index - 1].snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview()
                if isContainInfo {
                    $0.height.equalTo(140)
                } else {
                    $0.height.equalTo(125)
                }
            }
        }
    }

}
