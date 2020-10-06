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
    private let infoTableView = UITableView(frame: .zero, style: .grouped)
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
    private var selectedCell: Set<IndexPath> = [[0, 0]]

    private lazy var tableViewAnchor = infoTableView.heightAnchor
    private lazy var tableViewHeightAnchor = tableViewAnchor.constraint(equalToConstant: 400)

    private var order: Order?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.infoTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurlyOrderHistory.title2.rawValue)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function, cancelOrderInfoLabel.frame.maxY, "Debug")
//        contentView.snp.removeConstraints()
//        contentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.width.equalTo(view)
//            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 10)
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infoTableView.snp.updateConstraints {
            $0.height.equalTo(infoTableView.contentSize.height)
        }
        contentView.snp.makeConstraints {
            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 30)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        print(#function)
        infoTableView.layer.removeAllAnimations()
        tableViewHeightAnchor.constant = infoTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }

//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.tableView.removeObserver(self, forKeyPath: "contentSize")
//    }

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
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.isScrollEnabled = false
        infoTableView.estimatedRowHeight = 100
        infoTableView.tableFooterView = UIView()
        infoTableView.sectionFooterHeight = 0
        infoTableView.allowsMultipleSelection = true

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
        [infoTableView, customerServiceButton, cancelOrderButton, cancelOrderInfoLabel].forEach {
            contentView.addSubview($0)
        }
        infoTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(
                tableViewDefualtRowHeight * CGFloat(data.count)
                    + tableViewHeightForHeader * CGFloat(data.count)
                    + tableViewSubtitleHeight * CGFloat(numberOfSubtitles)
            )
        }
        customerServiceButton.snp.makeConstraints {
            $0.top.equalTo(infoTableView.snp.bottom).offset(10)
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

    private func generateData(order: Order) {
        order.items
    }

    func configureData(order: Order) {
        self.order = order
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
            guard let order = order else { fatalError("No Order") }
            orderNumberCell.configureCell(order: order, cellData: cellData)
            if selectedCell.contains(indexPath) {
                orderNumberCell.isFolded = false
                print("configure", orderNumberCell.isFolded)
            } else {
                orderNumberCell.isFolded = true
                print("configure", orderNumberCell.isFolded)
            }
            orderNumberCell.layoutIfNeeded()
            return orderNumberCell
        default:
            let infoCell = MyKurlyOrderHistoryDetailTableViewInfoCell()
            infoCell.configureCell(cellData: cellData)
            if selectedCell.contains(indexPath) {
                infoCell.isFolded = false
            }
            infoCell.layoutIfNeeded()
            return infoCell
        }
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
        switch selectedCell.contains(indexPath) {
        case true:
            selectedCell.remove(indexPath)
        case false:
            selectedCell.insert(indexPath)
            print(#function, "Debug")
        }
        tableView.reloadData()
        contentView.snp.removeConstraints()
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 30)
        }
        print(cancelOrderInfoLabel.frame.maxY, "Debugging")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.snp.updateConstraints {
            $0.height.equalTo(tableView.contentSize.height)
        }
        contentView.snp.removeConstraints()
        contentView.snp.updateConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 30)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("ContentSize", tableView.contentSize.height)
        tableView.snp.updateConstraints {
            $0.height.equalTo(tableView.contentSize.height)
        }
        contentView.snp.removeConstraints()
        contentView.snp.updateConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.equalTo(cancelOrderInfoLabel.frame.maxY + 30)
        }
    }
}
