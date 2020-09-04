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
    private let infoView = MyKurlyInfoView() // 로그인 된 경우 개인정보 표시
    private let signView = MyKurlySignView() // 로그아웃 된 경우 로그인 뷰 표시
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let bottomBarView = UIView().then {
        $0.backgroundColor = .backgroundGray
    }
    private var isSignedIn = true
    private var price = "0" // 적립금
    private var coupon = "0" // 쿠폰
    private var nextVC = UIViewController()

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

        tableView.register(MyKurlyTableViewCell.self, forCellReuseIdentifier: MyKurlyTableViewCell.identifier)
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
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(215)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(1105)
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
    private func configureNextVCWhenSignedOut(indexPath: IndexPath) {
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

    private func configureNextVCWhenSignedIn(indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            nextVC = MyKurlyMileageVC()
        case [0, 1]:
            nextVC = MyKurlyCouponVC()
        case [0, 2]:
            nextVC = MyKurlyInvitationVC()
        case [1, 0]:
            nextVC = MyKurlyOrderHistoryVC()
        case [1, 1]:
            nextVC = MyKurlyProductReviewVC()
        case [1, 2]:
            nextVC = MyKurlyProductQuestionVC()
        case [1, 3]:
            nextVC = MyKurlyAssistantVC()
        case [1, 4]:
            nextVC = MyKurlyBulkOrderVC()
        case [2, 0]:
            nextVC = MyKurlyDeliveryInfoVC()
        case [2, 1]:
            nextVC = MyKurlyNoticeVC()
        case [2, 2]:
            nextVC = MyKurlyFAQVC()
        case [2, 3]:
            nextVC = MyKurlyCustomerServiceVC()
        case [2, 4]:
            nextVC = MyKurlyInstructionVC()
        case [2, 5]:
            nextVC = MyKurlyAboutVC()
        case [2, 6]:
            nextVC = MyKurlyPassVC()
        case [3, 0]:
            nextVC = MyKurlyEditInfoVC()
        case [3, 1]:
            nextVC = MyKurlyNotificationVC()
        case [4, 0]:
            break
        default:
            break
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyKurlyVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = isSignedIn ? MyKurlyCategory.instance.signedInData[section].count : MyKurlyCategory.instance.signedOutData[section].count
        return number
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyKurlyTableViewCell.identifier, for: indexPath) as? MyKurlyTableViewCell else { fatalError("Cell Type Casting Failed") }
        let title = isSignedIn ? MyKurlyCategory.instance.signedInData[indexPath.section][indexPath.row] : MyKurlyCategory.instance.signedOutData[indexPath.section][indexPath.row]
        var subtitle = ""
        var cellType: MyKurlyCellType = .normal
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                subtitle = price
            } else if indexPath.row == 1 {
                subtitle = coupon
            }
            subtitle += " " + MyKurlyCategory.instance.signedInSubtitle[indexPath.row]
            cellType = .subtitle
        case 4:
            cellType = .simple
        default:
            cellType = .normal
        }
        cell.configureCell(title: title, subtitle: subtitle, cellType: cellType)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}

// MARK: - UITableViewDelegate
extension MyKurlyVC: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        let number = isSignedIn ? MyKurlyCategory.instance.signedInData.count : MyKurlyCategory.instance.signedOutData.count
        return number
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
        isSignedIn ? configureNextVCWhenSignedIn(indexPath: indexPath) : configureNextVCWhenSignedOut(indexPath: indexPath)
    }
}
