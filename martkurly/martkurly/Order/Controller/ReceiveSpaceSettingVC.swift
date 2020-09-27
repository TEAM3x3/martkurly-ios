//
//  ReceiveSpaceSettingVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReceiveSpaceSettingVC: UIViewController {

    // MARK: - Properties

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = .systemRed
    }

    func configureAttributes() {

    }
}
