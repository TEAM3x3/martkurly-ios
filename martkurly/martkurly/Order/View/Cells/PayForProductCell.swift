//
//  PayForProductCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class PayForProductCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "PayForProductCell"

    private let checkmarkButton = AgreementCheckMarkView()
    private lazy var paymentAgreeView = UIView().then {
        $0.backgroundColor = .clear

        let label = UILabel()
        label.text = "결제 진행 필수 동의"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)

        $0.addSubview(checkmarkButton)
        $0.addSubview(label)

        checkmarkButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.height.width.equalTo(24)
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(checkmarkButton.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedPaymentNext))
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
    }

    private let agreeContentsLabel = UILabel().then {
        let blackAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        let lightGrayAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.lightGray
        ]

        let attributesString = NSMutableAttributedString(
            string: "개인정보 수집・이용 및 위탁 동의", attributes: blackAttributes)
        attributesString.append(NSAttributedString(
                                    string: " (필수)", attributes: lightGrayAttributes))
        $0.attributedText = attributesString
    }

    private let clauseViewLabel = UILabel().then {
        $0.text = "약관보기 〉"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.font = .systemFont(ofSize: 14)
    }

    let paymentButton = KurlyButton(title: "결제하기",
                                            style: .purple)

    private let paymentInfomationLabel = UILabel().then {
        $0.text = """
        * 직접 주문취소는 '입금확인' 상태일 경우에만 가능합니다.
        * 미성년자가 결제 시 법정대리인이 그 거래를 취소할 수 있습니다.
        """
        $0.setLineSpacing(lineSpacing: 4)
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func tappedPaymentNext() {
        checkmarkButton.isActive.toggle()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear

        [paymentAgreeView, agreeContentsLabel, clauseViewLabel, paymentButton, paymentInfomationLabel].forEach {
            self.addSubview($0)
        }

        paymentAgreeView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }

        agreeContentsLabel.snp.makeConstraints {
            $0.top.equalTo(paymentAgreeView.snp.bottom)
            $0.leading.equalTo(paymentAgreeView).offset(32)
        }

        clauseViewLabel.snp.makeConstraints {
            $0.centerY.equalTo(agreeContentsLabel)
            $0.trailing.equalToSuperview().inset(orderVCSideInsetValue)
        }

        paymentButton.snp.makeConstraints {
            $0.top.equalTo(clauseViewLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        paymentInfomationLabel.snp.makeConstraints {
            $0.top.equalTo(paymentButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(orderVCSideInsetValue)
            $0.bottom.equalToSuperview().offset(-28)
        }
    }
}
