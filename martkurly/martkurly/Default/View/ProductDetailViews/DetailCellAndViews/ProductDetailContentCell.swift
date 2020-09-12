//
//  ProductDetailContentCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/30.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductDetailContentCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductDetailContentCell"

    private let defaultSidePaddingValue: CGFloat = 8
    private let defaultLinePaddingValue: CGFloat = 12

    private let titleLabel = UILabel().then {
        $0.text = "TITLE TEXT"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
        $0.numberOfLines = 0

        $0.snp.makeConstraints {
            $0.width.equalTo(108)
        }
    }

    private let contentsLabel = UILabel().then {
        $0.text = "CONTENTS TEXT"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentsLabel.sizeToFit()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [titleLabel, contentsLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = defaultSidePaddingValue

        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(defaultLinePaddingValue)
            $0.leading.equalToSuperview().offset(defaultSidePaddingValue)
            $0.bottom.equalToSuperview().offset(-defaultLinePaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultSidePaddingValue)
        }

        let underLine = UIView()
        underLine.backgroundColor = ColorManager.General.mainGray.rawValue

        self.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(defaultSidePaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultSidePaddingValue)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }

    func configure(titleText: String, contentsText: String) {
        titleLabel.text = titleText
        contentsLabel.text = contentsText
    }
}
