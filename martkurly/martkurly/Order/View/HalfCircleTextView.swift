//
//  HalfCircleTextView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class HalfCircleTextView: UITextView {

    // MARK: - Properties

    // MARK: - LifeCycle

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.backgroundColor = .white
        self.isScrollEnabled = false
        self.isEditable = false

        self.text = "샛별배송"
        self.textColor = ColorManager.General.mainPurple.rawValue
        self.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.font = .systemFont(ofSize: 12)

        self.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        self.layer.borderWidth = 1
    }

    func configureAttributes() {

    }

    func configure(text: String,
                   textColor: UIColor,
                   backgroundColor: UIColor,
                   borderColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
    }
}
