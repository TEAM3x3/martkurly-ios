//
//  AllSelectView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class AllSelectView: UITableViewCell {

    // MARK: - Propertise

    static let identifier = "AllSelectView"

    private var data = [Cart]()

    var check = UIButton()

    private let allSelectLabel = UILabel().then {
        $0.text = "전체선택"
    }

    var selectNumber = UILabel()

    let deleteBtn = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 3
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    private let lbl = UILabel().then {
        $0.text = "선택삭제"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .black
        $0.textAlignment = .center
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setConstraints()
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConstraints() {
        contentView.backgroundColor = ColorManager.General.backGray.rawValue

        [check, allSelectLabel, selectNumber, deleteBtn].forEach {
            contentView.addSubview($0)
        }

        selectNumber.text = "\(data.count)"

        deleteBtn.addSubview(lbl)

        check.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        allSelectLabel.snp.makeConstraints {
            $0.centerY.equalTo(check.snp.centerY)
            $0.leading.equalTo(check.snp.trailing).offset(8)
        }

        selectNumber.snp.makeConstraints {
            $0.centerY.equalTo(check.snp.centerY)
            $0.leading.equalTo(allSelectLabel.snp.trailing).offset(8)
        }

        deleteBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalTo(check.snp.centerY)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }

        lbl.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        deleteBtn.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)

    }

    @objc
    func deleteAction(_ sender: UIButton) {
        print("A")
    }

    func configure(data: [Cart]) {
        self.data = data
    }
}
