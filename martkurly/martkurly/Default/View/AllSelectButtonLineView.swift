//
//  EmptyCartView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/02.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class AllSelectButtonLineView: UITableViewCell {

    // MARK: - Properties
    private let check = UIButton()
    private let checkImg = UIImageView()

    private let allSelectLabel = UILabel().then {
        $0.adjustsFontSizeToFitWidth = true
    }

    private let deleteBtn = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 3
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    private let lbl = UILabel()

    private let emptyview = UIView().then {
        $0.backgroundColor = .white
    }

    private let emptyLabel = UILabel().then {
        $0.text = "장바구니에 담긴 상품이 없습니다."
        $0.textColor = .black
    }

    private let test = CartProductView()
    private let sumEmpty = PriceView()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        backgroundColor = .clear
        [check, allSelectLabel, deleteBtn, emptyview, emptyLabel, sumEmpty, test].forEach {
            addSubview($0)
        }
        check.addSubview(checkImg)
        deleteBtn.addSubview(lbl)

        check.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(30)
        }
        checkImg.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        checkImg.image = UIImage(systemName: "checkmark.circle")
        checkImg.tintColor = .lightGray
        checkImg.backgroundColor = .clear
        check.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)

        allSelectLabel.snp.makeConstraints {
            $0.centerY.equalTo(check.snp.centerY)
            $0.leading.equalTo(check.snp.trailing).offset(8)
        }
        allSelectLabel.text = "전체선택 (0/0)"
        allSelectLabel.textColor = .black
        allSelectLabel.font = UIFont.systemFont(ofSize: 16)

        deleteBtn.snp.makeConstraints {
            $0.centerY.equalTo(check.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(60)
            $0.height.equalTo(25)
        }
        lbl.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        lbl.text = "선택삭제"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .black

        emptyview.snp.makeConstraints {
            $0.top.equalTo(check.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().offset(8).inset(8)
            $0.height.equalTo(150)
        }

        emptyLabel.snp.makeConstraints {
            $0.centerY.equalTo(emptyview.snp.centerY)
            $0.centerX.equalTo(emptyview.snp.centerX)
        }

//        test.snp.makeConstraints {
//            $0.top.equalTo(check.snp.bottom).offset(32)
//            $0.leading.trailing.equalToSuperview().offset(8).inset(8)
//            $0.height.equalTo(150)
//        }

        sumEmpty.snp.makeConstraints {
            $0.top.equalTo(emptyview.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }

    }

    @objc
    func btnTap(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            checkImg.image = UIImage(systemName: "checkmark.circle.fill")
            checkImg.tintColor = ColorManager.General.mainPurple.rawValue
        } else {
            checkImg.image = UIImage(systemName: "checkmark.circle")
            checkImg.tintColor = .lightGray
        }
    }
}
