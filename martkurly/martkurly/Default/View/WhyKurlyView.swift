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
    private let whyKurlyLabel = UILabel().then {
        $0.text = StringManager.whyKurly.title.rawValue
        $0.textColor = ColorManager.General.whyKurlyText.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    private let whyKurlyLine = UIView().then {
        $0.backgroundColor = ColorManager.General.separator.rawValue
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
            $0.leading.equalTo(whyKurlyLabel.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(whyKurlyLabel)
            $0.height.equalTo(1)
        }
    }

}
