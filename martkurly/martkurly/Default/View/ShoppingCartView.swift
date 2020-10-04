//
//  ShoppingCartView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ShoppingCartView: UIView {

    // MARK: - Properties

    var basketCount: Int = 0 {
        didSet {
            configure()
        }
    }

    private let cartImageView = UIImageView().then {
        $0.tintColor = .white

        let configuration = UIImage.SymbolConfiguration(
            pointSize: 18,
            weight: .medium,
            scale: .large)
        let symbolImage = UIImage(
            systemName: "cart",
            withConfiguration: configuration)
        $0.image = symbolImage
    }

    private let cartItemCountLabel = UILabel().then {
        $0.text = "0"
        $0.isHidden = true
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 9)
        $0.backgroundColor = .white

        $0.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.greaterThanOrEqualTo(16)
        }
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16 / 2
        $0.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        $0.layer.borderWidth = 2
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configure() {
        if basketCount > 0 {
            cartItemCountLabel.isHidden = false
            cartItemCountLabel.text = "\(basketCount)"

            let width = (cartItemCountLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: cartItemCountLabel.font!]).width + 10

            cartItemCountLabel.snp.remakeConstraints {
                $0.height.equalTo(16)
                $0.width.equalTo(width)
                $0.top.trailing.equalToSuperview()
            }
        } else {
            cartItemCountLabel.isHidden = true
        }
    }

    func configureUI() {
        [cartImageView, cartItemCountLabel].forEach {
            addSubview($0)
        }

        cartImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cartItemCountLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentCart(_:))))
        isUserInteractionEnabled = true
    }

    @objc func presentCart(_ gestureRecognizer: UITapGestureRecognizer) {

//        UIApplication.shared.keyWindow?.rootViewController
        if var presentVC = UIApplication.shared.windows[0].rootViewController {
            while let presentedViewController = presentVC.presentedViewController {
                presentVC = presentedViewController
            }
            let cart = CartVC()
            let navi = UINavigationController(rootViewController: cart)
            navi.modalPresentationStyle = .fullScreen
//            presentVC.present(cart, animated: true, completion: nil)
            presentVC.present(navi, animated: true)
        }
    }

    func configureWhiteMode() {
        cartImageView.tintColor = .white
        cartItemCountLabel.backgroundColor = .white
        cartItemCountLabel.textColor = ColorManager.General.mainPurple.rawValue
        cartItemCountLabel.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
    }

    func configurePurpleMode() {
        cartImageView.tintColor = .black
        cartItemCountLabel.backgroundColor = ColorManager.General.mainPurple.rawValue
        cartItemCountLabel.textColor = .white
        cartItemCountLabel.layer.borderColor = UIColor.white.cgColor
    }
}
