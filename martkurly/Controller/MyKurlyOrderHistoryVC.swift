//
//  MyKurlyOrderHistoryVC.swift
//  martkurly
//
//  Created by Kas Song on 9/4/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyOrderHistoryVC: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: true, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurly.title.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {

    }
}
