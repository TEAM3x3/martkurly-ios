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
                for i in 0...cartProduct[0].items.count - 1 {
                    tapBtnCnt.insert(i)
                }
            }
        }
    }

    private var buttonStr: String? {
        didSet {

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
                    cell.deleteBtn.addTarget(self, action: #selector(handlerSelectDeleteBtn), for: .touchUpInside)
                    if cartProduct[indexPath.section].items.count == tapBtnCnt.count { // 전체선택 활성화
                        cell.check.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                        cell.check.tintColor = ColorManager.General.mainPurple.rawValue
                        cell.isActive = false
                        for cell in cells {
//                            cell.isActive = true
//                            cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
//                            cell.checkBtn.tintColor = ColorManager.General.mainPurple.rawValue
                        }
                    } else {
                        cell.check.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                        cell.check.tintColor = .lightGray
                        cell.isActive = true
                        for cell in cells {
//                            cell.isActive = false
//                            cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
//                            cell.checkBtn.tintColor = .lightGray
                        }
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
                    for i in 0...(cartProduct[indexPath.section].items.count - 1) {
                        cell.cartItems = cartProduct[indexPath.section].items[i]
                    }
                    cell.checkBtn.addTarget(self, action: #selector(cellTapBtn), for: .touchUpInside)

                    if tapBtnCnt.contains(indexPath.row - 1) {
                        cell.isActive = true
                    } else {
                        cell.isActive = false
                    }

//                    if cell.isActive == true /*tapBtnCnt.isEmpty == false*/ { // 유저가 셀을 활성화하면...
//                        cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
//                        cell.checkBtn.tintColor = ColorManager.General.mainPurple.rawValue
//                        print(#function, "True")
//                    } else {
//                        cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
//                        cell.checkBtn.tintColor = .lightGray
//                     }
                    if cells.count < cartProduct[indexPath.section].items.count {
                        cells.append(cell)

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

    @objc
    func handlerSelectDeleteBtn(_ sender: UIButton) {
        var result = [Int]()
        for index in tapBtnCnt.sorted() {
            let item = itemNumber[index]
            result.append(item)
            print(result)
            CurlyService.shared.deleteCartData(goods: result)
        }
    }

    @objc
    func deleteBtn(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? CartProductView else { print(#function, "Guard"); return }
//        let index = cells[sender.tag].product
//        let result = itemNumber[index]
//        CurlyService.shared.deleteCartData(goods: [result])
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
        var tag = sender.tag
        print("tag: ", tag, cells[tag].isActive)
        tag = cells[tag].tag
        if cells[tag].isActive {
            tapBtnCnt.remove(tag)
            cells[tag].isActive = false
            print(#function, "if", "tag: ", tag, tapBtnCnt, "Cell tag: ", cells[tag].tag)
        } else {
            tapBtnCnt.insert(tag)
            cells[tag].isActive = true
            print(cells[tag], cells[tag].isActive)
            print(#function, "else", "tag: ", tag, tapBtnCnt, "Cell tag: ", cells[tag].tag)
        }
//        cells[tag].isActive.toggle()
//        print(cells[tag].isActive)
//        if cells[tag].isActive {
//            self.tapBtnCnt.remove(tag)
//        } else {
//            self.tapBtnCnt.insert(tag)
//        }
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
