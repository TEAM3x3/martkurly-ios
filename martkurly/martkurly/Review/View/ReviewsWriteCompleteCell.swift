//
//  ReviewsWriteCompleteCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewsWriteCompleteCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ReviewsWriteCompleteCell"

    private let reviewsTableView = UITableView(frame: .zero, style: .grouped)

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
        self.backgroundColor = .systemBlue
        configureLayout()
    }

    func configureLayout() {
        self.addSubview(reviewsTableView)
        reviewsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        reviewsTableView.backgroundColor = ColorManager.General.backGray.rawValue
        reviewsTableView.separatorStyle = .none

        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self

        reviewsTableView.register(ReviewCompleteCell.self,
                                  forCellReuseIdentifier: ReviewCompleteCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ReviewsWriteCompleteCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReviewCompleteCell.identifier,
            for: indexPath) as! ReviewCompleteCell
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ReviewsWriteCompleteCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
}
