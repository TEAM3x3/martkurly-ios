//
//  Extensions.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

// MARK: - UIColor

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
    static let textDarkGray = UIColor(red: 82, green: 82, blue: 82) // WhyKurly 진한 회색
    static let backgroundGray = UIColor(red: 243, green: 244, blue: 245) // 배경회색
    static let buttonGray = UIColor(red: 241, green: 242, blue: 243)
    static let chevronGray = UIColor(red: 136, green: 137, blue: 138) // chevronGray
    static let textMainGray = UIColor(red: 102, green: 102, blue: 102)
    static let textBlack = UIColor(red: 50, green: 51, blue: 52)
    static let placeholderGray = UIColor(red: 204, green: 204, blue: 204)
    static let warningPink = UIColor(red: 236, green: 70, blue: 100)
    static let checkmarkGray = UIColor(red: 220, green: 221, blue: 222)
    static let chevronForwardGray = UIColor(red: 143, green: 144, blue: 145)
    static let agreementInfoGray = UIColor(red: 151, green: 152, blue: 153)
    static let inactiveButtonColor = UIColor(red: 220, green: 221, blue: 222)
}

// MARK: - UIImage

extension UIImage {
    static let martcurlyMainTitleWhiteImage = UIImage(named: "Martcurly_MainTitle_White")?.withRenderingMode(.alwaysOriginal)
}

// MARK: - UIViewController

extension UIViewController {
    // 네비게이션바의 배경색이 보라색이면 .purpleType이고, 카트아이콘이 보이고 싶으면 isShowCart => true
    // titleText는 기본값이 nil 이므로 넣어줘도 되고 안넣어줘도 됨
    // BackButton이 필요한 경우 isShowBack => true
    func setNavigationBarStatus(type: NavigationBarType,
                                isShowCart: Bool,
                                leftBarbuttonStyle: LeftBarButtonStyle,
                                titleText: String? = nil) {

        navigationItem.title = titleText
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()

        navigationItem.rightBarButtonItem = isShowCart ?
            UIBarButtonItem(customView: ShoppingCartSingleton.shared.shoppingCartView)
            : nil

        let backPopBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tappedPopButton))
        let backDismissBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(tappedDismissButton))

        switch leftBarbuttonStyle {
        case .none: navigationItem.leftBarButtonItem = nil
        case .dismiss: navigationItem.leftBarButtonItem = backDismissBarButton
        case .pop: navigationItem.leftBarButtonItem = backPopBarButton
        }

        switch type {
        case .purpleType:
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.barTintColor = .martkurlyMainPurpleColor
            ShoppingCartSingleton.shared.shoppingCartView.configureWhiteMode()
            backPopBarButton.tintColor = .white
            backDismissBarButton.tintColor = .white
        case .whiteType:
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.barTintColor = .white
            ShoppingCartSingleton.shared.shoppingCartView.configurePurpleMode()
            backPopBarButton.tintColor = .black
            backDismissBarButton.tintColor = .black
        }
    }

    func configureTitleText(titleText: String? = nil) {
        navigationItem.title = titleText
    }

    @objc
    func tappedPopButton() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    func tappedDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UILabel {

    // 줄간격 세팅
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = .center

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
}
