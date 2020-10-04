//
//  CartView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/29.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartView: UIView {

    // MARK: - Properties
    var cartData = [Cart]() {
        didSet {
            tableV.reloadData()
        }
    }

    private let tableV = UITableView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        [tableV].forEach {
            self.addSubview($0)
        }

        tableV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        setTableView()
    }

    // MARK: - setTableView
    private func setTableView() {

        tableV.dataSource = self
        tableV.delegate = self
        tableV.backgroundColor = ColorManager.General.backGray.rawValue
        tableV.separatorStyle = .none
    }
}

// MARK: - TableViewDataSource & Delegate
extension CartView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        cartData.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("여기", cartData[indexPath.section])
        switch section {
        case 0:
            return cartData.count + 1
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = AllSelectView()
            return cell
        default:
            let cell = PriceView()
            return cell
        }
    }

}
