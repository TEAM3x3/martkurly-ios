//
//  RecommendationVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RecommendationVC: UIViewController {

    // MARK: - Properties

    private lazy var tapped: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.frame = CGRect(x: 0, y: 300, width: 200, height: 40)
        button.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)
        return button
    }()

    @objc func clickedButton(_ sender: UIButton) {
        ShoppingCartSingleton.shared.shoppingCartView.basketCount += 1
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarMainColor(type: .purpleType, isShowCart: true, titleText: "추천")
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .blue
        view.addSubview(tapped)
    }
}
