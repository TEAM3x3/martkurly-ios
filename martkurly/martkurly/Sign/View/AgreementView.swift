//
//  AgreementView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/21/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class AgreementView: UIView {

    // MARK: - Properties
    private let data = StringManager().agreement
    private let tableView = UITableView()

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
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }

    private func setConstraints() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
        }
    }

    // MARK: - Helpers
    private func configureCellType(type: String) -> AgreementCellType {
        switch type {
        case "title":
            return .title
        case "page":
            return .page
        case "choice":
            return .choice
        case "normal":
            return .normal
        default:
            fatalError()
        }
    }
}

extension AgreementView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AgreementTableViewCell()
        guard
            let title = data[indexPath.row]["title"],
            let subtitle = data[indexPath.row]["subtitle"],
            let info = data[indexPath.row]["info"],
            let type = data[indexPath.row]["type"]
            else { fatalError() }
        let cellType = configureCellType(type: type)
        cell.configureCell(title: title, info: info, subtitle: subtitle, cellType: cellType)
        return cell
    }
}

extension AgreementView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 50
        case 2:
            return 50
        case 3:
            return 50
        case 4:
            return 180
        case 5:
            return 50
        default:
            fatalError()
        }
    }
}
