//
//  TruckStatusView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/04.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class TruckStatusView: UILabel {

    // MARK: - Properties
    private var count: StatusCount = 3
    var isActive = true {
        didSet {
            configureTruckStatus()
        }
    }

    // MARK: - Lifecycle
    init(count: StatusCount) {
        super.init(frame: .zero)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
        setConstraints()
    }

    private func setPropertyAttributes() {
        self.backgroundColor = .clear
    }

    private func setConstraints() {

    }

    private func
}
