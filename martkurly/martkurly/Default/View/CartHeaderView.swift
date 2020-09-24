//
//  CartHeaderView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CartHeaderView: UIView {

    // MARK: - Properties

    var storage = "냉장"

    lazy var shipping = UILabel().then {
        $0.text = "\(storage) 박스로 배송됩니다"
        $0.textColor = .black
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setConstraints() {
        setConfigure()
    }

    private func setConfigure() {
        [shipping].forEach {
            self.addSubview($0)
        }
        backgroundColor = .red

    }
}
