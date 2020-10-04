//
//  GrayCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

protocol CustomCellDelegate: class {
    func tappedCategoryType(categoryNumbering: Int, categoryTypeNumbering: Int)
}

class CustomCell: UITableViewCell {

    static let identifier = "CustomCell"

    weak var delegate: CustomCellDelegate?

    let stackView = UIStackView()

    let mainTitle = CategoryHeaderV()
    let subView = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Helpers

    func configure(category: Category) {
        selectionStyle = .none

        mainTitle.configure(image: category.category_img,
                            setTitle: category.name,
                            direction: "chevron.down")

        mainTitle.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }

        stackView.addArrangedSubview(mainTitle)

        for i in category.types.indices {
            let btn = UIButton()
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
            btn.contentHorizontalAlignment = .left
            btn.setTitle(category.types[i].name, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(setSubTitle(_:)), for: .touchUpInside)
            subView.addSubview(btn)
            btn.snp.makeConstraints {
                $0.top.equalTo(subView.snp.top).offset(50 * i)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            subView.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(50 * category.types.count)
            }
            stackView.addArrangedSubview(subView)
        }

        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.axis = .vertical

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Action

    @objc
    func setSubTitle(_ sender: UIButton) {
        delegate?.tappedCategoryType(categoryNumbering: self.tag,
                                     categoryTypeNumbering: sender.tag)
    }
}
