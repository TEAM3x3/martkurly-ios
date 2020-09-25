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
    private var cartProduct = [Cart]() {
        didSet { tableV.reloadData() }
    }

    private let navi = CartNaviView().then {
        $0.dismissBtn.addTarget(self, action: #selector(dismissing(_:)), for: .touchUpInside)
    }

    private let tableV = UITableView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

//    private let emptyV = AllSelectButtonLineView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        requestMainData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    let button = KurlyButton(title: "주문하기", style: .purple)

    // MARK: - API

    private let group = DispatchGroup.init()

    func requestMainData() {

        cartListProduct()

    }

    func cartListProduct() {
        group.enter()
        CurlyService.shared.setListCart { cartProduct in
            self.group.leave()
            self.cartProduct = cartProduct
        }
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
        [navi, tableV].forEach {
            view.addSubview($0)
        }

        view.addSubview(button)

        navi.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }

//        navi.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//        }

        tableV.snp.makeConstraints {
            $0.top.equalTo(navi.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(button.snp.top)
        }

//        emptyV.snp.makeConstraints {
//            $0.top.equalTo(navi.snp.bottom)
//            $0.leading.trailing.equalTo(view)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
//        }

        tableV.dataSource = self
        tableV.delegate = self
        tableV.backgroundColor = ColorManager.General.backGray.rawValue
        tableV.separatorStyle = .none

//        tableV.register(AllSelectButtonLineView.self, forCellReuseIdentifier: "cell")

        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().offset(8).inset(8)
            $0.height.equalTo(55)
        }
        button.addTarget(self, action: #selector(emptyBtnTap), for: .touchUpInside)

    }

    @objc
    func emptyBtnTap(_ sender: UIButton) {
        print("주문하기")
    }
}

extension CartVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = AllSelectView()
                cell.selectionStyle = .none
                cell.configure(number: "(0/0)")
                return cell
            } else {
                let cell = CartProductView()
                cell.selectionStyle = .none
                return cell
            }
//        } else if indexPath.section == 1 {
//            let cell = PriceView()
//            cell.selectionStyle = .none
//            return cell
        } else if indexPath.section == 1 {
            let cell = PriceView()
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 50
            } else {
                return 180
            }
        } else if indexPath.section == 1 {
            return 250
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        switch section {
        case 0:
//            if cartProduct > 0 {
                let view = CartHeaderView()
                return view
//            } else {
//                let cell = UIView()
//                return cell
//            }
        default:
            let cell = UIView()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
//            if cartProduct > 0 {
                return 35
//            } else {
//                return 0
//            }
        default:
            return 0
        }
    }
}

extension CartVC: UITableViewDelegate {

}
