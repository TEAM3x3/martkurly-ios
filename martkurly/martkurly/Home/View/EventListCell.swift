//
//  EventListCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class EventListCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "EventListCell"

    var tappedEventItem: ((Int) -> Void)?

    var eventList = [EventModel]() {
        didSet { eventTableView.reloadData() }
    }

    private lazy var eventTableView = UITableView().then {
        $0.rowHeight = 156
        $0.backgroundColor = .white

        $0.dataSource = self
        $0.delegate = self

        $0.register(EventCell.self,
                    forCellReuseIdentifier: EventCell.identifier)
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        self.addSubview(eventTableView)
        eventTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension EventListCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as! EventCell

        let imageURL = URL(string: eventList[indexPath.section].image)
        cell.eventImageView.kf.setImage(with: imageURL)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - UITableViewDelegate

extension EventListCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedEventItem?(indexPath.section)
    }
}
