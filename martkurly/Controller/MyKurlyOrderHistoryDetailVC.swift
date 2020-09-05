//
//  MyKurlyOrderHistoryDetailVC.swift
//  martkurly
//
//  Created by Kas Song on 9/5/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyOrderHistoryDetailVC: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurlyOrderHistory.title2.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        setContraints()
    }

    private func setContraints() {

    }
}
