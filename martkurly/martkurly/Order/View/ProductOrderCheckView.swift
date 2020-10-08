//
//  ProductOrderCheckView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductOrderCheckView: UIView {

    // MARK: - Properties
    private let check = UIImageView()

    let formatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 18),
        .foregroundColor: UIColor.black
    ]

    private let grayAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: ColorManager.General.mainGray.rawValue
    ]

    private let gray12Attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: ColorManager.General.mainGray.rawValue
    ]

    private let bold12Attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 12),
        .foregroundColor: ColorManager.General.mainGray.rawValue
    ]

    private let boldAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 18),
        .foregroundColor: UIColor.black
    ]

    private let boldPaymentAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 18),
        .foregroundColor: ColorManager.General.mainGray.rawValue
    ]

    private let boldWonAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 24),
        .foregroundColor: UIColor.black
    ]

    var name: String = "안준영" {
        didSet {
            configure()
        }
    }
    private let orderCompleteStr: String = "님의 주문이 완료되었습니다."
    private var nameLabel = UILabel()

    private let morning: String = "내일 아침"
    private let morning1: String = "에 만나요!"
    private let morningLabel = UILabel()

    private let line = UIView()

    private let paymentLabel = UILabel()

    var payment = 0 {
        didSet {
            configure()
        }
    }
    private let paymentWon = UILabel()

    private let StringStr = UILabel()

    let orderListButton = KurlyButton(title: "주문내역 상세보기", style: .white)

    private let notice = UILabel()
    private let notice1 = UILabel()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        [check, nameLabel, morningLabel, line, paymentLabel, paymentWon, StringStr, orderListButton, notice, notice1].forEach {
            self.addSubview($0)
        }

        self.backgroundColor = UIColor.white
        let largeConfiguration = UIImage.SymbolConfiguration(pointSize: 60, weight: .ultraLight, scale: .unspecified)
        check.image = UIImage(systemName: "checkmark.circle", withConfiguration: largeConfiguration)
        check.tintColor = ColorManager.General.mainPurple.rawValue

        let morningStr = NSMutableAttributedString(
            string: morning,
            attributes: boldAttributes)
        morningStr.append(NSAttributedString(string: morning1, attributes: attributes))
        morningLabel.attributedText = morningStr

        line.backgroundColor = ColorManager.General.backGray.rawValue

        let paymentStr = NSAttributedString(
            string: "결제금액",
            attributes: boldPaymentAttributes)
        paymentLabel.attributedText = paymentStr

        let str = NSAttributedString(
            string: "* 적립금은 배송당일에 적립됩니다.",
            attributes: grayAttributes)
        StringStr.attributedText = str

        let noticeStr = NSMutableAttributedString(
            string: "'입금확인'", attributes: bold12Attributes)
        noticeStr.append(NSAttributedString(string: "상태일 때는 주문내역 상세 페이지에서 직접 주문 취소가", attributes: gray12Attributes))
        notice.attributedText = noticeStr

        let noticeStr1 = NSAttributedString(
            string: "가능합니다.",
            attributes: gray12Attributes)
        notice1.attributedText = noticeStr1

    }

    private func setUI() {
        check.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.top.equalToSuperview().offset(96)
        }

        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(check.snp.bottom).offset(8)
        }

        morningLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(morningLabel.snp.bottom).offset(32)
            $0.height.equalTo(2)
            $0.width.equalToSuperview()
        }

        paymentLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(16)
            $0.leading.equalTo(self.snp.leading).offset(16)
        }

        paymentWon.snp.makeConstraints {
            $0.top.equalTo(paymentLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.snp.leading).offset(16)
        }

        StringStr.snp.makeConstraints {
            $0.top.equalTo(paymentWon.snp.bottom).offset(8)
            $0.leading.equalTo(self.snp.leading).offset(16)
        }

        orderListButton.snp.makeConstraints {
            $0.top.equalTo(StringStr.snp.bottom).offset(16)
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).inset(16)
            $0.height.equalTo(55)
        }

        notice.snp.makeConstraints {
            $0.top.equalTo(orderListButton.snp.bottom).offset(16)
            $0.leading.equalTo(self.snp.leading).offset(16)
            $0.trailing.equalTo(self.snp.trailing).inset(16)
        }

        notice1.snp.makeConstraints {
            $0.top.equalTo(notice.snp.bottom).offset(8)
            $0.leading.equalTo(self.snp.leading).offset(16)
        }
    }

    func configure() {
        let nameStr = NSMutableAttributedString(
            string: name,
            attributes: boldAttributes)
        nameStr.append(NSAttributedString(string: orderCompleteStr, attributes: attributes))
        nameLabel.attributedText = nameStr

        let won = NSMutableAttributedString(
            string: (formatter.string(for: payment as NSNumber) ?? "0"),
            attributes: boldWonAttributes)
        won.append(NSAttributedString(string: " 원", attributes: boldPaymentAttributes))
        paymentWon.attributedText = won
    }
}
