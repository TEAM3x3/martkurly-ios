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
    private let infoView = MyKurlyInfoView()
    private let signView = MyKurlySignView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let bottomBarView = UIView().then {
        $0.backgroundColor = .backgroundGray
    }
    private var isSignedIn = true

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
        setContstraints()
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

    private func setContstraints() {
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
        isSignedIn ? setContraintsForSignedInStatus() : setContraintsForSignedOutStatus()
    }

    private func setContraintsForSignedInStatus() {
        [infoView, tableView, bottomBarView].forEach {
            contentView.addSubview($0)
        }
        infoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(215)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(500)
        }
        bottomBarView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
    }

    private func setContraintsForSignedOutStatus() {
        [signView, tableView, bottomBarView].forEach {
            contentView.addSubview($0)
        }
        signView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(230)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(signView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(500)
        }
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
    
    // MARK: - Helpers
    private func configureSignedOutTableViewInfo() {
        
    }
    
    private func configureSignedInTableViewInfo() {
        
    }
}

// MARK: - UITableViewDataSource
extension MyKurlyVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = MyKurlyCategory.instance.signedOutData[section].count
        return number
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = MyKurlyCategory.instance.signedOutData[indexPath.section][indexPath.row]
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
        return MyKurlyCategory.instance.signedOutData.count
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
        var nextVC = UIViewController()
        switch indexPath {
        case [0, 0]:
            nextVC = MyKurlyNoSignInOrderVC()
        case [1, 0]:
            nextVC = MyKurlyDeliveryInfoVC()
        case [1, 1]:
            nextVC = MyKurlyNoticeVC()
        case [1, 2]:
            nextVC = MyKurlyFAQVC()
        case [1, 3]:
            nextVC = MyKurlyCustomerServiceVC()
        case [1, 4]:
            nextVC = MyKurlyInstructionVC()
        case [1, 5]:
            nextVC = MyKurlyAboutVC()
        case [2, 0]:
            nextVC = MyKurlyNotificationVC()
        default:
            break
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
