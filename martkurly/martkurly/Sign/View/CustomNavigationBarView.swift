//
//  CustomNavigationBarView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CustomNavigationBarView: UIView {

    // MARK: - Properties
    private let title = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    private let leftBarButton = UIButton().then {
        let image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
    }
    private let separator = UIView().then {
        $0.backgroundColor = ColorManager.General.separator.rawValue
    }
    private var viewController: UIViewController?

    // MARK: - Lifecycle
    init(title: String, viewController: UIViewController) {
        super.init(frame: .zero)
        self.title.text = title
        self.viewController = viewController
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        self.leftBarButton.addTarget(self, action: #selector(handleLeftBarButton(_:)), for: .touchUpInside)
    }

    private func setConstraints() {
        [title, leftBarButton, separator].forEach {
            self.addSubview($0)
        }
        title.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        leftBarButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    // MARK: - Helpers
    private func dismissVC(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    // MARK: - Selectors
    @objc
    private func handleLeftBarButton(_ sender: UIButton) {
        guard let viewController = viewController else { return }
        dismissVC(viewController: viewController)
    }
}
