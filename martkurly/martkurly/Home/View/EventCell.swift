//
//  EventCell.swift
//  
//
//  Created by 천지운 on 2020/08/25.
//

import UIKit

class EventCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "EventCell"

    let eventImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true

        $0.image = UIImage(named: "TestImage")
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.addSubview(eventImageView)
        eventImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
