//
//  MainBannerViewCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/06.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MainBannerViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainBannerViewCell"

    var eventModel: EventModel? {
        didSet { configure() }
    }

    var tappedBannerEvent: ((Int) -> Void)?

    private let eventImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func handleTapGesture() {
        guard let eventModel = eventModel else { return }
        tappedBannerEvent?(eventModel.id)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        self.addSubview(eventImageView)
        eventImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }

    func configure() {
        guard let eventModel = eventModel else { return }

        let imageURL = URL(string: eventModel.image)
        eventImageView.kf.setImage(with: imageURL)
    }
}
