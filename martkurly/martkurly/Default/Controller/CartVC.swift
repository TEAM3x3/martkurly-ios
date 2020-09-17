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

    private let tableV = UITableView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setNavigationBarStatus(type: .whiteType,
//                               isShowCart: false,
//                               leftBarbuttonStyle: .pop,
//                               titleText: "장바구니")
//    }

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
        [navi, tableV].forEach {
            view.addSubview($0)
        }

        navi.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }

        tableV.snp.makeConstraints {
            $0.top.equalTo(navi.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        tableV.dataSource = self
        tableV.delegate = self
        tableV.separatorStyle = .none

        if count > 0 {

        } else {
            let button = KurlyButton(title: "주문하기", style: .purple)
            view.addSubview(button)
            button.snp.makeConstraints {
                $0.bottom.equalToSuperview().inset(48)
                $0.leading.trailing.equalToSuperview().offset(8).inset(8)
                $0.height.equalTo(55)
            }
            button.addTarget(self, action: #selector(emptyBtnTap), for: .touchUpInside)
        }
    }

    @objc
    func emptyBtnTap(_ sender: UIButton) {
        let view = UIView().then {
            $0.backgroundColor = .magenta

        }

    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllSelectButtonLineView()
        cell.selectionStyle = .none
        return cell
    }
}

extension CartVC: UITableViewDelegate {

}
