//
//  MyKurlyOrderHistoryDetailTableViewOrderNumberCell.swift
//  martkurly
//
//  Created by Kas Song on 9/10/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Kingfisher

class MyKurlyOrderHistoryDetailTableViewOrderNumberCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MyKurlyOrderHistoryDetailTableViewOrderNumberCell"
    private var cellType: MyKurlyDetailCellType = .orderNumber
    private var cellData = [String]()
    private var productData = StringManager().myKurlyOrderHistoryDetailProductData

    private let rightAccessoryImageView = UIImageView().then {
        let image = UIImage(systemName: "chevron.down")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        $0.image = image
    }
    private var cellTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.numberOfLines = 0
    }
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    // 상세정보가 들어있는 뷰
    private var detailContentView = UIView()
    private var subtitleLabels = [UILabel]()
    private var infoLabels = [UILabel]() // 구매 물품에 따라 다른 정보가 표시

    // 상세정보뷰의 상태
    var isFolded = false
    var isInitialized = false

    var data: Order?

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        configureFoldingStatus(newValue: isFolded)
    }

    // MARK: - UI
    func configureUI() {
        guard isInitialized == false else { return }
        self.selectionStyle = .none
        setAttributes()
        setContraints()
        isInitialized = true
    }

    private func setAttributes() {
        cellTitle.text = cellData[0]
    }

    private func setContraints() {
        [cellTitle, rightAccessoryImageView, separator, detailContentView].forEach {
            self.contentView.addSubview($0)
        }
        cellTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        rightAccessoryImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(cellTitle)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(cellTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().priority(.low)
        }
        detailContentView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        setConstraintsForSubviews()
    }

    private func setConstraintsForSubviews() {
        var previousView = UIView()
        for index in productData.indices {
            let productImageView = UIImageView().then {
                let image = productData[index]["image"]!
                $0.image = UIImage(named: image)
                $0.contentMode = .scaleAspectFill
                $0.clipsToBounds = true
            }
            let imageURL = URL(string: productData[index]["image"]!)
            productImageView.kf.setImage(with: imageURL)
            let productTitleLabel = UILabel().then {
                $0.text = productData[index]["title"]
                $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                $0.numberOfLines = 0
            }
            let priceLabel = UILabel().then {
                $0.text = productData[index]["price"]! + " 원"
                $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            }
            let orderDetailLabel = UILabel().then {
                $0.text = productData[index]["detail"]
                $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                $0.textColor = .textDarkGray
            }
            let deliveryStatusLabel = UILabel().then {
                $0.text = productData[index]["deliveryStatus"]
                $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            }
            let separator = UIView().then {
                $0.backgroundColor = .separatorGray
            }
            if let category = productData[index]["category"], category != "" {
                let categoryLabel = UILabel().then {
                    $0.text = category
                    $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                    $0.textColor = .textDarkGray
                }
                let categorySeparator = UIView().then {
                    $0.backgroundColor = .separatorGray
                }
                [categoryLabel, categorySeparator, productImageView].forEach {
                    detailContentView.addSubview($0)
                }
                categoryLabel.snp.makeConstraints {
                    _ = index == 0 ? $0.top.equalToSuperview().inset(20) : $0.top.equalTo(previousView).inset(20)
                    $0.leading.equalToSuperview().inset(20)
                }
                categorySeparator.snp.makeConstraints {
                    $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
                    $0.leading.trailing.equalToSuperview().inset(15)
                    $0.height.equalTo(1)
                }
                productImageView.snp.makeConstraints {
                    $0.top.equalTo(categorySeparator).offset(20)
                    $0.leading.equalTo(categoryLabel)
                    $0.width.equalTo(55)
                    $0.height.equalTo(66)
                }

            } else {
                [productImageView].forEach {
                    detailContentView.addSubview($0)
                }
                productImageView.snp.makeConstraints {
                    _ = index == 0 ? $0.top.equalToSuperview().offset(20) : $0.top.equalTo(previousView).inset(20)
                    $0.leading.equalToSuperview().inset(20)
                    $0.width.equalTo(55)
                    $0.height.equalTo(66)
                }
            }
            [productTitleLabel, priceLabel, orderDetailLabel, deliveryStatusLabel, separator].forEach {
                detailContentView.addSubview($0)
            }
            productTitleLabel.snp.makeConstraints {
                $0.top.equalTo(productImageView).offset(2)
                $0.leading.equalTo(productImageView.snp.trailing).offset(10)
                $0.trailing.equalToSuperview().inset(20)
            }
            priceLabel.snp.makeConstraints {
                $0.top.equalTo(productTitleLabel.snp.bottom).offset(4)
                $0.leading.equalTo(productTitleLabel)
            }
            orderDetailLabel.snp.makeConstraints {
                $0.leading.equalTo(priceLabel.snp.trailing).offset(5)
                $0.centerY.equalTo(priceLabel)
            }
            deliveryStatusLabel.snp.makeConstraints {
                $0.top.equalTo(priceLabel.snp.bottom).offset(8)
                $0.leading.equalTo(productTitleLabel)
            }
            if index != productData.count - 1 {
                separator.snp.makeConstraints {
                    $0.top.equalTo(deliveryStatusLabel.snp.bottom).offset(26)
                    $0.leading.trailing.equalToSuperview().inset(15)
                    $0.height.equalTo(1)
                }
            } else {
                let button = KurlyButton(title: "전체 상품 다시 담기", style: .white)
                detailContentView.addSubview(button)
                button.snp.makeConstraints {
                    $0.top.equalTo(deliveryStatusLabel.snp.bottom).offset(26)
                    $0.leading.trailing.equalToSuperview().inset(22)
                    $0.height.equalTo(48)
                    $0.bottom.equalToSuperview().offset(-20)
                }
            }
            previousView = separator
        }
    }

    private func generateSubtitles() {
        for index in cellData.indices {
            if index == 0 { continue }
            let text = cellData[index]
            let subtitleLabel = UILabel().then {
                $0.text = text
                $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
            }
            let infoLabel = UILabel().then {
                $0.text = "이곳에 정보가 표시됩니다."
                $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            }
            subtitleLabels.append(subtitleLabel)
            infoLabels.append(infoLabel)
        }
    }

    // MARK: - Helpers
    func configureCell(order data: Order, cellData: [String]) {
        self.data = data
        self.cellData = cellData
        productData = convertData(order: data)
    }

    private func configureFoldingStatus(newValue: Bool) {
        print(#function)
        var image = UIImage()
        switch newValue {
        case true:
            detailContentView.isHidden = true
            detailContentView.snp.removeConstraints()
            separator.snp.removeConstraints()
            separator.snp.makeConstraints {
                $0.top.equalTo(cellTitle.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(1)
                $0.bottom.equalToSuperview().priority(.high)
            }
            image = UIImage(systemName: "chevron.down")!.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        case false:
            detailContentView.isHidden = false
            detailContentView.snp.makeConstraints {
                $0.top.equalTo(separator.snp.bottom).offset(1)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            separator.snp.updateConstraints {
                $0.bottom.equalToSuperview().priority(.low)
            }
            image = UIImage(systemName: "chevron.up")!.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        }
        rightAccessoryImageView.image = image
    }

    private func convertData(order: Order) -> [[String: String]] {
        var results = [[String: String]]()
        let items = order.items
        for item in items {
            let image = item.goods.img
            let title = item.goods.title
            let quantity = item.quantity
            let price = item.sub_total

            let result: [String: String] = [
                "image": image,
                "category": "",
                "title": title,
                "price": String(price),
                "detail": "/ " + "\(quantity)개 구매",
                "deliveryStatus": "배송완료"
            ]
            results.append(result)
        }
        return results
    }
}
