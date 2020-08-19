//
//  CancelMoreNoticeView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CancelMoreNoticeView: UIView {

    // MARK: - Properties
    private let ordercanceltitle = UILabel().then {
        $0.text = StringManager.orderCancelMoreNotice.orderCancel.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 14)
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
        self.addSubview(ordercanceltitle)
        ordercanceltitle.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(20)
            $0.leading.equalTo(self.snp.leading).inset(8)
        }
    }

}
