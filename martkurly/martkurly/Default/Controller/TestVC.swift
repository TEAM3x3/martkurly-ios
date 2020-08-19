//
//  TestVC.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    // MARK: - Properties
    let sampleView = KurlyButton(title: "구매하기", style: .purple)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    // MARK: - UI
    func test() {
        view.addSubview(sampleView)
        sampleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
    }
}
