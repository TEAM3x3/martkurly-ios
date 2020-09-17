//
//  SearchBarView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    // MARK: - Properties

    lazy var searchTextField = UITextField().then {
        $0.placeholder = "검색어를 입력해 주세요"
        $0.font = .systemFont(ofSize: 18)

        let searchIcon = UIImageView()
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = ColorManager.General.chevronGray.rawValue
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(44)
        }

        $0.leftView = searchIcon
        $0.leftViewMode = .always
        $0.clearButtonMode = .whileEditing
        $0.returnKeyType = .search
    }

    private lazy var searchTextCustomView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8

        $0.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    let cancelButton = UIButton(type: .system).then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.titleLabel?.font = .systemFont(ofSize: 18)
        $0.isEnabled = false
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue
        configureLayout()
    }

    func configureLayout() {
        [searchTextCustomView, cancelButton].forEach {
            self.addSubview($0)
        }

        searchTextCustomView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-12)
        }

        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
}
