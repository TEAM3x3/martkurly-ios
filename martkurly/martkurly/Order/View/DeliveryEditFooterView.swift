//
//  DeliveryEditFooterView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DeliveryEditFooterView: UITableViewHeaderFooterView {

    // MARK: - Properties

    static let identifier = "DeliveryEditFooterView"

    private let footerContentView = UIView().then {
        $0.backgroundColor = .white
    }

    let deleteButton = UIButton(type: .system).then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }

    let editButton = UIButton(type: .system).then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        $0.isEnabled = false
    }

    private let lineView = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    // MARK: - LifeCycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.addSubview(footerContentView)
        footerContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        [deleteButton, editButton, lineView].forEach {
            footerContentView.addSubview($0)
        }

        editButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }

        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(editButton.snp.leading).offset(-orderVCSideInsetValue)
        }

        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func configureAttributes() {

    }
}
