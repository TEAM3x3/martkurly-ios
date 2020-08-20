//
//  HomeVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Properties
    let testView = DetailOrderView()
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        view.addSubview(testView)
        testView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .purpleType,
                               isShowCart: true,
                               isShowBack: false)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white

        configureNavigationBar()
    }

    func configureNavigationBar() {
        // 이미지 이상함...ㅋㅋㅋ 한번 확인 필요
        let titleImageView = UIImageView(image: .martcurlyMainTitleWhiteImage)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }

}
