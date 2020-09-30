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
    var productDetailData: ProductDetail? { // 상품 정보
        didSet { print(productDetailData) }
    }

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

    private var productViews = [ChooseProductsDetailView]() // 각각의 ProductView 가 순서대로 담겨있음
    private let sumTitleLabel = UILabel().then {
        $0.text = "합계"
        $0.font = UIFont.systemFont(ofSize: 16.5, weight: .regular)
    }
    private let sumLabel = UILabel().then {
        $0.text = "0원"
        $0.font = UIFont.systemFont(ofSize: 16.5, weight: .regular)
    }
    private var total = 0 // 총액

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType,
                               isShowCart: false,
                               leftBarbuttonStyle: .dismiss,
                               titleText: "상품 선택")
    }

    // MARK: - UI
    private func configureUI() {
        checkIsOfferingVariousProducts()
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        scrollView.backgroundColor = .backgroundGray
        contentView.backgroundColor = .white

        purchaseButton.addTarget(self, action: #selector(handlePurchaseButton(_:)), for: .touchUpInside)
    }

    private func setContraints() {
        [separator, scrollView, purchaseButton].forEach {
            view.addSubview($0)
        }
        scrollView.addSubview(contentView)
        separator.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(view).inset(10)
            $0.bottom.equalToSuperview()
        }
        isOfferingVariousProducts ? generateVariousProductsViews() : generateProductViews()
        purchaseButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

    private func generateProductViews() {
        print(#function)
        let title = products[0]["title"] ?? ""
        let currentPriceInInt = Int(products[0]["discountPrice"] ?? "0") ?? 0
        let currentPrice = convertToWon(int: currentPriceInInt)
        let priorPriceInInt = Int(products[0]["originalPrice"] ?? "0") ?? 0
        let priorPrice = convertToWon(int: priorPriceInInt)
        var isOnSale = true
        if priorPrice == "" {
            print("It's not on sale")
            isOnSale = false
        }
        let price = isOnSale ? Int(products[0]["discountPrice"] ?? "0") : Int(products[0]["originalPrice"] ?? "0")
        let productView = ChooseProductsDetailView(title: title, currentPrice: currentPrice, priorPrice: priorPrice, price: price!, isOnSale: isOnSale)
        let separator = UIView().then {
            $0.backgroundColor = .separatorGray
        }

        [productView, separator, sumTitleLabel, sumLabel].forEach {
            view.addSubview($0)
        }
        productView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
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
        productViews.append(productView)
    }

    private func generateVariousProductsViews() {
        let categoryTitle = UILabel().then {
            $0.text = products[0]["category"] ?? ""
            $0.textColor = .textMainGray
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
        let categorySeparator = UIView().then {
            $0.backgroundColor = .separatorGray
        }
        var previousView = UIView()

        for index in products.indices {
            switch index {
            case 0:
                [categoryTitle, categorySeparator].forEach {
                    contentView.addSubview($0)
                }
                categoryTitle.snp.makeConstraints {
                    $0.top.equalToSuperview().inset(15)
                    $0.leading.trailing.equalToSuperview().inset(15)
                }
                categorySeparator.snp.makeConstraints {
                    $0.top.equalTo(categoryTitle.snp.bottom).offset(15)
                    $0.leading.trailing.equalToSuperview().inset(15)
                    $0.height.equalTo(1)
                }
            default:
                let title = products[index]["title"] ?? ""
                let currentPriceInInt = Int(products[index]["discountPrice"] ?? "0") ?? 0
                let currentPrice = convertToWon(int: currentPriceInInt)
                let priorPriceInInt = Int(products[index]["originalPrice"] ?? "0") ?? 0
                let priorPrice = convertToWon(int: priorPriceInInt)
                var isOnSale = true
                if priorPrice == "" {
                    print("It's not on sale")
                    isOnSale = false
                }
                let price = isOnSale ? Int(products[index]["discountPrice"] ?? "0") : Int(products[index]["originalPrice"] ?? "0")
                let productView = ChooseProductsDetailView(title: title, currentPrice: currentPrice, priorPrice: priorPrice, price: price!, isOnSale: isOnSale).then {
                    $0.tag = index - 1
                    $0.stepper.subtractButton.tag = index - 1
                    $0.stepper.subtractButton.addTarget(self, action: #selector(handleSteppers(_:)), for: .touchUpInside)
                    $0.stepper.addButton.tag = index - 1
                    $0.stepper.addButton.addTarget(self, action: #selector(handleSteppers(_:)), for: .touchUpInside)
                }

                let separator = UIView().then {
                    $0.backgroundColor = .separatorGray
                }
                [productView, separator].forEach {
                    contentView.addSubview($0)
                }
                if index == 1 {
                    productView.snp.makeConstraints {
                        $0.top.equalTo(categorySeparator.snp.bottom).offset(10)
                        $0.leading.trailing.equalToSuperview().inset(15)
                    }
                    separator.snp.makeConstraints {
                        $0.top.equalTo(productView.snp.bottom).offset(10)
                        $0.leading.trailing.equalTo(productView)
                        $0.height.equalTo(1)
                    }
                } else {
                    productView.snp.makeConstraints {
                        $0.top.equalTo(previousView.snp.bottom).offset(10)
                        $0.leading.trailing.equalToSuperview().inset(15)
                    }
                    separator.snp.makeConstraints {
                        $0.top.equalTo(productView.snp.bottom).offset(10)
                        $0.leading.trailing.equalTo(productView)
                        $0.height.equalTo(1)
                    }
                }
                previousView = separator
                productViews.append(productView)
                // 합계가 생성되는 부분
                if index == products.count - 1 {
                    [sumTitleLabel, sumLabel].forEach {
                        contentView.addSubview($0)
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
            }
        }

    }

    // MARK: - Helpers
    private func checkIsOfferingVariousProducts() {
        guard products.count > 1 else { return }
        self.isOfferingVariousProducts = true
    }

    private func convertToWon(int: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: int))! + "원"
        return result
    }

    // MARK: - Selectors
    @objc
    private func handleSteppers(_ sender: UIButton) {
        let stepper = productViews[sender.tag].stepper
        let price = productViews[sender.tag].price
        switch sender {
        case stepper.subtractButton:
            guard stepper.productCounts >= 1 else { return }
            stepper.productCounts -= 1
            total -= price
        case stepper.addButton:
            stepper.productCounts += 1
            total += price
        default:
            fatalError()
        }
        sumLabel.text = convertToWon(int: total)
    }

    @objc
    private func handlePurchaseButton(_ sender: UIButton) {
        print(#function)
    }
}
