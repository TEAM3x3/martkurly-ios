//
//  MyCurlyVC.swift
//  martkurly
//
//  Created by Kas Song on 8/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyVC: UIViewController {

    // MARK: - Properties
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .backgroundGray
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    private let signView = MyKurlySignView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let bottomBarView = UIView().then {
        $0.backgroundColor = .backgroundGray
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .purpleType, isShowCart: true, leftBarbuttonStyle: .none, titleText: StringManager.MyKurly.title.rawValue)
    }

    override func viewDidAppear(_ animated: Bool) {
        contentView.snp.makeConstraints {
            $0.height.equalTo(bottomBarView.frame.maxY)
        }
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
        setAttributes()
    }

    private func setAttributes() {
        signView.signButton.addTarget(self, action: #selector(handleSignButton(_:)), for: .touchUpInside)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }

    private func setContraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(view)
        }
        contentView.addSubview(signView)
        signView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(230)
        }
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(signView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(500)
        }
        contentView.addSubview(bottomBarView)
        bottomBarView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
    }

    // MARK: - Selectors
    @objc
    private func handleSignButton(_ sender: UIButton) {
        let nextVC = SignInVC()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyKurlyVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = MyKurlyCategory.instance.data[section].count
        return number
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = MyKurlyCategory.instance.data[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}

// MARK: - UITableViewDelegate
extension MyKurlyVC: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return MyKurlyCategory.instance.data.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView().then {
            $0.backgroundColor = .backgroundGray
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            let nextVC = MyKurlyNoSignInOrderVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [1, 0]:
            let nextVC = MyKurlyDeliveryInfoVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [1, 1]:
            let nextVC = MyKurlyNoticeVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [1, 2]:
            let nextVC = MyKurlyFAQVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [1, 3]:
            let nextVC = MyKurlyCustomerServiceVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [1, 4]:
            let nextVC = MyKurlyInstructionVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [1, 5]:
            let nextVC = MyKurlyAboutVC()
            navigationController?.pushViewController(nextVC, animated: true)
        case [2, 0]:
            let nextVC = MyKurlyNotificationVC()
            navigationController?.pushViewController(nextVC, animated: true)
        default:
            break
        }
    }
}
