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

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
    }

    func configureNavigationBar() {
        setNavigationBarMainColor(type: .purpleType, isShowCart: true, titleText: "테스트")

        // 이미지 이상함...ㅋㅋㅋ 한번 확인 필요
        let titleImageView = UIImageView(image: .martcurlyMainTitleWhiteImage)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }

}
