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

    private let recommendList: [RecommendationList] = [
        RecommendationList(title: "정육 인기 급상승 랭킹", cellType: .rankingProductList),
        RecommendationList(title: "후기가 좋은 상품", cellType: .productAndReviews),
        RecommendationList(title: "# 아삭하고 깔끔한 맛, 오이소박이", cellType: .basicProductList),
        RecommendationList(title: "# 남길 걱정 없는 소포장 채소", cellType: .basicProductList),
        RecommendationList(title: "# 내가 한 요리처럼 한 상 차리기", cellType: .basicProductList),
        RecommendationList(title: "# 어제 공유가 많이 된 상품 랭킹", cellType: .rankingProductList),
        RecommendationList(title: "# 홀로 작업할 때 먹기 좋은 간식", cellType: .basicProductList),
        RecommendationList(title: "# 면 요리를 좋아하는 당신을 위한", cellType: .basicProductList),
        RecommendationList(title: "더 많은 상품이 궁금하다면?", cellType: .anotherRecommendation)
    ]

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
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

    // MARK: - Selectros

    @objc func nextReviews() {
        NotificationCenter.default
            .post(name: .init(TimerSingleton.nextReviews),
                  object: nil)
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
        return recommendList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch recommendList[indexPath.row].cellType {
        case .basicProductList: fallthrough
        case .rankingProductList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendProductListCell.identifier,
                for: indexPath) as! RecommendProductListCell
            cell.configure(titleText: recommendList[indexPath.row].title,
                           productsType: recommendList[indexPath.row].cellType)
            return cell
        case .productAndReviews:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendReviewsProductCell.identifier,
                for: indexPath) as! RecommendReviewsProductCell
            return cell
        case .anotherRecommendation:
            return UITableViewCell()
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
