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

    private let deliveryAdditionHeaderView = DeliveryAdditionButtonView()
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
        deliveryAddressTableView.backgroundColor = ColorManager.General.backGray.rawValue
        deliveryAddressTableView.separatorStyle = .none

        deliveryAddressTableView.dataSource = self
        deliveryAddressTableView.delegate = self

        deliveryAddressTableView.register(DeliveryAddressCell.self,
                                          forCellReuseIdentifier: DeliveryAddressCell.identifier)
        deliveryAddressTableView.register(DeliveryEditFooterView.self,
                                          forHeaderFooterViewReuseIdentifier: DeliveryEditFooterView.identifier)
    }
}

// MARK: - UITableViewDataSource

extension UserDeliverySettingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DeliveryAddressCell.identifier,
            for: indexPath) as! DeliveryAddressCell
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserDeliverySettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return deliveryAdditionHeaderView } else { return nil }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 100 } else { return 0 }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: DeliveryEditFooterView.identifier) as! DeliveryEditFooterView
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

import UIKit

class DeliveryAddressCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "DeliveryAddressCell"

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .systemRed
    }
}

import UIKit

class DeliveryEditFooterView: UITableViewHeaderFooterView {

    // MARK: - Properties

    static let identifier = "DeliveryEditFooterView"

    private let footerContentView = UIView().then {
        $0.backgroundColor = .systemBlue
    }

    // MARK: - LifeCycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.addSubview(footerContentView)
        footerContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

    func configureAttributes() {

    }
}
