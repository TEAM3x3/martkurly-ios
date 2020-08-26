//
//  CategoryButtonCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/22.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryButtonView: UIView {

    // MARK: - Properties
    let title = StringManager().categoryTitle
    var btnArray: [UIButton] = []
    var clnArray: [UICollectionView] = []
    var btnSwitch = false
    var btnHeight = 0 {
        didSet {

        }
    }
    var tagNumber = 0
    var height = 0

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
        for i in title.indices {
            let btn = CategoryMainButton()
            btn.configure(
                image: title[i],
                setTitle: title[i])
            btn.tag = i
            btnArray.append(btn)
            addSubview(btnArray[i])
        }

        for i in btnArray.indices {
            print(i)
            btnArray[i].addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            if i == 0 {
                btnArray[i].snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(50)
                }
//                clnArray[i].snp.makeConstraints {
//                    $0.top.equalTo(btnArray[i].snp.bottom)
//                    $0.leading.trailing.equalToSuperview()
//                }
//                clnArray[i].isHidden = true
            } else {
                btnArray[i].snp.makeConstraints {
                    $0.top.equalTo(btnArray[i-1].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }

//                clnArray[i].snp.makeConstraints {
//                    $0.top.equalTo(btnArray[i-1].snp.bottom)
//                    $0.leading.trailing.equalToSuperview()
//                }
//                clnArray[i].isHidden = true
            }
        }
    }

    @objc func selectCategory(_ sender: UIButton) {
        let i = sender.tag
        let select = btnArray[i]
        select.isSelected.toggle()
        if select.isSelected {
            if i != 16 {
                btnArray[i + 1].snp.remakeConstraints {
                    $0.top.equalTo(btnArray[i].snp.bottom).offset(300)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            } else {
                btnArray[16].snp.remakeConstraints {
                    $0.top.equalTo(btnArray[15].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            }
        } else {
            if i != 16 {
                btnArray[i + 1].snp.remakeConstraints {
                    $0.top.equalTo(btnArray[i].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            } else {
                btnArray[16].snp.remakeConstraints {
                    $0.top.equalTo(btnArray[15].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            }
        }
    }
}
