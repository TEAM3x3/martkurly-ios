//
//  CurlyRecommendCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CurlyRecommendCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "CurlyRecommendCell"

    private let recommendTableView = UITableView()

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
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(recommendTableView)
        recommendTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        recommendTableView.backgroundColor = .white
        recommendTableView.separatorStyle = .none
        recommendTableView.allowsSelection = false

        recommendTableView.dataSource = self
        recommendTableView.delegate = self

        recommendTableView.register(RecommendImageSliderCell.self,
                                    forCellReuseIdentifier: RecommendImageSliderCell.identifier)
        recommendTableView.register(MainProductListCell.self,
                                    forCellReuseIdentifier: MainProductListCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension CurlyRecommendCell: UITableViewDataSource {
    enum RecommendCellType: Int, CaseIterable {
        case imageSlideCell
        case productRecommendCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return RecommendCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch RecommendCellType(rawValue: section)! {
        case .imageSlideCell: return 1
        default: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch RecommendCellType(rawValue: indexPath.section)! {
        case .imageSlideCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecommendImageSliderCell.identifier,
                for: indexPath) as! RecommendImageSliderCell
            return cell
        case .productRecommendCell:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainProductListCell.identifier,
                for: indexPath) as! MainProductListCell
            cell.cellType = .rightAllowAndSubTitle
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CurlyRecommendCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width

        switch RecommendCellType(rawValue: indexPath.section)! {
        case .imageSlideCell: return screenWidth * 0.92
        default: return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
