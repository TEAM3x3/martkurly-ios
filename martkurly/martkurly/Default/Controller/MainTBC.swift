//
//  MainTBC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import SnapKit

class MainTBC: UITabBarController {

    // MARK: - Properties

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureTabbar()
        configureTabbarAppearance()
    }

    func configureTabbar() {
        let homeVC = HomeVC()
        let naviHomeVC = UINavigationController(rootViewController: homeVC)
        naviHomeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))

        let recommendVC = RecommendationVC()
        let naviRecommendVC = UINavigationController(rootViewController: recommendVC)
        naviRecommendVC.tabBarItem = UITabBarItem(
            title: "추천",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill"))

        let categoryVC = UIViewController()
        let naviCategoryVC = UINavigationController(rootViewController: categoryVC)
        naviCategoryVC.tabBarItem = UITabBarItem(
            title: "카테고리",
            image: UIImage(systemName: "list.dash"),
            selectedImage: nil)

        let searchVC = UIViewController()
        let naviSearchVC = UINavigationController(rootViewController: searchVC)
        naviSearchVC.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: nil)

        let mykurlyVC = UIViewController()
        let naviMykurlyVC = UINavigationController(rootViewController: mykurlyVC)
        naviMykurlyVC.tabBarItem = UITabBarItem(
            title: "마이컬리",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))

        self.viewControllers = [naviHomeVC, naviRecommendVC, naviCategoryVC, naviSearchVC, naviMykurlyVC]

        // 이하 테스트용
        let testVC = SignUpVC()
        let naviTestVC = UINavigationController(rootViewController: testVC)
        naviTestVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))

        self.viewControllers = [naviTestVC, naviRecommendVC, naviCategoryVC, naviSearchVC, naviMykurlyVC]
    }

    func configureTabbarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .martkurlyMainPurpleColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.martkurlyMainPurpleColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 9)
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9)
        ]

        tabBar.isTranslucent = false
        tabBar.standardAppearance = appearance
    }
}
