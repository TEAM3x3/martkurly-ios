//
//  ProductExplainInInfoCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainInfoCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainInInfoCell"

    private let sideInsetValue: CGFloat = 20
    private let lineSpacingValue: CGFloat = 8
    private let widthValue: CGFloat = 88

    private let infoTitleLabel = UILabel().then {
        $0.text = "알레르기정보"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = .systemFont(ofSize: 16)
    }

    private let infoContentLabel = UILabel().then {
        $0.text = "Content Text"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let infoSubContentLabel = UILabel().then {
        $0.text = "Sub Content Text"
        $0.textColor = ColorManager.General.mainGray.rawValue
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

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        [infoTitleLabel].forEach {
            self.addSubview($0)
        }

        infoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineSpacingValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.width.equalTo(widthValue)
        }
    }

    func configure(infoTitleText: String,
                   infoContentText: String? = nil,
                   infoSubContentText: String? = nil) {
        infoTitleLabel.text = infoTitleText
        infoContentLabel.text = infoContentText
        infoSubContentLabel.text = infoSubContentText

        guard infoSubContentText != nil else {
            viewAddAndSetupLayout(view: infoContentLabel)
            return
        }

        let stack = UIStackView(arrangedSubviews: [infoContentLabel, infoSubContentLabel])
        stack.axis = .vertical
        stack.spacing = 4

        viewAddAndSetupLayout(view: stack)
    }

    func viewAddAndSetupLayout(view: UIView) {
        self.addSubview(view)
        view.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel)
            $0.leading.equalTo(infoTitleLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview().offset(-lineSpacingValue)
        }
    }
}
