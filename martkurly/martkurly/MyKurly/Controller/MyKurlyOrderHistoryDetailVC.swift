//
//  MyKurlyOrderHistoryDetailVC.swift
//  martkurly
//
//  Created by Kas Song on 9/5/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyOrderHistoryDetailVC: UIViewController {

    // MARK: - Properties
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let tableViewHeightForHeader: CGFloat = 8
    private let tableViewRowHeight: CGFloat = 60
    private let data = StringManager().myKurlyOrderHistoryDetailCellData
    private let customerServiceButton = UIButton().then {
        let image = UIImage(systemName: "chevron.right")?.withTintColor(.martkurlyMainPurpleColor, renderingMode: .alwaysOriginal)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 11, height: 11)
        let imageAttributedString = NSAttributedString(attachment: imageAttachment)
        let string = "1:1 문의 작성 "
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor.martkurlyMainPurpleColor
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.append(imageAttributedString)
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.setTitleColor(.martkurlyMainPurpleColor, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    private let cancelOrderButton = KurlyButton(title: "전체 상품 주문 취소", style: .white)
    private let cancelOrderInfoLabel = UILabel().then {
        let string1 = "직접 주문취소는 "
        let string2 = "\"입금확인\" "
        let string3 = "상태일 경우에만 가능합니다."
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)]
        let boldAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        let attributedText = NSMutableAttributedString(string: string1, attributes: attributes)
        let attributedText2 = NSMutableAttributedString(string: string2, attributes: boldAttributes)
        let attributedText3 = NSMutableAttributedString(string: string3, attributes: attributes)
        attributedText.append(attributedText2)
        attributedText.append(attributedText3)
        $0.attributedText = attributedText
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurlyOrderHistory.title2.rawValue)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.snp.makeConstraints {
            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 30)
        }
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        scrollView.backgroundColor = .backgroundGray
        contentView.backgroundColor = .backgroundGray
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        tableView.register(MyKurlyOrderHistoryDetailTableViewCell.self, forCellReuseIdentifier: MyKurlyOrderHistoryDetailTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.rowHeight = tableViewRowHeight
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = 0
    }

    private func setContraints() {
        [separator, scrollView].forEach {
            view.addSubview($0)
        }
        separator.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        [tableView, customerServiceButton, cancelOrderButton, cancelOrderInfoLabel].forEach {
            contentView.addSubview($0)
        }
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(tableViewRowHeight * CGFloat(data.count) + tableViewHeightForHeader * CGFloat(data.count))
        }
        customerServiceButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        cancelOrderButton.snp.makeConstraints {
            $0.top.equalTo(customerServiceButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(52)
        }
        cancelOrderInfoLabel.snp.makeConstraints {
            $0.top.equalTo(cancelOrderButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: -
extension MyKurlyOrderHistoryDetailVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyKurlyOrderHistoryDetailTableViewCell.identifier, for: indexPath) as? MyKurlyOrderHistoryDetailTableViewCell else { fatalError() }
        let cellData = data[indexPath.section]
        let cellType: MyKurlyDetailCellType = indexPath.section == 0 ? .orderNumber : .info
        cell.configureCell(cellData: cellData, cellType: cellType)
        return cell
    }
}

// MARK: -
extension MyKurlyOrderHistoryDetailVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView().then {
            $0.backgroundColor = .backgroundGray
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeightForHeader
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
