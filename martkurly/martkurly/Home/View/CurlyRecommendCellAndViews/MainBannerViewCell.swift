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
        self.backgroundColor = .white
    }
}
