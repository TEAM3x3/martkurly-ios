//
//  ProductInquiryCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductInquiryCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductInquiryCell"

    private let sideInsetValue: CGFloat = 12

    private let inquiryWriteButton = KurlyButton(title: "상품 문의하기", style: .white)
    private let inquiryTableView = UITableView()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue
        configureLayout()
    }

    func configureLayout() {
        [inquiryWriteButton, inquiryTableView].forEach {
            self.addSubview($0)
        }
        inquiryWriteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(44)
        }

        inquiryTableView.snp.makeConstraints {
            $0.top.equalTo(inquiryWriteButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview()
        }
    }

    func configureTableView() {
        inquiryTableView.backgroundColor = .clear
        inquiryTableView.separatorStyle = .none

        inquiryTableView.dataSource = self
        inquiryTableView.delegate = self

        inquiryTableView.register(InquiryCell.self,
                                  forCellReuseIdentifier: InquiryCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ProductInquiryCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: InquiryCell.identifier, for: indexPath) as! InquiryCell
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 24
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

// MARK: - UITableViewDelegate

extension ProductInquiryCell: UITableViewDelegate {

}

import UIKit

class InquiryCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "InquiryCell"

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .systemBlue
    }
}
