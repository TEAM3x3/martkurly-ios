//
//  CategoryVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    // MARK: - Properties
    let CategoryMain = CategoryMainView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(
            type: .purpleType,
            isShowCart: true,
            leftBarbuttonStyle: .none,
            titleText: "카테고리")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        view.backgroundColor = .white
        [CategoryMain].forEach {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
