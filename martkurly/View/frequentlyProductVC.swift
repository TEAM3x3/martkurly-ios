//
//  frequentlyProductVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/12.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class frequentlyProductVC: UIViewController {

    // MARK: - Properties
    var frequentlyCount = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(
            type: .whiteType,
            isShowCart: true,
            leftBarbuttonStyle: .pop,
            titleText: "자주 사는 상품")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        if frequentlyCount > 0 {

        } else {
            let emptyView = FrequentlyProductEmptyView()
            view.addSubview(emptyView)

            emptyView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }

//            emptyView.btn.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        }
    }
}
