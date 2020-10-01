//
//  ReceiveSpaceTextViewCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/01.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReceiveSpaceTextViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ReceiveSpaceTextViewCell"

    var textData: String? {
        return spaceTextView.text
    }

    private let placeHolderLabel = UILabel().then {
        $0.text = "테스트"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let spaceTextView = UITextView().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.textContainerInset = UIEdgeInsets(top: orderVCSideInsetValue,
                                             left: orderVCSideInsetValue,
                                             bottom: orderVCSideInsetValue,
                                             right: orderVCSideInsetValue)
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureAttributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [spaceTextView, placeHolderLabel].forEach {
            self.addSubview($0)
        }

        spaceTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
            $0.height.equalTo(160)
        }

        placeHolderLabel.snp.makeConstraints {
            $0.top.equalTo(spaceTextView).inset(orderVCSideInsetValue)
            $0.leading.trailing.equalTo(spaceTextView).inset(orderVCSideInsetValue + 4)
        }
    }

    func configureAttributes() {
        spaceTextView.delegate = self
    }

    func configure(placeHolder: String?) {
        placeHolderLabel.text = placeHolder
    }
}

// MARK: - UITextViewDelegate

extension ReceiveSpaceTextViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
}
