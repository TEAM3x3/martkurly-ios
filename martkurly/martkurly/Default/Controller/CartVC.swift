//
//  CartVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/31.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartVC: UIViewController {

    // MARK: - Properties
    var count = ShoppingCartView().basketCount {
        didSet {
            setConstraints()
        }
    }

    private let navi = CartNaviView().then {
        $0.dismissBtn.addTarget(self, action: #selector(dismissing(_:)), for: .touchUpInside)
    }

    private let emptyView = AllSelectButtonLineView().then {
        $0.backgroundColor = .clear
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }

    // MARK: - Action
    @objc
    func dismissing(_ sender: UIButton) {
        dismiss(animated: true)
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        view.backgroundColor = ColorManager.General.backGray.rawValue
        [navi, emptyView].forEach {
            view.addSubview($0)
        }

        navi.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }

        if count < 0 {

        }

        emptyView.snp.makeConstraints {
            $0.top.equalTo(navi.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }

    }
}
