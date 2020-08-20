//
//  SignUpVC.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setNavigationBarStatus(type: .whiteType, isShowCart: false, isShowBack: true, titleText: StringManager.Sign.signUp.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {

    }

    private func setConstraints() {

    }

}
