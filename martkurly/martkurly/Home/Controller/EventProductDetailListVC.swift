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

    var eventProducts: EventModel?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Actions

    func tappedProduct(productID: Int) {
        CurlyService.shared.requestProductDetailData(productID: productID) { productDetailData in
            let controller = ProductDetailVC()
            controller.productDetailData = productDetailData
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureLayout()
        configureAttributes()
        configureNavigationBar()
    }

    func configureNavigationBar() {
        guard let eventProducts = eventProducts else { return }
        productListView.products = eventProducts.goods

        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: .pop,
                                    titleText: eventProducts.title)
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
