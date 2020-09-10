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
    private let tableViewDefualtRowHeight: CGFloat = 60
    private let tableViewSubtitleHeight: CGFloat = 30
    private var numberOfSubtitles = 0
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
        let attributes: [NSAttributedString.Key: Any] =
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        let boldAttributes: [NSAttributedString.Key: Any] =
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        let attributedText = NSMutableAttributedString(string: string1, attributes: attributes)
        let attributedText2 = NSMutableAttributedString(string: string2, attributes: boldAttributes)
        let attributedText3 = NSMutableAttributedString(string: string3, attributes: attributes)
        attributedText.append(attributedText2)
        attributedText.append(attributedText3)
        $0.attributedText = attributedText
    }
    private var selectedCell: IndexPath = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurlyOrderHistory.title2.rawValue)
    }

    override func viewDidLayoutSubviews() {
        contentView.snp.removeConstraints()
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
//            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 30)
        }
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
        getNumberOfSubtitles()
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = 0

        customerServiceButton.addTarget(self, action: #selector(handleCustomerServiceButton), for: .touchUpInside)
        cancelOrderButton.addTarget(self, action: #selector(handleCancelOrderButton), for: .touchUpInside)
        cancelOrderButton.isActive = false
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
            $0.height.greaterThanOrEqualTo(
                tableViewDefualtRowHeight * CGFloat(data.count)
                    + tableViewHeightForHeader * CGFloat(data.count)
//                    + tableViewSubtitleHeight * CGFloat(numberOfSubtitles)
            )
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

    // MARK: - Helpers
    private func getNumberOfSubtitles() {
        for category in data {
            for index in category.indices {
                if index == 0 { continue }
                numberOfSubtitles += 1
            }
        }
    }

    // MARK: - Selectors
    @objc
    private func handleCustomerServiceButton() {
        print(#function)
    }

    @objc
    private func handleCancelOrderButton() {
        print(#function)
    }
}

// MARK: - UITableViewDataSource
extension MyKurlyOrderHistoryDetailVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.section]
        switch indexPath.section {
        case 0:
            let orderNumberCell = MyKurlyOrderHistoryDetailTableViewOrderNumberCell()
            orderNumberCell.configureCell(cellData: cellData)
            if selectedCell == indexPath {
                orderNumberCell.isFoled.toggle()
            }
            orderNumberCell.layoutIfNeeded()
            return orderNumberCell
        default:
            let infoCell = MyKurlyOrderHistoryDetailTableViewInfoCell()
            infoCell.configureCell(cellData: cellData)
            if selectedCell == indexPath {
                infoCell.isFoled.toggle()
            }
//            infoCell.setNeedsLayout()
//            infoCell.setNeedsUpdateConstraints()
            infoCell.layoutIfNeeded()
            return infoCell
        }

//        tableView.beginUpdates()
//                 tableView.endUpdates()

//        func updateTableView() {
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//        cell.updateTableView = updateTableView
//        infoCell.contentView.setNeedsLayout()
//        cell.contentView.layoutIfNeeded()
//        cell.layoutSubviews()
//        infoCell.setNeedsUpdateConstraints()
//        infoCell.updateConstraintsIfNeeded()
//        infoCell.setNeedsLayout()
//        infoCell.layoutIfNeeded()
    }
}

// MARK: - UITableViewDelegate
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.snp.updateConstraints {
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        tableView.snp.updateConstraints {
//            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
//        }
    }
}
