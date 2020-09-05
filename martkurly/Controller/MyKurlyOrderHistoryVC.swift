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
    private let frequentlyBuyingProductsTableView = UITableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: true, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurly.title.rawValue)
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
    }

    private func setContraints() {
        [categoryMenuView, orderHistoryTableView].forEach {
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
    }
}

// MARK: - UITableViewDataSource
extension MyKurlyOrderHistoryVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case orderHistoryTableView:
            return 5
        case frequentlyBuyingProductsTableView:
            return 0
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case orderHistoryTableView:
            return 1
        case frequentlyBuyingProductsTableView:
            return 0
        default:
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case orderHistoryTableView:
            guard let cell = orderHistoryTableView.dequeueReusableCell(withIdentifier: MyKurlyOrderHistoryTableViewCell.identifier, for: indexPath) as? MyKurlyOrderHistoryTableViewCell else { fatalError() }
            return cell
        case frequentlyBuyingProductsTableView:
            return UITableViewCell()
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
            return 0
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
            fatalError()
        default:
            fatalError()
        }
    }
}
