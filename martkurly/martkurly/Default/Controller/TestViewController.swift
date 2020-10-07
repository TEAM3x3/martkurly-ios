//
//  TestViewController.swift
//  martkurly
//
//  Created by Kas Song on 10/8/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    // MARK: - Properties
    let button = KurlyButton(title: "다른 추천 받기", style: .white)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
    }

    private func setContraints() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
        }
    }
}
