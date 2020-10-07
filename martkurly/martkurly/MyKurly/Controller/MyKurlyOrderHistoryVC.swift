//
//  MyKurlyOrderHistoryVC.swift
//  martkurly
//
//  Created by Kas Song on 9/4/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyOrderHistoryVC: UIViewController {

    // MARK: - Properties
    private let categoryMenuView = CategoryMenuView(categoryType: .fixNonInsetStyle).then {
        $0.menuTitles = [StringManager.MyKurlyOrderHistory.title.rawValue, StringManager.MyKurlyOrderHistory.menu2.rawValue]
    }
    private let orderHistoryTableView = UITableView(frame: .zero, style: .grouped)
    private let frequentlyBuyingProductsTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.isHidden = true
    }

    var data = [Order]()
    var frequentlyBuyingProductsInfo = [FrequantlyBuyingProducts.Serializers]()
    var frequantlyBuyingProductsCount = [Int]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showIndicate()
        setNavigationBarStatus(type: .whiteType, isShowCart: true, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurly.title.rawValue)
        guard let token = UserService.shared.currentUser?.token else { return}
        KurlyService.shared.fetchOrderList(token: token, completionHandler: fetchOrderListData(data:))
        KurlyService.shared.fetchFrequantlyBuyingProductsData(token: token, completionHandler: fetchFrequentlyBuyingProductData(data:))
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .backgroundGray
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        orderHistoryTableView.register(MyKurlyOrderHistoryTableViewCell.self, forCellReuseIdentifier: MyKurlyOrderHistoryTableViewCell.identifier)
        orderHistoryTableView.dataSource = self
        orderHistoryTableView.delegate = self
        orderHistoryTableView.rowHeight = 240
        orderHistoryTableView.separatorStyle = .none
        orderHistoryTableView.backgroundColor = .backgroundGray
        orderHistoryTableView.tableFooterView = UIView(frame: .zero)
        orderHistoryTableView.sectionFooterHeight = 0

        frequentlyBuyingProductsTableView.register(MyKurlyFrequentlyBuyingProductsTableViewCell.self, forCellReuseIdentifier: MyKurlyFrequentlyBuyingProductsTableViewCell.identifier)
        frequentlyBuyingProductsTableView.dataSource = self
        frequentlyBuyingProductsTableView.delegate = self
        frequentlyBuyingProductsTableView.rowHeight = 170
        frequentlyBuyingProductsTableView.separatorStyle = .none
        frequentlyBuyingProductsTableView.backgroundColor = .backgroundGray
        frequentlyBuyingProductsTableView.tableFooterView = UIView(frame: .zero)
        frequentlyBuyingProductsTableView.sectionFooterHeight = 0

        categoryMenuView.categorySelected = handleCategoryMenuSelection(index:)
    }

    private func setContraints() {
        [categoryMenuView, orderHistoryTableView, frequentlyBuyingProductsTableView].forEach {
            view.addSubview($0)
        }
        categoryMenuView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        orderHistoryTableView.snp.makeConstraints {
            $0.top.equalTo(categoryMenuView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        frequentlyBuyingProductsTableView.snp.makeConstraints {
            $0.top.equalTo(categoryMenuView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Helpers
    private func handleCategoryMenuSelection(index: Int) {
        switch index {
        case 0:
            orderHistoryTableView.isHidden = false
            frequentlyBuyingProductsTableView.isHidden = true
        case 1:
            orderHistoryTableView.isHidden = true
            frequentlyBuyingProductsTableView.isHidden = false
        default:
            break
        }
    }

    private func fetchOrderListData(data: [Order]) {
        self.data = data
        orderHistoryTableView.reloadData()
        self.stopIndicate()
    }

    private func fetchFrequentlyBuyingProductData(data: FrequantlyBuyingProducts) {
        guard
            let counts = data.goods_purchase_count, // 주문한 제품수량
            let ids = data.serializers // 위 제품 수량에 맞는 제품 id
        else { return }
        frequantlyBuyingProductsCount = counts
        frequentlyBuyingProductsInfo = ids
        frequentlyBuyingProductsTableView.reloadData()
    }

    private func convertToWon(int: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: int))! + "원"
        return result
    }
}

// MARK: - UITableViewDataSource
extension MyKurlyOrderHistoryVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case orderHistoryTableView:
            let result = data.count
            return result
        case frequentlyBuyingProductsTableView:
            let result = frequentlyBuyingProductsInfo.count
            return result
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case orderHistoryTableView:
            return 1
        case frequentlyBuyingProductsTableView:
            return 1
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case orderHistoryTableView:
            guard let cell = orderHistoryTableView.dequeueReusableCell(withIdentifier: MyKurlyOrderHistoryTableViewCell.identifier, for: indexPath) as? MyKurlyOrderHistoryTableViewCell else { fatalError() }
            let order = data[indexPath.row]
            guard let prodcutName = order.orderdetail?.title, let paymentDate = order.orderdetail?.created_at else { return cell }
            let paymentMethod = "카카오페이"
            let paymentAmount = String(order.discount_payment)
            let orderStatus = "배송완료"
            cell.configureCell(productName: prodcutName, paymentDate: paymentDate, paymentMethod: paymentMethod, paymentAmount: paymentAmount, orderStatus: orderStatus)
            return cell
        case frequentlyBuyingProductsTableView:
            guard let cell = frequentlyBuyingProductsTableView.dequeueReusableCell(withIdentifier: MyKurlyFrequentlyBuyingProductsTableViewCell.identifier, for: indexPath) as? MyKurlyFrequentlyBuyingProductsTableViewCell else { fatalError() }

            let productName = frequentlyBuyingProductsInfo[indexPath.section].title
            let price = convertToWon(int: frequentlyBuyingProductsInfo[indexPath.section].price)
            let numberOfPurchases = String(frequantlyBuyingProductsCount[indexPath.section]) + "회"
            let imageURL = frequentlyBuyingProductsInfo[indexPath.section].img
            cell.configureCell(productName: productName, price: price, numberOfPurchases: numberOfPurchases, imageURL: imageURL)
            return cell
        default:
            fatalError()
        }
    }
}

// MARK: - UITableViewDelegate
extension MyKurlyOrderHistoryVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case orderHistoryTableView:
            return 13
        case frequentlyBuyingProductsTableView:
            return 13
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case orderHistoryTableView:
            let view = UIView().then {
                $0.backgroundColor = .backgroundGray
            }
            return view
        case frequentlyBuyingProductsTableView:
            let view = UIView().then {
                $0.backgroundColor = .backgroundGray
            }
            return view
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextVC = UIViewController()
        switch tableView {
        case orderHistoryTableView:
            nextVC = MyKurlyOrderHistoryDetailVC()
            guard let nextVC = nextVC as? MyKurlyOrderHistoryDetailVC else { return }
            nextVC.configureData(order: data[indexPath.row])
            navigationController?.pushViewController(nextVC, animated: true)
        case frequentlyBuyingProductsTableView:
            let productID = frequentlyBuyingProductsInfo[indexPath.section].id
            KurlyService.shared.requestProductDetailData(productID: productID) { product in
                let controller = ProductDetailVC()
                controller.productDetailData = product
                self.navigationController?.pushViewController(controller, animated: true)
            }
        default:
            fatalError()
        }
    }
}
