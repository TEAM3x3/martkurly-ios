//
//  DetailTableView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class DetailTableView: UITableView {

    // MARK: - Properties
    var data = [String]()

    // MARK: - Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        backgroundColor = ColorManager.General.backGray.rawValue
        delegate = self
        dataSource = self
        separatorStyle = .none
    }

    func configure(str: [String]) {
        data.append(contentsOf: str)
    }
}

extension DetailTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailTableViewCell()
        cell.configure(title: data[indexPath.row])
        return cell
    }
}

extension DetailTableView: UITableViewDelegate {

}
