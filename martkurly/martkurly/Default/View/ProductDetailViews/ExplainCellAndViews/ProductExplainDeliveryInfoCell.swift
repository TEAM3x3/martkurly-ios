//
//  ProductExplainDeliveryInfoCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainDeliveryInfoCell: UITableViewCell {

    // MARK: - String Temp

    enum ConductType {
        case basic
        case holiday
    }

    struct DeliveryString {
        static let titleString = "배송안내"
        static let starsTitle = "샛별배송"
        static let starsConduct = "밤 11시까지 주문하면, 다음날 아침 7시 이전 도착"

        static let basicTitle = "택배배송"
        static let basicConduct = "밤 8시까지 주문하면, 다음날 도착"

        static let holidayTitle = "배송휴무"
        static let holidayConduct = """
        샛별배송 - 휴무없음 / 택배배송 - 일요일
        택배배송의 경우, 지역에 따라
        토요일 배송이 불가할 수 있습니다.
        """
    }

    // MARK: - Properties

    static let identifier = "ProductExplainDeliveryInfoCell"

    private let defaultPaddingValue: CGFloat = 20
    private let defaultInsetValue: CGFloat = 24

    private let topLineView = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let borderView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderColor = ColorManager.General.backGray.rawValue.cgColor
        $0.layer.borderWidth = 1
    }

    private let titleLabel = UILabel().then {
        $0.text = DeliveryString.titleString
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18)
    }

    private lazy var starsStackView = makeStackView(type: .basic,
                                                    titleText: DeliveryString.starsTitle,
                                                    conductText: DeliveryString.starsConduct)
    private lazy var basicStackView = makeStackView(type: .basic,
                                                    titleText: DeliveryString.basicTitle,
                                                    conductText: DeliveryString.basicConduct)
    private lazy var holidayStackView = makeStackView(type: .holiday,
                                                    titleText: DeliveryString.holidayTitle,
                                                    conductText: DeliveryString.holidayConduct)

    private lazy var deliveryDetailButton = UIButton(type: .system).then {
        $0.setTitle("자세히 보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(clickedButton), for: .touchUpInside)

        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.chevronGray.rawValue.cgColor
        $0.layer.cornerRadius = 36 / 2

        $0.snp.makeConstraints {
            $0.width.equalTo(172)
            $0.height.equalTo(36)
        }
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
    func clickedButton(_ sender: UIButton) {

    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        [topLineView, borderView, titleLabel, starsStackView, deliveryDetailButton].forEach {
            self.addSubview($0)
        }

        topLineView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(defaultPaddingValue)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }

        borderView.snp.makeConstraints {
            $0.top.equalTo(topLineView.snp.bottom).offset(defaultPaddingValue)
            $0.leading.equalToSuperview().offset(defaultPaddingValue)
            $0.trailing.equalToSuperview().offset(-defaultPaddingValue)
            $0.bottom.equalTo(deliveryDetailButton).offset(defaultInsetValue)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(borderView).offset(defaultInsetValue)
            $0.centerX.equalToSuperview()
        }

        let stackList = UIStackView(arrangedSubviews: [
            starsStackView, basicStackView, holidayStackView
        ])
        stackList.axis = .vertical
        stackList.spacing = 8

        self.addSubview(stackList)
        stackList.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(borderView).offset(defaultInsetValue)
            $0.trailing.equalTo(borderView).offset(-defaultInsetValue)
        }

        deliveryDetailButton.snp.makeConstraints {
            $0.top.equalTo(stackList.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
    }

    func makeStackView(type: ConductType,
                       titleText: String,
                       conductText: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.textColor = type == .basic ? ColorManager.General.mainPurple.rawValue :
            ColorManager.General.mainGray.rawValue
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(52)
        }

        let conductLabel = UILabel()
        conductLabel.text = conductText
        conductLabel.textColor = type == .basic ? .black : ColorManager.General.mainGray.rawValue
        conductLabel.font = .systemFont(ofSize: 12)
        conductLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [titleLabel, conductLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .top

        return stack
    }
}
