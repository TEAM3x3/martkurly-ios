//
//  frequentlyProductView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/12.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class FrequentlyProductEmptyView: UIView {

    // MARK: - Properties
    private let lbl = UILabel().then {
        $0.text = "아직 구매한 상품이 없습니다."
        $0.textColor = ColorManager.General.mainGray.rawValue
    }

    private let btn = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.mainPurple.rawValue.cgColor
        $0.setTitle("베스트 상품 보기", for: .normal)
        $0.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
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
        [lbl, btn].forEach {
            addSubview($0)
        }

        lbl.font = UIFont.systemFont(ofSize: 22)

        lbl.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalToSuperview().offset(132)
        }

        btn.snp.makeConstraints {
            $0.top.equalTo(lbl.snp.bottom).offset(32)
            $0.centerX.equalTo(self)
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }

        btn.clipsToBounds = true
        btn.layer.cornerRadius = 20
    }
    
    func configure() {
        
    }
}
