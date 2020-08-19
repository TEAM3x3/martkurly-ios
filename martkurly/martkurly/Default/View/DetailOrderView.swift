//
//  DetailOrderView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DetailOrderView: UIViewController {

    private let tableV = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }

    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        [tableV].forEach { view.addSubview($0) }
        tableV.dataSource = self
        tableV.delegate = self
        tableV.separatorStyle = .none
        tableV.register(OrderCancelNoticeView.self, forCellReuseIdentifier: OrderCancelNoticeView.identifier)
        tableV.register(MoreButton.self, forCellReuseIdentifier: MoreButton.identifier)
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension DetailOrderView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderCancelNoticeView.identifier, for: indexPath) as! OrderCancelNoticeView
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MoreButton.identifier, for: indexPath) as! MoreButton
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 350
        default:
            return 50
        }
    }
}

extension DetailOrderView: UITableViewDelegate {

}
