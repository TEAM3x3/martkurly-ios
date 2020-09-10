//
//  EventProductListVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class EventProductDetailListVC: UIViewController {

    // MARK: - Properties

    private let productListView = ProductListView(headerType: .fastAreaAndCondition)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: .pop,
                                    titleText: "테스트")
    }

    // MARK: - Actions

    func tappedProduct(productID: Int) {
        let controller = ProductDetailVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        [productListView].forEach {
            view.addSubview($0)
        }

        productListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureAttributes() {
        productListView.tappedProduct = tappedProduct(productID:)
    }
}
