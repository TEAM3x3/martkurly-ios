//
//  KurlyRecommendCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class KurlyRecommendCell: UICollectionViewCell {

    static let identifier = "KurlyRecommendCell"

    private let img = UIImageView()
    private let lbl = UILabel()

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
        [img, lbl].forEach {
            contentView.addSubview($0)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray4.cgColor
        }

        img.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.8)
            $0.width.equalTo(contentView.snp.width)
            $0.bottom.equalTo(lbl.snp.top).inset(1)
        }

        lbl.snp.makeConstraints {
            $0.top.equalTo(img.snp.bottom).offset(1)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.2)
            $0.width.equalTo(contentView.snp.width)
            $0.trailing.bottom.equalToSuperview()
        }
    }

    func configure(image: String, title: String) {
        img.image = UIImage(named: image)
        lbl.text = title
    }
}
