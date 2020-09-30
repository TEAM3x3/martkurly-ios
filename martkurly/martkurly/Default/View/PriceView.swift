//
//  PriceView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/16.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class PriceView: UITableViewCell {

    // MARK: - Propertise
    private var data = [Cart]()

    private let sumLabel = UILabel().then {
        $0.text = "상품금액"
    }
    var sumCount = UILabel().then {
        $0.text = "0"
    }
    private let sumWon = UILabel().then {
        $0.text = "원"
    }

    private let discountLabel = UILabel().then {
        $0.text = "상품할인금액"
    }
    var discountCount = UILabel().then {
        $0.text = "0"
    }
    private let discountWon = UILabel().then {
        $0.text = "원"
    }

    private let shipLabel = UILabel().then {
        $0.text = "배송비"
    }
    var shipCount = UILabel().then {
        $0.text = "0"
    }
    private let shipWon = UILabel().then {
        $0.text = "원"
    }

    var shippingMoney = 0
    private lazy var freeShipMoney = UILabel().then {
        let shippingMoneyAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: ColorManager.General.mainPurple.rawValue
        ]

        let attributeString = NSAttributedString(
            string: "\(shippingMoney) 원",
            attributes: shippingMoneyAttribute
        )

        $0.attributedText = attributeString
    }

    let shipMoney = UILabel().then {
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.text = "원 추가주문 시,"
        $0.font = .systemFont(ofSize: 12)
    }

    let freeShip = UILabel().then {
        $0.text = "무료배송"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = .boldSystemFont(ofSize: 12)
    }

    private let line = UIView().then {
        $0.backgroundColor = .lightGray
    }

    private let estimateSumLabel = UILabel().then {
        $0.text = "결제예정금액"
    }
    var estimateSumCount = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }

    private let estimateWon = UILabel().then {
        $0.text = "원"
    }

    let savingButton = UIButton().then {
        $0.setTitle("적립", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 10)
        $0.backgroundColor = .orange
        $0.layer.borderWidth = 1
    }

    let saving1 = UILabel().then {
        $0.text = "구매 시"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
    }

    var savingPrice = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }

    let saving2 = UILabel().then {
        $0.text = "원 적립"
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }

    private let cupon = UILabel().then {
        $0.text = "* 쿠폰, 적립금은 다음화면인 '주문서'에서 확인가능합니다."
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 10)
    }

    var hide = true {
        didSet {

        }
    }

    // MARK: - Lifecycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setConfigure()
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConfigure() {
        contentView.backgroundColor = .white
        [sumLabel, sumCount, discountLabel, discountCount, shipLabel, shipCount, line, estimateSumLabel, estimateSumCount, estimateWon, sumWon, discountWon, shipWon, cupon].forEach {
            contentView.addSubview($0)
        }
        [sumLabel, sumCount, discountLabel, discountCount, shipLabel, shipCount, estimateSumLabel, estimateSumCount, estimateWon, sumWon, discountWon, shipWon, cupon].forEach {
            $0.textColor = .black
        }

        [freeShipMoney, shipMoney, freeShip].forEach {
            contentView.addSubview($0)
            $0.textColor = ColorManager.General.mainPurple.rawValue
            $0.snp.makeConstraints {
                $0.top.equalTo(shipWon.snp.bottom).offset(8)
            }
        }

        [saving1, saving2, savingPrice].forEach {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(estimateWon.snp.bottom).offset(4)
            }
        }

//        if hide {
//            [freeShipMoney, shipMoney, freeShip, saving1, saving2, savingPrice, savingButton].forEach {
//                $0.isHidden = false
//            }
//        } else {
//            [freeShipMoney, shipMoney, freeShip, saving1, saving2, savingPrice, savingButton].forEach {
//                $0.isHidden = true
//            }
//        }

        addSubview(savingButton)

        sumLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(16)
        }

        sumCount.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.top)
            $0.trailing.equalToSuperview().inset(36)
        }

        sumWon.snp.makeConstraints {
            $0.top.equalTo(sumCount.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }

        discountLabel.snp.makeConstraints {
            $0.top.equalTo(sumLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        discountCount.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.top)
            $0.trailing.equalToSuperview().inset(36)
        }

        discountWon.snp.makeConstraints {
            $0.top.equalTo(discountCount.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }

        shipLabel.snp.makeConstraints {
            $0.top.equalTo(discountLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        shipCount.snp.makeConstraints {
            $0.top.equalTo(shipLabel.snp.top)
            $0.trailing.equalToSuperview().inset(36)
        }

        shipWon.snp.makeConstraints {
            $0.top.equalTo(shipCount.snp.top)
            $0.trailing.equalToSuperview().inset(16)
        }

        freeShipMoney.snp.makeConstraints {
            $0.trailing.equalTo(shipMoney.snp.leading).offset(-4)
        }

        freeShip.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
        }

        shipMoney.snp.makeConstraints {
            $0.trailing.equalTo(freeShip.snp.leading).offset(-4)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(shipMoney.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().offset(16).inset(16)
            $0.height.equalTo(1)
        }

        estimateSumLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }

        estimateSumCount.snp.makeConstraints {
            $0.bottom.equalTo(estimateSumLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(36)
        }

        estimateWon.snp.makeConstraints {
            $0.bottom.equalTo(estimateSumCount.snp.bottom)
            $0.trailing.equalToSuperview().inset(16)
        }

        saving2.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
        }

        savingPrice.snp.makeConstraints {
            $0.trailing.equalTo(saving2.snp.leading).offset(-4)
        }

        saving1.snp.makeConstraints {
            $0.trailing.equalTo(savingPrice.snp.leading).offset(-4)
        }

        savingButton.snp.makeConstraints {
            $0.trailing.equalTo(saving1.snp.leading).offset(-8)
            $0.centerY.equalTo(saving2.snp.centerY)
            $0.height.equalTo(20)
        }
        savingButton.layer.cornerRadius = 10

        cupon.snp.makeConstraints {
            $0.top.equalTo(saving2.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }

    }

    func configure(money: Int, data: [Cart]) {
        shippingMoney = money
        self.data = data
    }
}
