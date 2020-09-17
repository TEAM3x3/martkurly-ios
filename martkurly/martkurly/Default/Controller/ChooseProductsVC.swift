//
//  ChooseProductsVC.swift
//  martkurly
//
//  Created by Kas Song on 9/17/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ChooseProductsVC: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .dismiss, titleText: "상품 선택")
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {

    }
}
