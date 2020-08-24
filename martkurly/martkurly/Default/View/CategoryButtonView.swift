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
            let btn = CategoryMainButtonCell()
//            let layout = UICollectionViewFlowLayout()
//            let cln = UICollectionView(
//                frame: .zero, collectionViewLayout: layout
//            )
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            layout.minimumLineSpacing = 0
            btn.configure(
                image: title[i],
                setTitle: title[i])
//            clnArray.append(cln)
//            clnArray[i].tag = i
//            addSubview(clnArray[i])
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
        sender.isSelected.toggle()
        var number = Int()
        if sender.isSelected {
            number = sender.tag
            btnArray[number+1].snp.remakeConstraints {
                $0.top.equalTo(btnArray[number].snp.bottom).offset(300)
                $0.leading.width.equalToSuperview()
                $0.height.equalTo(50)
            }
        } else {
            number = sender.tag
            btnArray[number+1].snp.remakeConstraints {
                $0.top.equalTo(btnArray[number].snp.bottom).offset(0)
                $0.leading.width.equalToSuperview()
                $0.height.equalTo(50)
            }
        }
    }
}
