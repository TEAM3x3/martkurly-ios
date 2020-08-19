//
//  WhyKurlySubView.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class WhyKurlySubView: UIView {

    // MARK: - Properties
    private let iconView = UIImageView().then {
        $0.image = ImageManager.WhyKurly.content1.rawValue
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then {
        $0.text = "깐깐한 상품위원회"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }
    private let contentLabel = UILabel().then {
        $0.text = "Content"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = ColorManager.General.text.rawValue
        $0.numberOfLines = 0
    }
    private let infoLabel = UILabel().then {
        $0.text = "Subtitle"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 0
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    // MARK: - UI
    private func configureUI() {
        setPropertyAttributes()
    }

    private func setPropertyAttributes() {

    }

    private func setConstraints() {
        if infoLabel.text == "" || infoLabel.text == nil {
            setConstraintsForOnlyContentLayout()
            print("No Info")
        } else {
            setConstraintsForWithSubtitleLayout()
            print("Info")
        }
    }

    private func setConstraintsForOnlyContentLayout() {
        [iconView, titleLabel, contentLabel].forEach {
            self.addSubview($0)
        }
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView).offset(5)
            $0.leading.equalTo(iconView.snp.trailing).offset(20)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
        }
    }

    private func setConstraintsForWithSubtitleLayout() {
        [iconView, titleLabel, contentLabel, infoLabel].forEach {
            self.addSubview($0)
        }
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView).offset(5)
            $0.leading.equalTo(iconView.snp.trailing).offset(20)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
    }

    // MARK: - Helpers
    func configureView(iconImage: UIImage, title: String, content: String, info: String) {
        iconView.image = iconImage
        titleLabel.text = title
        contentLabel.attributedText = setParagraphStyle(text: content, spacing: 3)
        infoLabel.text = info
    }

    func setParagraphStyle(text: String, spacing: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }

}
