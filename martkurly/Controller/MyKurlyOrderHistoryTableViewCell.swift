//
//  MyKurlyOrderHistoryTableViewCell.swift
//  martkurly
//
//  Created by Kas Song on 9/5/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyOrderHistoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MyKurlyOrderHistoryTableViewCell"

    private let orderNumberLabel = UILabel().then {
        $0.text = "주문번호"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    private let rightAccessoryImageView = UIImageView().then {
        let image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        $0.image = image
    }
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }

    private let categories = [
        StringManager.MyKurlyOrderHistory.productName.rawValue,
        StringManager.MyKurlyOrderHistory.paymentDate.rawValue,
        StringManager.MyKurlyOrderHistory.paymentMethod.rawValue,
        StringManager.MyKurlyOrderHistory.paymentAmount.rawValue,
        StringManager.MyKurlyOrderHistory.orderStatus.rawValue
    ]

    private var orderInfoLabels = [UILabel]()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        self.selectionStyle = .none
        setContraints()
        generateInfoLabels()
    }

    private func setContraints() {
        [orderNumberLabel, rightAccessoryImageView, separator].forEach {
            self.addSubview($0)
        }
        orderNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        rightAccessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(orderNumberLabel)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(orderNumberLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    private func generateInfoLabels() {
        for index in categories.indices {
            let titleLabel = UILabel().then {
                $0.text = categories[index]
                $0.textColor = .gray
                $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            }
            let infoLabel = UILabel().then {
                $0.text = "이곳에 상세정보가 표시됩니다."
                $0.textColor = .black
                $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            }
            [titleLabel, infoLabel].forEach {
                self.addSubview($0)
            }
            if orderInfoLabels.isEmpty == true {
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(separator.snp.bottom).offset(15)
                    $0.leading.equalTo(orderNumberLabel)
                }
            } else {
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(orderInfoLabels[index - 1].snp.bottom).offset(13)
                    $0.leading.equalTo(orderNumberLabel)
                }
            }
            infoLabel.snp.makeConstraints {
                $0.leading.equalTo(orderNumberLabel).offset(100)
                $0.centerY.equalTo(titleLabel)
            }
            orderInfoLabels.append(infoLabel)
        }
    }
}
