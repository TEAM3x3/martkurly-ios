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
            if cartProduct.isEmpty == false { tableV.reloadData() }
        }
    }

    private var selectProduct = [CartItem]()         // 선택한 상품
    private var orderMainPaymentPrice = 0            // 주문 금액
    private var orderDiscountPaymentPrice = 0        // 상품 할인 금액
    private var orderProductPaymentPrice = 0         // 상품 금액
    private var orderDeliveryPaymentPrice = 0        // 배송비
    private var orderAmountPaymentPrice = 0          // 최종 결제 금액

    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)
        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    let btnTotalAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.black
    ]

    var button = KurlyButton(title: "주문하기", style: .purple)

    private let tableV = UITableView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private var cartAllProduct = [Int]()
    private var tapBtnCnt = Set<Int>() {        // cell 셀 버튼 액션
        willSet {
            tableV.reloadData()
            cartAllProduct.append(contentsOf: tapBtnCnt)
            print(newValue.sorted())
            selectProduct.removeAll()
            tapBtnCnt.forEach {
                selectProduct.append(cartProduct[0].items[$0])
            }
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
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .dismiss,
                                    titleText: "장바구니")
    }

    // MARK: - API
    private let group = DispatchGroup.init()
    private let queue = DispatchQueue.main

    private func requestMainData() {
        self.showIndicate()

        cartListProduct()

        group.notify(queue: queue) {
            self.stopIndicate()
        }
    }

    private func cartListProduct() {
        print(#function)
        group.enter()
        KurlyService.shared.setListCart { cartProduct in
            self.group.leave()
            self.cartProduct = cartProduct
            if cartProduct.isEmpty == true {

            } else {
                for i in 0...cartProduct[0].items.count - 1 {
                    self.tapBtnCnt.insert(i)
                }
                self.tapBtnCnt.forEach {
                    self.selectProduct.append(cartProduct[0].items[$0])
                }
            }
        }
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        view.backgroundColor = ColorManager.General.backGray.rawValue
        [tableV, button].forEach {
            view.addSubview($0)
        }

        tableV.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        if selectProduct.isEmpty == false {
            let order = ProductOrderVC()
            order.orderData = selectProduct
            order.orderMainPaymentPrice = orderMainPaymentPrice
            order.orderDiscountPaymentPrice = orderDiscountPaymentPrice
            order.orderProductPaymentPrice = orderProductPaymentPrice
            order.orderDeliveryPaymentPrice = orderDeliveryPaymentPrice
            order.orderAmountPaymentPrice = orderAmountPaymentPrice
            navigationController?.pushViewController(order, animated: true)
        } else {
            print("주문할 상품을 선택하세요.")
        }
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
// MARK: - CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch cartProduct.count {
            case 1:
                switch indexPath.section {
                case 0:
                    if indexPath.row == 0 {
                        let cell = AllSelectView()
                        if cartProduct[indexPath.section].items.count == tapBtnCnt.count, cartProduct[indexPath.section].items.isEmpty == false { // 전체선택 활성화
                            cell.check.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                            cell.check.tintColor = ColorManager.General.mainPurple.rawValue
                            cell.isActive = false
                        } else {
                            cell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                            cell.check.tintColor = .lightGray
                            cell.isActive = true
                        }

                        if cartProduct[indexPath.section].items.isEmpty == false {
                            cell.check.addTarget(self, action: #selector(allCartTapBtn), for: .touchUpInside)
                        } else {
                            cell.check.addTarget(self, action: #selector(allCartTapBtn), for: .touchCancel)
                        }

                        if tapBtnCnt.isEmpty == true {
                            cell.deleteBtn.addTarget(self, action: #selector(handlerSelectDeleteBtn), for: .touchCancel)
                        } else {
                            cell.deleteBtn.addTarget(self, action: #selector(handlerSelectDeleteBtn), for: .touchUpInside)
                        }

                        cell.configure(count: "(\(tapBtnCnt.count)/\(cartProduct[indexPath.section].items.count))")
                        headerCell = cell
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: CartProductView.identifier, for: indexPath) as! CartProductView
                        cell.tag = indexPath.row - 1
                        cell.checkBtn.tag = indexPath.row - 1
                        cell.customTag = indexPath.row - 1

                        cell.dismissBtn.tag = indexPath.row - 1
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
                        var freeShipping: Int = 0 // 3000원 일지? 0원 일지?
                        var orderBtnPrice: Int = 0 // 주문하기 버튼 가격

                        for i in 0...tapBtnCnt.count - 1 {
                            sumTotalPrice += cartProduct[0].items[i].discount_payment
                            if cartProduct[0].items[i].goods.discount_price != nil,
                               let salePrice = cartProduct[0].items[i].goods.discount_price {
                                disCountPrice += (cartProduct[0].items[i].quantity * (cartProduct[0].items[i].goods.price - salePrice))
                            }

                            shipPrice = sumTotalPrice - disCountPrice
                            if shipPrice > 40000 {
                                freeShipping = 0
                            } else {
                                freeShipping = 3000
                            }
                        }

                        orderBtnPrice = sumTotalPrice - disCountPrice + freeShipping

                        let priceStr = NSMutableAttributedString(
                            string: (formatter.string(for: orderBtnPrice as NSNumber) ?? "0" ),
                            attributes: btnTotalAttributes)

                        let priceLabel = UILabel().then {
                            $0.attributedText = priceStr
                        }
                        cell.configure(sumCount: sumTotalPrice, allSale: disCountPrice, ship: shipPrice)
                        orderMainPaymentPrice = sumTotalPrice - disCountPrice
                        orderDiscountPaymentPrice = disCountPrice
                        orderProductPaymentPrice = sumTotalPrice
                        if orderMainPaymentPrice < 40000 {
                            orderDeliveryPaymentPrice = 3000
                        }
                        orderAmountPaymentPrice = orderMainPaymentPrice + orderDeliveryPaymentPrice

                        button.setTitle("\(priceLabel.text!)원" + " 주문하기", for: .normal)

                        return cell
                    } else {
                        let cell = PriceView()
                        button.setTitle("주문하기", for: .normal)
                        return cell
                    }
                }
            default:
                switch indexPath.section {
                case 0:
                    switch indexPath.row {
                    case 0:
                        let cell = AllSelectView()
                        return cell
                    default:
                        let cell = CartEmptyView()
                        return cell
                    }
                default:
                    let cell = PriceView()
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

            let goods = cell.cartItems!.id
            let quantity = count - 1
            let cart = 1

            KurlyService.shared.cartUpdata(goods: goods, quantity: quantity, cart: cart)

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

            let goods = cell.cartItems!.id
            let quantity = count + 1
            let cart = 1

            KurlyService.shared.cartUpdata(goods: goods, quantity: quantity, cart: cart)
        }

    }

    // MARK: - 선택 삭제 버튼
    @objc
    func handlerSelectDeleteBtn(_ sender: UIButton) {

        let alert = UIAlertController(title: "선택된 상품을 삭제하시겠습니까?", message: .none, preferredStyle: UIAlertController.Style.alert)
        let delete = UIAlertAction(title: "삭제", style: .destructive, handler: { (_) in
            var inArr = [Int]()
            for i in self.tapBtnCnt {
                inArr.append(self.cartProduct[0].items[i].id)
            }
            print("inArr", inArr)
            KurlyService.shared.deleteCartData(goods: inArr)
            print("self.cartProduct[0].items.count", self.cartProduct[0].items.count)
//            self.tapBtnCnt.sorted()
            print("self.tapBtnCnt", self.tapBtnCnt)
            if self.tapBtnCnt.count == self.cartProduct[0].items.count {
                self.cartProduct[0].items.removeAll()
                self.tapBtnCnt.removeAll()
            } else {
                for i in self.tapBtnCnt.sorted().reversed() {
                    self.cartProduct[0].items.remove(at: i)
                }

                self.tapBtnCnt.removeAll()

                for i in 0...self.cartProduct[0].items.count - 1 {
                    self.tapBtnCnt.insert(i)
                }
            }

            self.tableV.reloadData()

        })
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)

    }

    // MARK: - xMARK 삭제 버튼
    @objc
    func deleteBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: .none, preferredStyle: UIAlertController.Style.alert)
        let delete = UIAlertAction(title: "삭제", style: .destructive, handler: { (_) in
            let tag = sender.tag
            let id = self.cartProduct[0].items[tag].id
            KurlyService.shared.deleteCartData(goods: [id])
            self.tapBtnCnt.removeAll()
            self.cartProduct[0].items.remove(at: tag)
            for i in 0...self.cartProduct[0].items.count - 1 {
                self.tapBtnCnt.insert(i)
            }
            self.tableV.reloadData()
//            self.cartListProduct()
        })
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)

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

            tapBtnCnt.forEach {
                selectProduct.append(cartProduct[0].items[$0])
            }
        } else {
            headerCell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            headerCell.check.tintColor = .lightGray
            tapBtnCnt.removeAll()
            selectProduct.removeAll()
        }
    }

    // MARK: - 상품만 선택 버튼
    @objc
    func cellTapBtn(_ sender: UIButton) {
        let tag = sender.tag

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
            tapBtnCnt.forEach {
                view.configure(text: cartProduct[0].items[$0].goods.packing_status ?? "상온")
            }
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
