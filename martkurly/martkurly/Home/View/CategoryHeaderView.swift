//
//  HeaderView.swift
//  NewTableView
//
//  Created by ㅇ오ㅇ on 2020/09/05.
//  Copyright © 2020 shooooting. All rights reserved.
//

import UIKit
import Then

protocol HeaderDelegate: AnyObject {
    func cellHeader(idx: Int)
}

class CategoryHeaderView: UIView {

    var secIndex: Int?
    weak var delegate: HeaderDelegate?

//    lazy var btn: UIButton = {
//        let btn = UIButton()
//        btn.backgroundColor = .white
//        btn.clipsToBounds = true
//        btn.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
//        return btn
//    }()

    let btn = UIButton().then {
        $0.backgroundColor = .white
    }

    var img = UIImageView().then {
        $0.tintColor = .systemGray
    }

    let label = UILabel().then {
        $0.textColor = .systemGray
    }

    var chevron = UIImageView().then {
        $0.tintColor = .systemGray
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {
        backgroundColor = .white

        [btn].forEach {
            addSubview($0)
        }
        [img, label, chevron].forEach {
            btn.addSubview($0)
        }

        btn.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)

        btn.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(self)
        }

        img.snp.makeConstraints {
            $0.centerY.equalTo(btn)
            $0.leading.equalTo(btn).offset(16)
        }

        label.snp.makeConstraints {
            $0.centerY.equalTo(btn)
            $0.leading.equalTo(img.snp.trailing).offset(16)
        }

        chevron.snp.makeConstraints {
            $0.centerY.equalTo(btn)
            $0.trailing.equalTo(btn).inset(16)
        }
    }

    @objc
    func onClickHeaderView(_ sender: UIButton) {
        if let idx = secIndex {
            delegate?.cellHeader(idx: idx)
        }
    }

    func configure(title: String, bool: Bool) {
        label.text = title
        btn.isSelected = bool
    }

}
