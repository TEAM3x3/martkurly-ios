//
//  ProductOrderCompleteVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductOrderCompleteVC: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .dismiss,
                                    titleText: "주문완료")
    }

    // MARK: - UI

    private func setConfigure() {

    }
}
