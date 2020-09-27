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
        didSet {
            tableV.reloadData()
            checkingButton = true
        }
    }

    private var buttonStr: String?

    private let navi = CartNaviView().then {
        $0.dismissBtn.addTarget(self, action: #selector(dismissing(_:)), for: .touchUpInside)
    }

    private let tableV = UITableView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    lazy var button = KurlyButton(title: buttonStr ?? "주문하기", style: .purple)

    private var checkingButton = false

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

    // MARK: - API

    private let group = DispatchGroup.init()
    private let queue = DispatchQueue.main

    func requestMainData() {
        self.showIndicate()

        cartListProduct()

        group.notify(queue: queue) {
            self.stopIndicate()
        }
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
        [navi, tableV, button].forEach {
            view.addSubview($0)
        }

        navi.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }

        tableV.snp.makeConstraints {
            $0.top.equalTo(navi.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(button.snp.top)
        }

        tableV.dataSource = self
        tableV.delegate = self
        tableV.backgroundColor = ColorManager.General.backGray.rawValue
        tableV.separatorStyle = .none

        tableV.register(AllSelectView.self, forCellReuseIdentifier: AllSelectView.identifier)

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
        cartProduct.count + 1
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
                let cell = tableView.dequeueReusableCell(withIdentifier: AllSelectView.identifier, for: indexPath) as! AllSelectView
                cell.selectionStyle = .none
                if cartProduct.count == 1 {
                    cell.configure(cart: "(0/\(cartProduct[0].discount_total_pay))")
                } else {
                    cell.configure(cart: "(0/0)")
                }
                print(cartProduct)
//                cell.configure(cart: "\(cartProduct[0].quantity_of_goods)")
//                cell.check.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
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
            cell.hide = false
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
        switch cartProduct.count {
        case 0:
            let cell = UIView()
            return cell
        default:
            let view = CartHeaderView()
            view.configure(txt: "\(cartProduct[0].items[0].goods.packing_status) 박스로 배송됩니다 ")
            return view
        }
//        switch section {
//        case 0:
//            if cartProduct > 0 {
//                let view = CartHeaderView()
//                return view
//            } else {
//                let cell = UIView()
//                return cell
//            }
//        default:
//            let cell = UIView()
//            return cell
//        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if checkingButton {
                return 35
            } else {
                return 0
            }
        default:
            return 0
        }
    }
}

extension CartVC: UITableViewDelegate {

}
