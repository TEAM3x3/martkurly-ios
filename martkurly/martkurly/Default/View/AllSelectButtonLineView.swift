//
//  EmptyCartView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/02.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class AllSelectButtonLineView: UIView {

    // MARK: - Properties
    private let check = UIButton().then {
//        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = .systemGray5
    }

    private let allSelectLabel = UILabel().then {
        $0.text = "전체선택 (0/0)"
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = ColorManager.General.mainGray.rawValue
    }

    private let deleteBtn = UIButton().then {
//        $0.titleEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        $0.clipsToBounds = true
        $0.sizeToFit()
        $0.setTitle("선택삭제", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 2
        $0.layer.borderColor = ColorManager.General.mainGray.rawValue.cgColor
    }

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
        [check, allSelectLabel, deleteBtn].forEach {
            addSubview($0)
        }

        check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        check.sizeToFit()
        check.clipsToBounds = true
        check.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
//            $0.width.height.equalTo(40)
        }

        allSelectLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(check.snp.trailing).offset(8)
        }

        deleteBtn.sizeToFit()
        deleteBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }

    }
}
