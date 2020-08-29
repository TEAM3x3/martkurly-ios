//
//  CategoryMainButtonView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryMainButton: UIButton {

    // MARK: - Properties
    private let titleImage = UIImageView().then {
        $0.backgroundColor = .white
        $0.tintColor = .black
    }

    var title = UILabel().then {
        $0.backgroundColor = .white
    }

    var chevron = UIImageView().then {
        $0.backgroundColor = .white
    }

    private let line = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
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
        self.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        backgroundColor = .white
        [titleImage, title, chevron].forEach {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.snp.centerY)
            }
        }
        addSubview(line)

        titleImage.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(16)
        }
        title.snp.makeConstraints {
            $0.leading.equalTo(titleImage.snp.trailing).offset(8)
        }
        chevron.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).inset(16)
        }
        line.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom)
            $0.leading.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
    }

    func configure(image: String, setTitle: String) {
        titleImage.image = UIImage(named: image)
        title.text = setTitle
    }
}
