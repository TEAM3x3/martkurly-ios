//
//  CategoryMainButtonView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryMainButtonView: UIButton {

    // MARK: - Properties
    private let titleImage = UIImageView().then {
        $0.backgroundColor = .white
        $0.tintColor = .black
    }

    private let title = UILabel().then {
        $0.backgroundColor = .white
    }

    private let chevron = UIImageView().then {
        $0.backgroundColor = .white
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI

    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        [titleImage, title, chevron].forEach {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.snp.centerY)
            }
        }
        titleImage.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(32)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(titleImage.snp.trailing).offset(16)
        }
        chevron.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).inset(16)
        }
    }

    func configure(image: String, setTitle: String, isSelect: Bool) {
        titleImage.image = UIImage(named: image)
        title.text = setTitle
        var toggle = isSelect
        toggle.toggle()
        if toggle {
            chevron.image = UIImage(systemName: "chevron.up")
            title.textColor = ColorManager.General.mainPurple.rawValue
            titleImage.tintColor = .black
        } else {
            chevron.image = UIImage(systemName: "chevron.down")
            title.textColor = ColorManager.General.whyKurlyText.rawValue
            titleImage.tintColor = .black
        }
    }
}
