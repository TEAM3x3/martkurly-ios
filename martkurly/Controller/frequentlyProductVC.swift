//
//  frequentlyProductVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/12.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class frequentlyProductVC: UIViewController {

    var frequentlyCount = [String: Any]()

    private let backView = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

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

    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        if frequentlyCount.count > 0 {

        } else {
            let EmptyView = FrequentlyProductEmptyView()
            view.addSubview(EmptyView)

            EmptyView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }

        }
    }

}
