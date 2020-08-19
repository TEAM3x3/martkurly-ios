//
//  OrderCancelNotice.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class OrderCancelNoticeView: UIView {

    // MARK: - Properties
    private let title = UILabel().then {
        $0.text = StringManager.orderCancelNotice.orderCancelNoticeTitle.rawValue
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
    }

    private let depositIdentify1 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentify1.rawValue
    }

    private let depositIdentify2 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentify2.rawValue
    }

    private let depositIdentify3 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentify3.rawValue
    }

    private let depositIdentifyAfter1 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentifyAfter1.rawValue
    }

    private let depositIdentifyAfter2 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.depositIdentifyAfter2.rawValue
    }

    private let paymentCancelRefund1 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.paymentCancelRefund1.rawValue
    }

    private let paymentCancelRefund2 = UILabel().then {
        $0.text = StringManager.orderCancelNotice.paymentCancelRefund2.rawValue
    }

    lazy var moreButton = UIButton().then {
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
    }

    private let line = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let buttonTitle = UILabel().then {
        $0.text = "자세히 보기"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = ColorManager.General.mainPurple.rawValue
    }

    private let chevron = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = ColorManager.General.chevronGray.rawValue
    }

    lazy var moreView = CancelMoreNoticeView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue

    }

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selector
    @objc func selectButton(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            chevron.image = UIImage(systemName: "chevron.up")
            self.addSubview(moreView)
            moreView.snp.makeConstraints {
                $0.top.equalTo(moreButton.snp.bottom)
                $0.leading.equalToSuperview()
                $0.width.equalTo(self.snp.width)
                $0.height.equalToSuperview()
            }
        } else {
            chevron.image = UIImage(systemName: "chevron.down")
            moreView.removeFromSuperview()
        }
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        [depositIdentify1, depositIdentify2, depositIdentify3, depositIdentifyAfter1, depositIdentifyAfter2, paymentCancelRefund1, paymentCancelRefund2].forEach {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = ColorManager.General.whyKurlyText.rawValue
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            }
        }
        [title, moreButton, line, chevron, buttonTitle].forEach {
            self.addSubview($0)
        }

        [depositIdentify1, depositIdentifyAfter1, paymentCancelRefund1].forEach {
            $0.font = UIFont.boldSystemFont(ofSize: 14)
        }

        title.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(64)
            $0.centerX.equalToSuperview()
        }
        depositIdentify1.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(32)
        }
        depositIdentify2.snp.makeConstraints {
            $0.top.equalTo(depositIdentify1.snp.bottom).offset(4)
        }
        depositIdentify3.snp.makeConstraints {
            $0.top.equalTo(depositIdentify2.snp.bottom).offset(4)
        }
        depositIdentifyAfter1.snp.makeConstraints {
            $0.top.equalTo(depositIdentify3.snp.bottom).offset(16)
        }
        depositIdentifyAfter2.snp.makeConstraints {
            $0.top.equalTo(depositIdentifyAfter1.snp.bottom).offset(4)
        }
        paymentCancelRefund1.snp.makeConstraints {
            $0.top.equalTo(depositIdentifyAfter2.snp.bottom).offset(16)
        }
        paymentCancelRefund2.snp.makeConstraints {
            $0.top.equalTo(paymentCancelRefund1.snp.bottom).offset(4)
        }
        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.bottom)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(50)
        }
        line.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.width.equalTo(self.snp.width)
            $0.top.leading.equalTo(moreButton)
        }

        buttonTitle.snp.makeConstraints {
            $0.centerX.centerY.equalTo(moreButton)
        }
        chevron.snp.makeConstraints {
            $0.centerY.equalTo(moreButton)
            $0.trailing.equalTo(moreButton.snp.trailing).inset(8)
        }
    }
}
