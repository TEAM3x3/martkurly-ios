//
//  AgreementCheckMarkView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/21/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class AgreementCheckMarkView: UIView {

    // MARK: - Properties
    private let imageView = UIImageView().then {
        $0.image = ImageManager.Agreement.unchecked.rawValue
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    var isActive = false {
        willSet {
            imageView.image = newValue == false ? ImageManager.Agreement.unchecked.rawValue : ImageManager.Agreement.checked.rawValue
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setConstraints()
    }

    private func setConstraints() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
