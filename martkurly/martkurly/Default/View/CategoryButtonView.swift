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
    let btn = CategoryMainButtonCell()
    lazy var btnArray: [UIButton] = []
    lazy var tblArray: [UITableView] = []
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

    override func setNeedsDisplay() {
        setConfigure()
    }
    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {

        for i in title {
            let btn = CategoryMainButtonCell()
            let tbl = DetailTableView()
            tbl.configure(str: StringManager().first)
            btn.configure(
                image: i,
                setTitle: i)
            tblArray.append(tbl)
            addSubview(tbl)
            btnArray.append(btn)
            addSubview(btn)
            btn.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            for i in btnArray.indices {
                if i == 0 {
                    btnArray[i].tag = 0
                    btnArray[i].snp.makeConstraints {
                        $0.top.leading.width.equalToSuperview()
                        $0.height.equalTo(50)
                    }
                    tblArray[i].snp.makeConstraints {
                        $0.top.equalTo(btnArray[i].snp.bottom)
                        $0.leading.width.equalToSuperview()
                        $0.height.equalTo(200)
                    }
                    tblArray[i].isHidden = true
                } else {
                    tagNumber += 1
                    btnArray[i].tag = tagNumber
                    if tblArray[i-1].isHidden == true {
                        btnArray[i].snp.makeConstraints {
                            $0.top.equalTo(btnArray[i-1].snp.bottom)
                            $0.leading.trailing.equalToSuperview()
                            $0.height.equalTo(50)
                        }
                    } else {
                        btnArray[i].snp.makeConstraints {
                            $0.top.equalTo(tblArray[i-1].snp.bottom)
                            $0.leading.trailing.equalToSuperview()
                            $0.height.equalTo(50)
                        }
                    }
                    tblArray[i].snp.makeConstraints {
                        $0.top.equalTo(btnArray[i].snp.bottom)
                        $0.leading.width.equalToSuperview()
                        $0.height.equalTo(300)
                    }
                    tblArray[i].isHidden = true

                }
            }
        }
        print(tblArray)
    }

    @objc func selectCategory(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            //            if sender.tag == 0 {
            //                data.append(contentsOf: StringManager().first)
            //            }
            print("a")
            tblArray[sender.tag].isHidden = false
            DetailTableView().reloadData()
        } else {
            tblArray[sender.tag].isHidden = true
            tblArray[sender.tag].reloadData()
        }
    }
}
