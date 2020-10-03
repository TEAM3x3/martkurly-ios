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
            }
        }
    }

    var button = KurlyButton(title: "주문하기", style: .purple)

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
        willSet {
            tableV.reloadData()
            cartAllProduct.append(contentsOf: tapBtnCnt)
            print(newValue.sorted())
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

    private var headerCell = AllSelectView()
    private var cells = [CartProductView]()
    private var itemNumber = [Int]()

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
        KurlyService.shared.setListCart { cartProduct in
            self.group.leave()
            self.cartProduct = cartProduct
            for i in 0...cartProduct[0].items.count - 1 {
                self.tapBtnCnt.insert(i)
            }
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
                    cell.deleteBtn.addTarget(self, action: #selector(handlerSelectDeleteBtn), for: .touchUpInside)
                    if cartProduct[indexPath.section].items.count == tapBtnCnt.count { // 전체선택 활성화
                        cell.check.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                        cell.check.tintColor = ColorManager.General.mainPurple.rawValue
                        cell.isActive = false
                    } else {
                        cell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                        cell.check.tintColor = .lightGray
                        cell.isActive = true
                    }
                    cell.configure(count: "(\(tapBtnCnt.count)/\(cartProduct[indexPath.section].items.count))")
                    headerCell = cell

                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: CartProductView.identifier, for: indexPath) as! CartProductView
                    cell.tag = indexPath.row - 1
                    cell.checkBtn.tag = indexPath.row - 1
                    cell.customTag = indexPath.row - 1
                    cell.dismissBtn.addTarget(self, action: #selector(deleteBtn), for: .touchUpInside)
                    itemNumber.append(cartProduct[indexPath.section].items[indexPath.row - 1].id)
                    cell.cartItems = cartProduct[indexPath.section].items[indexPath.row - 1]

                    cell.checkBtn.addTarget(self, action: #selector(cellTapBtn), for: .touchUpInside)

                    cell.stepper.addButton.tag = indexPath.row
                    cell.stepper.subtractButton.tag = indexPath.row

                    cell.stepper.addButton.addTarget(self, action: #selector(handlerAddBtn), for: .touchUpInside)
                    cell.stepper.subtractButton.addTarget(self, action: #selector(handlerMinusBtn), for: .touchUpInside)

                    if tapBtnCnt.contains(indexPath.row - 1) {
                        cell.isActive = true
                    } else {
                        cell.isActive = false
                    }
                    return cell
                }
            default:
                if tapBtnCnt.isEmpty != true {
                    let cell = PriceView()
                    var sumTotalPrice: Int = 0 // 상품금액
                    var disCountPrice: Int = 0 // 상품할인금액
                    var shipPrice: Int = 0 //배송비
                    tapBtnCnt.forEach {
                        sumTotalPrice += cartProduct[0].items[$0].discount_payment
                        if cartProduct[0].items[$0].goods.discount_price != nil,
                           let salePrice = cartProduct[0].items[$0].goods.discount_price {
                            disCountPrice += (cartProduct[0].items[$0].quantity * (cartProduct[0].items[$0].goods.price - salePrice))
                        }
                        shipPrice = sumTotalPrice - disCountPrice
                    }
                    cell.configure(sumCount: sumTotalPrice, allSale: disCountPrice, ship: shipPrice)
                    return cell
                } else {
                    let cell = PriceView()
                    return cell
                }
            }
        default:
            switch indexPath.section {
            case 0:
                let cell = AllSelectView()
                cell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                cell.check.tintColor = .lightGray
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        }
    }

    // MARK: - Stepper 빼기 버튼
    @objc
    func handlerMinusBtn(_ sender: UIButton) {
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)

        if let cell = tableV.cellForRow(at: indexPath) as? CartProductView {
            let count = Int(cell.stepper.countLabel.text!)!

            guard count > 1 else {
                return
            }

            cartProduct[0].items[tag - 1].quantity = count - 1

            let total = cell.productTotal
            let productPrice = cell.product
            cell.totalPrice.text = "\(total + productPrice)"
            cartProduct[0].items[tag - 1].discount_payment = total - productPrice
        }
    }

    // MARK: - Stepper 더하기 버튼
    @objc
    func handlerAddBtn(_ sender: UIButton) {
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)

        if let cell = tableV.cellForRow(at: indexPath) as? CartProductView {

            let count = Int(cell.stepper.countLabel.text!)!
            cartProduct[0].items[tag - 1].quantity = count + 1

            let total = cell.productTotal
            let productPrice = cell.product
            cell.totalPrice.text = "\(total + productPrice)"
            cartProduct[0].items[tag - 1].discount_payment = total + productPrice

        }
    }

    // MARK: - 선택 삭제 버튼
    @objc
    func handlerSelectDeleteBtn(_ sender: UIButton) {
        var result = [Int]()
        for index in tapBtnCnt.sorted() {
            let item = itemNumber[index]
            result.append(item)
            print(result)
            KurlyService.shared.deleteCartData(goods: result)
        }
    }

    // MARK: - xMARK 삭제 버튼
    @objc
    func deleteBtn(_ sender: UIButton) {

//        let index = cells[sender.tag].product
//        let result = itemNumber[index]
//        KurlyService.shared.deleteCartData(goods: [result])
    }

    // MARK: - 전체선택 버튼
    @objc
    func allCartTapBtn(_ sender: UIButton) {

        if headerCell.isActive {
            headerCell.check.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            headerCell.check.tintColor = ColorManager.General.mainPurple.rawValue

            for i in 0...(cartProduct[0].items.count - 1) {
                tapBtnCnt.insert(i)
            }
        } else {
            headerCell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            headerCell.check.tintColor = .lightGray
            tapBtnCnt.removeAll()
        }
        print(tapBtnCnt)
    }

    // MARK: - 상품만 선택 버튼
    @objc
    func cellTapBtn(_ sender: UIButton) {
        let tag = sender.tag // [0, 1] [0, 2] => [0, 0] [0, 1]

        let indexPath = IndexPath(row: tag + 1, section: 0)

        if let cell = tableV.cellForRow(at: indexPath) as? CartProductView {
            cell.isActive.toggle()

            if cell.isActive {
                tapBtnCnt.insert(tag)
            } else {
                tapBtnCnt.remove(tag)
            }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
    }
}
