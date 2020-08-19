//
//  Extensions.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    static let martkurlyMainPurpleColor = UIColor(red: 85, green: 0, blue: 114)
    static let separatorGray = UIColor(red: 244, green: 244, blue: 244)
    static let textDarkGray = UIColor(red: 82, green: 82, blue: 82) // WhyKurly 회색
    static let backgroundGray = UIColor(red: 243, green: 244, blue: 245) // 배경회색
    static let chevronGray = UIColor(red: 136, green: 137, blue: 138) // chevronGray
    static let textMainGray = UIColor(red: 102, green: 102, blue: 102)
    static let textBlack = UIColor(red: 50, green: 51, blue: 52)
}

extension UIImage {
    static let martcurlyMainTitleWhiteImage = UIImage(named: "Martcurly_MainTitle_White")?.withRenderingMode(.alwaysOriginal)
}

enum NavigationType {
    case purpleType
    case whiteType
}

extension UIViewController {
    // 네비게이션바의 배경색이 보라색이면 .purpleType이고, 카트아이콘이 보이고 싶으면 isShowCart => true
    // titleText는 기본값이 nil 이므로 넣어줘도 되고 안넣어줘도 됨
    func setNavigationBarStatus(type: NavigationType, isShowCart: Bool, titleText: String? = nil) {
        navigationItem.title = titleText
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()

        switch type {
        case .purpleType:
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.barTintColor = .martkurlyMainPurpleColor
            ShoppingCartSingleton.shared.shoppingCartView.configureWhiteMode()
        case .whiteType:
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.barTintColor = .white
            ShoppingCartSingleton.shared.shoppingCartView.configurePurpleMode()
        }

        navigationItem.rightBarButtonItem = isShowCart ?
            UIBarButtonItem(customView: ShoppingCartSingleton.shared.shoppingCartView)
            : nil
    }
}
