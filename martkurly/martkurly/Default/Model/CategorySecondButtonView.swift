//
//  CategorySecondButtonView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategorySecondButtonView: UIView {

    // MARK: - Properties
    var btnData: [String] = [] {
        didSet {
            setConfigure()
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        backgroundColor = ColorManager.General.backGray.rawValue
        for i in btnData.indices {
            let btn = UIButton()
            addSubview(btn)

        }
    }
}
