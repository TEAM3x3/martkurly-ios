//
//  SearchVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: - Properties

    private let defaultInset: CGFloat = 16

    private let searchBar = SearchBarView()
    private let resultTableView = UITableView()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNavigationBarStatus(type: .purpleType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: .none,
                                    titleText: "검색")
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureLayout()
        configureTableView()
    }

    func configureLayout() {
        [searchBar, resultTableView].forEach {
            view.addSubview($0)
        }

        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(68)
        }

        resultTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(defaultInset)
            $0.leading.equalToSuperview().offset(defaultInset)
            $0.trailing.equalToSuperview().offset(-defaultInset)
            $0.bottom.equalToSuperview()
        }
    }

    func configureTableView() {
        resultTableView.backgroundColor = .white
        resultTableView.separatorStyle = .none
        resultTableView.rowHeight = 52

        resultTableView.dataSource = self

        resultTableView.register(SearchResultCell.self,
                                 forCellReuseIdentifier: SearchResultCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultCell.identifier,
            for: indexPath) as! SearchResultCell
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchVC: UITableViewDelegate {

}
