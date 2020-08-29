//
//  CategorySecondButtonView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategorySecondButtonView: UIView {

    // MARK: - Properties
    var btnData: [String] = [] {
        didSet {
            setConstraints()
        }
    }
    var btnArray: [UIButton] = []
    var lblArray: [UILabel] = []

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = ColorManager.General.backGray.rawValue
        for i in btnData.indices {
            let btn = UIButton()
            let lbl = UILabel()
            btn.tag = i
            addSubview(btn)
            addSubview(lbl)
            btn.addTarget(self, action: #selector(selectBtn(_:)), for: .touchUpInside)
            lbl.text = btnData[i]
            lbl.textColor = ColorManager.General.mainGray.rawValue
            btnArray.append(btn)
            lblArray.append(lbl)
            btnArray[i].snp.makeConstraints {
                if i == 0 {
                    $0.top.equalTo(self).offset(12)
                } else {
                    $0.top.equalTo(btnArray[i-1].snp.bottom).offset(8)
                }
                $0.leading.equalToSuperview()
                $0.width.equalTo(UIScreen.main.bounds.width)
                $0.height.equalTo(40)
            }
            lblArray[i].snp.makeConstraints {
                $0.centerY.equalTo(btnArray[i].snp.centerY)
                $0.leading.equalTo(btnArray[i].snp.leading).offset(64)
            }
        }
    }

    @objc func selectBtn(_ sender: UIButton) {
        print("카테고리 세부 버튼")
    }

    func configure(data: [String]) {
        btnData.append(contentsOf: data)
    }
}
