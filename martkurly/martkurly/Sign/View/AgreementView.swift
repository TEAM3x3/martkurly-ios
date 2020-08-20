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
    }

    private func setConstraints() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
        }
    }
}

extension AgreementView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AgreementTableViewCell()
        cell.configureCell(cellType: .title)
        return cell
    }
}

extension AgreementView: UITableViewDelegate {

}
