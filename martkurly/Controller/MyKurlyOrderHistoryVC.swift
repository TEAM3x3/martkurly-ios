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
}

// MARK: - UITableViewDataSource
extension MyKurlyOrderHistoryVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case orderHistoryTableView:
            return 5
        case frequentlyBuyingProductsTableView:
            return 5
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
            return cell
        case frequentlyBuyingProductsTableView:
            guard let cell = frequentlyBuyingProductsTableView.dequeueReusableCell(withIdentifier: MyKurlyFrequentlyBuyingProductsTableViewCell.identifier, for: indexPath) as? MyKurlyFrequentlyBuyingProductsTableViewCell else { fatalError() }
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
        case frequentlyBuyingProductsTableView:
            print(2)
        default:
            fatalError()
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
