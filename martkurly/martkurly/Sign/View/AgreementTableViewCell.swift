//
//  AgreementTableViewCell.swift
//  martkurly
//
//  Created by Doyoung Song on 8/21/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class AgreementTableViewCell: UITableViewCell {

    // MARK: - Properties
    private var cellType: AgreementCellType = .title

    private let checkmark = AgreementCheckMarkView()
    private let title = UILabel()
    private let subtitle = UILabel().then {
        $0.text = "선택 항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다."
        $0.numberOfLines = 0
    }
    private let separator = UIView().then {
        $0.backgroundColor = ColorManager.General.separator.rawValue
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        title.text = "전체 동의합니다."
    }

    private func setConstraints() {
        switch cellType {
        case .title:
            setPropertiesForTitleType()
        case .page:
            setPropertiesForPageType()
        case .choice:
            setPropertiesForChoiceType()
        case .normal:
            setPropertiesForNormalType()
        }
    }

    private func setPropertiesForTitleType() {
        subtitle.textColor = ColorManager.General.mainGray.rawValue

        [checkmark, title, subtitle].forEach {
            self.addSubview($0)
        }
        checkmark.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(checkmark.snp.trailing).offset(8)
            $0.bottom.equalTo(checkmark).offset(-3)
        }
        subtitle.snp.makeConstraints {
            $0.leading.equalTo(checkmark)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(checkmark.snp.bottom).offset(8)
        }
    }

    private func setPropertiesForPageType() {

    }

    private func setPropertiesForChoiceType() {

    }

    private func setPropertiesForNormalType() {

    }

    // MARK: - Helpers
    func configureCell(cellType: AgreementCellType) {
        self.cellType = cellType
    }

}
