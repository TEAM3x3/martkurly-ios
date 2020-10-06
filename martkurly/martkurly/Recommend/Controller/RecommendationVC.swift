//
//  RecommendationVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RecommendationVC: UIViewController {

    // MARK: - Properties

    private let recommendationTableView = UITableView()

    private var reviewProducts: ReviewProductsModel?
    private var recommendationList = [RecommendationList]() {
        didSet { recommendationTableView.reloadData() }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchRecommendationData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .purpleType,
                               isShowCart: true,
                               leftBarbuttonStyle: .none,
                               titleText: "추천")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TimerSingleton.shared.timer = Timer.scheduledTimer(timeInterval: 2.5,
                                                           target: self,
                                                           selector: #selector(nextReviews),
                                                           userInfo: nil,
                                                           repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if TimerSingleton.shared.timer != nil {
            TimerSingleton.shared.timer!.invalidate()
            TimerSingleton.shared.timer = nil
        }
    }

    // MARK: - Actions

    func moveProductDetailView(productID: Int) {
        self.showIndicate()
        KurlyService.shared.requestProductDetailData(productID: productID) { reponseData in
            self.stopIndicate()
            let controller = ProductDetailVC()
            controller.hidesBottomBarWhenPushed = true
            controller.productDetailData = reponseData
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Selectros

    @objc func nextReviews() {
        NotificationCenter.default
            .post(name: .init(TimerSingleton.nextReviews),
                  object: nil)
    }

    @objc
    func moreButtonEvent() {
        fetchRecommendationData()
    }

    // MARK: - API

    private let group = DispatchGroup.init()
    private let queue = DispatchQueue.main

    func fetchRecommendationData() {
        let requestURL = [REF_RC_ANIMALS_GOODS,
                          REF_RC_HOME_GOODS,
                          REF_RC_ICECREAM_GOODS,
                          REF_RC_CLEANING_GOODS,
                          REF_RC_RICECAKE_GOODS,
                          REF_RC_SALTEDFISH_GOODS,
                          REF_RC_CHICKEN_GOODS]

        self.showIndicate()
        recommendationList.removeAll()
        requestURL.forEach {
            self.group.enter()
            KurlyService.shared.fetchRecommendationProducts(requestURL: $0) { responseData in
                self.group.leave()
                guard let responseData = responseData else { return }
                let recommendation = RecommendationList(title: responseData.title,
                                                        cellType: responseData.bool ?
                                                            .rankingProductList : .basicProductList,
                                                        goods: responseData.serializers)
                self.recommendationList.append(recommendation)
            }
        }

        group.notify(queue: queue) {
            KurlyService.shared.fetchRecommendationReviewProducts { reviewProducts in
                self.stopIndicate()
                guard let reviewProducts = reviewProducts else { return }
                self.reviewProducts = reviewProducts
                self.recommendationList.insert(RecommendationList(title: "후기가 좋은 상품",
                                                                  cellType: .productAndReviews,
                                                                  goods: []), at: 1)
                self.recommendationList.append(RecommendationList(title: "",
                                                                  cellType: .anotherRecommendation,
                                                                  goods: []))
                self.recommendationTableView.didMoveToSuperview()
            }
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white

        view.addSubview(recommendationTableView)
        recommendationTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        recommendationTableView.backgroundColor = .clear
        recommendationTableView.separatorStyle = .none
        recommendationTableView.allowsSelection = false

        recommendationTableView.dataSource = self
        recommendationTableView.delegate = self

        recommendationTableView.register(RecommendProductListCell.self,
                                         forCellReuseIdentifier: RecommendProductListCell.identifier)
        recommendationTableView.register(RecommendReviewsProductCell.self,
                                         forCellReuseIdentifier: RecommendReviewsProductCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension RecommendationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendationList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch recommendationList[indexPath.row].cellType {
        case .basicProductList: fallthrough
        case .rankingProductList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendProductListCell.identifier,
                for: indexPath) as! RecommendProductListCell
            cell.configure(titleText: recommendationList[indexPath.row].title,
                           productsType: recommendationList[indexPath.row].cellType)
            cell.recommendProducts = recommendationList[indexPath.row].goods
            cell.tappedProductDetailEvent = moveProductDetailView(productID:)
            return cell
        case .productAndReviews:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendReviewsProductCell.identifier,
                for: indexPath) as! RecommendReviewsProductCell
            cell.reviewProducts = reviewProducts
            cell.tappedProductDetailEvent = moveProductDetailView(productID:)
            return cell
        case .anotherRecommendation:
            let cell = RecommendMoreButtonCell()
            cell.moreButton.addTarget(self,
                                      action: #selector(moreButtonEvent),
                                      for: .touchUpInside)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDelegate

extension RecommendationVC: UITableViewDelegate {

}
