//
//  ProductOrderVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/24.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

let orderVCSideInsetValue: CGFloat = 20

class ProductOrderVC: UIViewController {

    // MARK: - Properties

    private let orderTableView = UITableView(frame: .zero, style: .grouped)

    private var isShowProductList: Bool = false { didSet { orderTableView.reloadData() } }
    private let orderProductInfomationHeaderView = OrderProductInfomationHeaderView()

    private var isShowOrdererList: Bool = false { didSet { orderTableView.reloadData() } }
    private let ordererInfomationHeaderView = OrdererInfomationHeaderView()

    private let orderDeliveryHeaderView = OrderDeliveryHeaderView()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .pop,
                                    titleText: "주문서")
    }

    // MARK: - Selectors

    @objc
    func tappedInfoHeaderView(_ sender: UITapGestureRecognizer) {
        guard let intName = Int(sender.name ?? "") else { return }
        switch OrderCellType(rawValue: intName)! {
        case .productInfomation:
            isShowProductList.toggle()
            orderProductInfomationHeaderView.isShowProductList = isShowProductList
        case .ordererInfomation:
            isShowOrdererList.toggle()
            ordererInfomationHeaderView.isShowOrdererList = isShowOrdererList
        case .orderDelivery:
            let controller = UserDeliverySettingVC()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = .white

        let underLine = UIView().then {
            $0.backgroundColor = ColorManager.General.chevronGray.rawValue
        }

        [underLine, orderTableView].forEach {
            view.addSubview($0)
        }

        underLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        orderTableView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureAttributes() {
        orderTableView.backgroundColor = ColorManager.General.backGray.rawValue
        orderTableView.separatorStyle = .none
        orderTableView.allowsSelection = false

        orderTableView.dataSource = self
        orderTableView.delegate = self

        orderTableView.register(ProductInfomationCell.self,
                                forCellReuseIdentifier: ProductInfomationCell.identifier)

        addTapGesture(addView: orderProductInfomationHeaderView,
                      gestureName: OrderCellType.productInfomation.rawValue)
        addTapGesture(addView: ordererInfomationHeaderView,
                      gestureName: OrderCellType.ordererInfomation.rawValue)
        addTapGesture(addView: orderDeliveryHeaderView,
                      gestureName: OrderCellType.orderDelivery.rawValue)
    }

    func addTapGesture(addView: UIView, gestureName: Int) {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tappedInfoHeaderView))
        tapGesture.name = "\(gestureName)"
        addView.isUserInteractionEnabled = true
        addView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - UITableViewDataSource

extension ProductOrderVC: UITableViewDataSource {
    enum OrderCellType: Int, CaseIterable {
        case productInfomation
        case ordererInfomation
        case orderDelivery
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch OrderCellType(rawValue: section)! {
        case .productInfomation: return isShowProductList ? 5 : 0
        case .ordererInfomation: return isShowOrdererList ? 1 : 0
        case .orderDelivery: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch OrderCellType(rawValue: indexPath.section)! {
        case .productInfomation:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductInfomationCell.identifier,
                for: indexPath) as! ProductInfomationCell
            return cell
        case .ordererInfomation:
            let cell = OrdererInfomationCell()
            return cell
        case .orderDelivery:
            let cell = OrderDeliveryCell()
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ProductOrderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch OrderCellType(rawValue: section)! {
        case .productInfomation:
            return orderProductInfomationHeaderView
        case .ordererInfomation:
            return ordererInfomationHeaderView
        case .orderDelivery:
            return orderDeliveryHeaderView
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch OrderCellType(rawValue: section)! {
        default:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = ColorManager.General.backGray.rawValue
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
