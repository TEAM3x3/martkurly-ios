//
//  ChooseProductsVC.swift
//  martkurly
//
//  Created by Kas Song on 9/17/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ChooseProductsVC: UIViewController {

    // MARK: - Properties
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tableView = UITableView()
    private let purchaseButton = KurlyButton(title: "장바구니에 담기", style: .purple)

    private var products = StringManager().ChooseProductsVCMockData
    private var isOfferingVariousProducts = false // 다양한 상품 선택가능 여부
    private var isOnSale = false // 상품 가격할인 여부

    private let sumTitleLabel = UILabel().then {
        $0.text = "합계"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let sumLabel = UILabel().then {
        $0.text = "0원"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .dismiss, titleText: "상품 선택")
    }

    // MARK: - UI
    private func configureUI() {
        checkIsOfferingVariousProducts()
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        scrollView.backgroundColor = .lightGray
        contentView.backgroundColor = .white
    }

    private func setContraints() {
        [separator, scrollView].forEach {
            view.addSubview($0)
        }
        scrollView.addSubview(contentView)
        separator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.equalTo(500)
        }
        isOfferingVariousProducts ? generateVariousProductsViews() : generateProductViews()
    }

    private func generateProductViews() {
        let title = products[0]["title"] ?? ""
        let currentPrice = products[0]["originalPrice"] ?? ""
        let priorPrice = products[0]["discountPrice"] ?? ""
        var isOnSale = true
        if priorPrice == "" {
            print("It's not on sale")
            isOnSale = false
        }
        let productView = ChooseProductsDetailView(title: title, currentPrice: currentPrice, priorPrice: priorPrice, isOnSale: isOnSale)
        let separator = UIView().then {
            $0.backgroundColor = .separatorGray
        }

        [productView, separator, sumTitleLabel, sumLabel].forEach {
            view.addSubview($0)
        }
        productView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(productView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(productView)
        }
        sumTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(10)
            $0.leading.equalTo(productView)
            $0.bottom.equalToSuperview().inset(10)
        }
        sumLabel.snp.makeConstraints {
            $0.centerY.equalTo(sumTitleLabel)
            $0.trailing.equalTo(productView)
        }
    }

    private func generateVariousProductsViews() {
        for index in products.indices {
            switch index {
            case 0:
                let categoryTitle = UILabel().then {
                    $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                }
                contentView.addSubview(categoryTitle)
            default:
                break
            }
        }

        let title = products[0]["title"] ?? ""
        let currentPrice = products[0]["originalPrice"] ?? ""
        let priorPrice = products[0]["discountPrice"] ?? ""
        var isOnSale = true
        if priorPrice == "" {
            print("It's not on sale")
            isOnSale = false
        }
        let productView = ChooseProductsDetailView(title: title, currentPrice: currentPrice, priorPrice: priorPrice, isOnSale: isOnSale)
        let separator = UIView().then {
            $0.backgroundColor = .separatorGray
        }

        [productView, separator, sumTitleLabel, sumLabel].forEach {
            view.addSubview($0)
        }
        productView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(productView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(productView)
        }
        sumTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(10)
            $0.leading.equalTo(productView)
            $0.bottom.equalToSuperview().inset(10)
        }
        sumLabel.snp.makeConstraints {
            $0.centerY.equalTo(sumTitleLabel)
            $0.trailing.equalTo(productView)
        }
    }

    // MARK: - Helpers
    private func checkIsOfferingVariousProducts() {
        guard products.count > 1 else { return }
        self.isOfferingVariousProducts = true
    }
}
