//
//  DeliveryAdditionButtonView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DeliveryAdditionButtonView: UIView {

    // MARK: - Properties

    private let additionButton = UIButton(type: .system).then {
        $0.setTitle("+ 새 배송지 추가", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        additionButton.layer.cornerRadius = additionButton.frame.height / 2
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.backgroundColor = .systemRed

        self.addSubview(additionButton)
        additionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(12)
        }
    }

    func configureAttributes() {

    }
}
