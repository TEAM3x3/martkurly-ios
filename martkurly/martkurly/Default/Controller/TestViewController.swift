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
    let animationView1 = UIView().then {
        $0.backgroundColor = .martkurlyMainPurpleColor
        $0.alpha = 0.45
        $0.layer.cornerRadius = 2
    }
    let animationView2 = UIView().then {
        $0.backgroundColor = .martkurlyMainPurpleColor
        $0.alpha = 0.45
        $0.layer.cornerRadius = 2
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }

    private func setContraints() {
        view.addSubview(animationView1)
        view.addSubview(animationView2)
        view.addSubview(button)
        animationView1.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(130)
            $0.height.equalTo(55)
        }
        animationView2.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(130)
            $0.height.equalTo(55)
        }
        button.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(130)
            $0.height.equalTo(55)
        }
    }

    @objc
    private func handleButton() {
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       options: [.repeat, .allowUserInteraction],
                       animations: {
                        self.animationView1.transform = CGAffineTransform(scaleX: 1.45, y: 1.45)
                        self.animationView1.alpha = 0
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
        UIView.animate(withDuration: 2.0,
                       delay: 0.5,
                       options: [.repeat, .allowUserInteraction],
                       animations: {
                        self.animationView2.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
                        self.animationView2.alpha = 0
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
}
