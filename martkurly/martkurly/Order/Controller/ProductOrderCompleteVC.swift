//
//  ProductOrderCompleteVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/10/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductOrderCompleteVC: UIViewController {

    // MARK: - Properties
    let checkView = ProductOrderCheckView()
    let line = UIView()

    private let goHomeButton = KurlyButton(title: "홈으로 이동", style: .purple)

    var orderName = ""
    var orderPay = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .dismiss,
                                    titleText: "주문완료")
    }

    // MARK: - UI
    private func setConfigure() {
        [checkView, line, goHomeButton].forEach {
            view.addSubview($0)
        }

        view.backgroundColor = ColorManager.General.backGray.rawValue
        line.backgroundColor = ColorManager.General.mainGray.rawValue

        checkView.name = orderName // 유저 이름
        checkView.payment = orderPay // 결제 금액
        checkView.orderListButton.addTarget(self, action: #selector(orderListButtonTap(_:)), for: .touchUpInside)
        goHomeButton.addTarget(self, action: #selector(goHomeButtonTap(_:)), for: .touchUpInside)
    }

    @objc
    func orderListButtonTap(_ sender: UIButton) {
        print("주문 내역이 없습니다.")
    }

    @objc
    func goHomeButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }

    private func setUI() {
        checkView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalTo(goHomeButton.snp.top).offset(8)
            $0.centerX.equalToSuperview()
        }

        line.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }

        goHomeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().offset(8)
            $0.width.equalTo(checkView)
            $0.height.equalTo(55)
        }
    }
}
