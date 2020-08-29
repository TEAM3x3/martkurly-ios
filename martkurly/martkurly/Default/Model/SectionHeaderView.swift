//
//  SectionCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    static let identifier = "SectionHeaderView"

    private let view = UIView()
    private let lbl = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        addSubview(view)
        view.addSubview(lbl)
        view.backgroundColor = .white
        lbl.backgroundColor = .white
        view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        lbl.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.equalToSuperview().offset(16)
        }
    }

    func configure(title: String) {
        lbl.text = title
    }
}
