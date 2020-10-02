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
            if cartProduct.isEmpty == false {
                tableV.reloadData()
                for i in 1...cartProduct[0].items.count {
                    tapBtnCnt.insert(i)
                }
            }
        }
    }

    private var buttonStr: String? {
        didSet {
            view.addSubview(button)
        }
    }

    lazy var button = KurlyButton(title: buttonStr ?? "주문하기", style: .purple)

    private let navi = CartNaviView().then {
        $0.dismissBtn.addTarget(self, action: #selector(dismissing(_:)), for: .touchUpInside)
    }

    private let tableV = UITableView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private var allCheckingButton = [Cart.Items]() { // 전체선택 버튼
        didSet {
            tableV.reloadData()
        }
    }
    private var cartAllProduct = [Int]()
    private var tapBtnCnt = Set<Int>() {        // cell 셀 버튼 액션
        didSet {
            tableV.reloadData()
            cartAllProduct.append(contentsOf: tapBtnCnt)
        }
    }

    private var checkingButton = true { // 각각의 셀 버튼
        didSet {
            tableV.reloadData()
        }
    }

    private var selectBtnCount = [Cart.Goods]() {
        didSet {
            tableV.reloadData()
        }
    }

    private var productBtn: IndexPath?

    private var selectCount: Int = 0 {
        didSet {
            tableV.reloadData()
        }
    }

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
        tableV.register(CartProductView.self, forCellReuseIdentifier: CartProductView.identifier)

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

// MARK: - DataSource / Delegate
extension CartVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        cartProduct.count + 1

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if cartProduct.count >= 1 {
            switch section {
            case 0:
                return cartProduct[section].items.count + 1
            default:
                return 1
            }
        } else {
            switch section {
            case 0:
                return 2
            default:
                return 1
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch cartProduct.count {
        case 1:
            switch indexPath.section {
            case 0:
                if indexPath.row == 0 {
                    let cell = AllSelectView()
                    cell.check.addTarget(self, action: #selector(allCartTapBtn), for: .touchUpInside)
//                    if cartProduct.count >= 1, allCheckingButton, checkingButton {
                    if cartProduct[indexPath.section].items.count == tapBtnCnt.count {
                        cell.check.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                        cell.check.tintColor = ColorManager.General.mainPurple.rawValue
                        cell.check.isSelected = true
                    } else {
                        cell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                        cell.check.tintColor = .lightGray
                        cell.check.isSelected = false
                    }
                    cell.configure(count: "(\(tapBtnCnt.count)/\(cartProduct[indexPath.section].items.count))")
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: CartProductView.identifier, for: indexPath) as! CartProductView
                    cell.checkBtn.tag = indexPath.row
                    for i in 0...(cartProduct[indexPath.section].items.count - 1) {
                        cell.cartItems = cartProduct[indexPath.section].items[i]
                    }
//                    print(cartProduct[0].items[0].goods.discount_price!)
//                        cell.configure(
//                            title: cartProduct[0].items[0].goods.title,
//                            discount: cartProduct[0].items[0].goods.discount_price!,
//                            product: cartProduct[0].items[0].goods.price,
//                            condition: cartProduct[0].items[0].goods.packing_status)
                    cell.checkBtn.addTarget(self, action: #selector(cellTapBtn), for: .touchUpInside)
                    if cell.checkBtn.isSelected == false, tapBtnCnt.isEmpty == false {
                        cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                        cell.checkBtn.tintColor = ColorManager.General.mainPurple.rawValue
                    } else {
                        cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                        cell.checkBtn.tintColor = .lightGray
                    }
                    return cell
                }
            default:
                let cell = PriceView()
                return cell
            }
        default:
            switch indexPath.section {
            case 0:
                let cell = AllSelectView()
                cell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                cell.check.tintColor = .lightGray
                return cell
            default:
                let cell = PriceView()

                return cell
            }
        }
    }

    // MARK: - 전체선택 버튼
    @objc
    func allCartTapBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.tintColor = ColorManager.General.mainPurple.rawValue
            for i in 1...cartProduct[0].items.count {
                tapBtnCnt.insert(i)
            }
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sender.tintColor = .lightGray
            tapBtnCnt.removeAll()
        }
    }

    // MARK: - 상품만 선택 버튼
    @objc
    func cellTapBtn(_ sender: UIButton) {
        let tag = sender.tag
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sender.tintColor = .lightGray
            tapBtnCnt.remove(tag)
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.tintColor = ColorManager.General.mainPurple.rawValue
            tapBtnCnt.insert(tag)
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
        case 1:
            let view = CartHeaderView()
            view.configure(txt: "\(cartProduct[0].items[1].goods.packing_status) 박스로 배송됩니다 ")
            return view
        default:
            let cell = UIView()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if tapBtnCnt.count >= 1 {
                return 35
            } else {
                return 0
            }
        default:
            return 0
        }
    }
}
