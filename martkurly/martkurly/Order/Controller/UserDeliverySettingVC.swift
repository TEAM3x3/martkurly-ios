//
//  UserDeliverySettingVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class UserDeliverySettingVC: UIViewController {

    // MARK: - Properties

    private let deliveryAddressTableView = UITableView(frame: .zero,
                                                       style: .grouped)
    private let confirmButton = KurlyButton(title: "확인", style: .purple)

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
                                    titleText: "배송지 선택")
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = .white

        [deliveryAddressTableView, confirmButton].forEach {
            self.view.addSubview($0)
        }

        deliveryAddressTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        confirmButton.snp.makeConstraints {
            $0.top.equalTo(deliveryAddressTableView.snp.bottom)
            $0.leading.equalToSuperview().offset(orderVCSideInsetValue)
            $0.trailing.bottom.equalToSuperview().offset(-orderVCSideInsetValue)
            $0.height.equalTo(52)
        }
    }

    func configureAttributes() {
        deliveryAddressTableView.backgroundColor = .clear
        deliveryAddressTableView.separatorStyle = .none

        deliveryAddressTableView.dataSource = self
        deliveryAddressTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension UserDeliverySettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension UserDeliverySettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = DeliveryAdditionButtonView()
            return headerView
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        } else {
            return 0
        }
    }
}
