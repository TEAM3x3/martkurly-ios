//
//  CategoryMainButtonView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryHeaderV: UIView {

    // MARK: - Properties

    private let titleImage = UIImageView().then {
        $0.backgroundColor = .white
        $0.tintColor = .black
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }

    var title = UILabel().then {
        $0.backgroundColor = .white
    }

    var chevron = UIImageView().then {
        $0.backgroundColor = .white
        $0.tintColor = ColorManager.General.mainGray.rawValue
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
        [line].forEach {
            self.addSubview($0)
        }

        [titleImage, title, chevron].forEach {
            addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self)
            }
        }

        titleImage.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.height.width.equalTo(36)
        }

        title.snp.makeConstraints {
            $0.leading.equalTo(titleImage.snp.trailing).offset(8)
        }

        chevron.snp.makeConstraints {
            $0.trailing.equalTo(self).inset(16)
        }

        line.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom)
            $0.leading.width.equalTo(self)
            $0.height.equalTo(1)
        }
    }

    func configure(image: String, setTitle: String, direction: String) {
        titleImage.kf.setImage(with: URL(string: image))
        title.text = setTitle
        chevron.image = UIImage(systemName: direction)
    }
}
