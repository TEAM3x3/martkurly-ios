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

    private var products = [String]()
    private var isOfferingVariousProducts = false // 다양한 상품 선택가능 여부
    private var isOnSale = false // 상품 가격할인 여부

    private var stepper = KurlyStepper()

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
        setAttributes()
        setContraints()
        generateProductViews()
    }

    private func setAttributes() {
        scrollView.backgroundColor = .lightGray
    }

    private func setContraints() {
        [separator, scrollView, stepper].forEach {
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
        stepper.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }

    private func generateProductViews() {

    }
}
