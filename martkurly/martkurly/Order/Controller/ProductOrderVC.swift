//
//  ProductOrderVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/24.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

let orderVCSideInsetValue: CGFloat = 20

class ProductOrderVC: UIViewController {

    // MARK: - Properties

    var orderData = [CartItem]() {
        didSet { orderTableView.reloadData() }
    }

    var orderID: Int?

    var orderMainPaymentPrice = 0               // 주문 금액
    var orderProductPaymentPrice = 0            // 상품 금액
    var orderDiscountPaymentPrice = 0           // 상품 할인 금액
    var orderDeliveryPaymentPrice = 0           // 배송비
    var orderAmountPaymentPrice = 0             // 최종 결제 금액

    private let orderTableView = UITableView(frame: .zero, style: .grouped)

    private var undeliveryType: UnDeliveryActionType = .paymentRefund {
        didSet {
            orderTableView.reloadData()
            orderDeliveryActionHeaderView.actionContentsLabel.text = undeliveryType.description
        }
    }

    private var userAddressList = [AddressModel]() {
        didSet { orderTableView.reloadData() }
    }

    // 상품정보
    private var isShowProductList: Bool = false {
        didSet { orderTableView.reloadData() }
    }
    private let orderProductInfomationHeaderView = OrderProductInfomationHeaderView()

    // 주문자 정보
    private var isShowOrdererList: Bool = false {
        didSet { orderTableView.reloadData() }
    }
    private let ordererInfomationHeaderView = OrdererInfomationHeaderView()

    // 배송지
    private let orderDeliveryHeaderView = OrderDeliveryHeaderView()
    private var deliverySpace: AddressModel?

    // 받으실 장소
    private let orderReceiveSpaceHeaderView = OrderReceiveSpaceHeaderView()
    private var deliverySpaceData: DeliverySpaceModel?

    // 결제 금액
    private let orderPaymentPriceHeaderView = OrderPaymentPriceHeaderView()
    private var paymentTypes: [PaymentCellType] = [.orderPricePayment,
                                               .productPricePayMent,
                                               .discountPricePayment,
                                               .deliveryPricePayment,
                                               .amountPricePayment]

    // 결제 수단
    private var selectPaymentType: PaymentType = .creditCard {
        didSet { methodsOfPaymentHeaderView.paymentType = selectPaymentType }
    }
    private var isShowPaymentList: Bool = false {
        didSet { orderTableView.reloadData() }
    }
    private let methodsOfPaymentHeaderView = MethodsOfPaymentHeaderView()

    // 상품 미배송 시 조치
    private var isShowActionList: Bool = false {
        didSet { orderTableView.reloadData() }
    }
    private let orderDeliveryActionHeaderView = OrderDeliveryActionHeaderView()

    // Formatter
    private lazy var priceFormatter = NumberFormatter().then {
        $0.numberStyle = .decimal    // 천 단위로 콤마(,)

        $0.minimumFractionDigits = 0    // 최소 소수점 단위
        $0.maximumFractionDigits = 0    // 최대 소수점 단위
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestUserAddressList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .pop,
                                    titleText: "주문서")
    }

    // MARK: - API

    func requestUserAddressList() {
        self.showIndicate()
        AddressService.shared.requestAddressList(userPK: 1) { addressList in
            self.userAddressList = addressList
            self.stopIndicate()
        }
    }

    // MARK: - Action

    func reloadTableViewSection(section: Int) {
        orderTableView.reloadSections(IndexSet(integer: section), with: .none)
    }

    func selectedPaymentType(type: Int) {
        selectPaymentType = PaymentType(rawValue: type)!
    }

    // MARK: - Selectors

    @objc
    func tappedInfoHeaderView(_ sender: UITapGestureRecognizer) {
        guard let intName = Int(sender.name ?? "") else { return }
        switch OrderCellType(rawValue: intName)! {
        case .productInfomation:
            isShowProductList.toggle()
            orderProductInfomationHeaderView.isShowProductList = isShowProductList
        case .ordererInfomation:
            isShowOrdererList.toggle()
            ordererInfomationHeaderView.isShowOrdererList = isShowOrdererList
        case .orderDelivery:
            let controller = UserDeliverySettingVC()
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        case .orderReceiveSpace:
            let controller = ReceiveSpaceSettingVC()
            controller.delegate = self
            let naviVC = UINavigationController(rootViewController: controller)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true)
        case .methodsOfPayMent:
            isShowPaymentList.toggle()
            methodsOfPaymentHeaderView.isShowPaymentList = isShowPaymentList
        case .deliveryAction:
            isShowActionList.toggle()
            orderDeliveryActionHeaderView.isShowActionList = isShowActionList
        default: break
        }
    }

    @objc
    func tappedPayForButton(_ sender: UIButton) {
        guard let orderID = orderID,
              let currentUser = UserService.shared.currentUser,
              let deliverySpaceData = deliverySpaceData,
              let deliverySpace = deliverySpace else { return }
        print(currentUser.phone)

        self.showIndicate()
        KurlyService.shared.createOrderDetail(
            orderID: orderID,
            delivery_cost: orderDeliveryPaymentPrice,
            consumer: currentUser.username,
            receiver: currentUser.nickname,
            receiver_phone: currentUser.phone,
            delivery_type: deliverySpace.address.contains("서울") || deliverySpace.address.contains("경기") ? "샛별배송" : "택배배송",
            zip_code: "123456",
            address: "\(deliverySpace.address) \(deliverySpace.detail_address)",
            receiving_place: deliverySpaceData.receiving_place,
            entrance_password: deliverySpaceData.entrance_password,
            free_pass: deliverySpaceData.free_pass,
            etc: deliverySpaceData.etc,
            extra_message: deliverySpaceData.extra_message,
            message: deliverySpaceData.message ?? true,
            payment_type: selectPaymentType.description) { result in
            self.stopIndicate()
            switch result {
            case true:
                let orderComplete = ProductOrderCompleteVC()
                orderComplete.orderName = currentUser.nickname
                orderComplete.orderPay = self.orderAmountPaymentPrice
                self.navigationController?.pushViewController(orderComplete, animated: true)
                print("DEBUG: SUCCESS")
            case false:
                print("DEBUG: FAIL")
            }
        }
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = .white

        let underLine = UIView().then {
            $0.backgroundColor = ColorManager.General.chevronGray.rawValue
        }

        [underLine, orderTableView].forEach {
            view.addSubview($0)
        }

        underLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }

        orderTableView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureAttributes() {
        orderTableView.backgroundColor = ColorManager.General.backGray.rawValue
        orderTableView.separatorStyle = .none
        orderTableView.allowsSelection = true

        orderTableView.dataSource = self
        orderTableView.delegate = self

        orderTableView.register(ProductInfomationCell.self,
                                forCellReuseIdentifier: ProductInfomationCell.identifier)
        orderTableView.register(OrderMainPaymentPriceCell.self,
                                forCellReuseIdentifier: OrderMainPaymentPriceCell.identifier)
        orderTableView.register(OrderSubPaymentPriceCell.self,
                                forCellReuseIdentifier: OrderSubPaymentPriceCell.identifier)
        orderTableView.register(DeliveryActionCell.self,
                                forCellReuseIdentifier: DeliveryActionCell.identifier)

        addTapGesture(addView: orderProductInfomationHeaderView,
                      gestureName: OrderCellType.productInfomation.rawValue)
        addTapGesture(addView: ordererInfomationHeaderView,
                      gestureName: OrderCellType.ordererInfomation.rawValue)
        addTapGesture(addView: orderDeliveryHeaderView,
                      gestureName: OrderCellType.orderDelivery.rawValue)
        addTapGesture(addView: orderReceiveSpaceHeaderView,
                      gestureName: OrderCellType.orderReceiveSpace.rawValue)
        addTapGesture(addView: methodsOfPaymentHeaderView,
                      gestureName: OrderCellType.methodsOfPayMent.rawValue)
        addTapGesture(addView: orderDeliveryActionHeaderView,
                      gestureName: OrderCellType.deliveryAction.rawValue)
    }

    func addTapGesture(addView: UIView, gestureName: Int) {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tappedInfoHeaderView))
        tapGesture.name = "\(gestureName)"
        addView.isUserInteractionEnabled = true
        addView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - UITableViewDataSource

extension ProductOrderVC: UITableViewDataSource {
    enum OrderCellType: Int, CaseIterable {
        case productInfomation
        case ordererInfomation
        case orderDelivery
        case orderReceiveSpace
        case orderPaymentPrice
        case methodsOfPayMent
        case deliveryAction
        case payForProduct
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch OrderCellType(rawValue: section)! {
        case .productInfomation: return isShowProductList ? orderData.count : 0
        case .ordererInfomation: return isShowOrdererList ? 1 : 0
        case .orderDelivery: return 1
        case .orderReceiveSpace: return 1
        case .orderPaymentPrice: return paymentTypes.count
        case .methodsOfPayMent: return isShowPaymentList ? 1 : 0
        case .deliveryAction: return isShowActionList ? UnDeliveryActionType.allCases.count : 0
        case .payForProduct: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch OrderCellType(rawValue: indexPath.section)! {
        case .productInfomation:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductInfomationCell.identifier,
                for: indexPath) as! ProductInfomationCell
            cell.data = orderData[indexPath.row]
            return cell
        case .ordererInfomation:
            let cell = OrdererInfomationCell()
            return cell
        case .orderDelivery:
            let cell = OrderDeliveryCell()
            let array = userAddressList.filter { return $0.status == "T" }
            cell.deliverySpace = deliverySpace != nil ? deliverySpace :
                array.count > 0 ? array[0] : nil
            return cell
        case .orderReceiveSpace:
            let cell = OrderReceiveSpaceCell()
            let array = userAddressList.filter { return $0.status == "T" }
            cell.deliverySpace = deliverySpace != nil ? deliverySpace :
                array.count > 0 ? array[0] : nil
            return cell
        case .orderPaymentPrice:
            switch paymentTypes[indexPath.row] {
            case .orderPricePayment:
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: OrderMainPaymentPriceCell.identifier,
                        for: indexPath) as! OrderMainPaymentPriceCell
                    cell.configure(titleText: paymentTypes[indexPath.row].description,
                                   priceText: priceFormatter.string(from: orderMainPaymentPrice as NSNumber) ?? "")
                    return cell
            case .deliveryPricePayment:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: OrderMainPaymentPriceCell.identifier,
                    for: indexPath) as! OrderMainPaymentPriceCell
                cell.configure(titleText: paymentTypes[indexPath.row].description,
                               priceText: priceFormatter.string(from: (orderDeliveryPaymentPrice as NSNumber)) ?? "0")
                return cell
            case .productPricePayMent:
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: OrderSubPaymentPriceCell.identifier,
                        for: indexPath) as! OrderSubPaymentPriceCell
                    cell.configure(titleText: paymentTypes[indexPath.row].description,
                                   priceText: priceFormatter.string(from: orderProductPaymentPrice as NSNumber) ?? "",
                                   type: paymentTypes[indexPath.row])
                    return cell
            case .discountPricePayment:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: OrderSubPaymentPriceCell.identifier,
                    for: indexPath) as! OrderSubPaymentPriceCell
                cell.configure(titleText: paymentTypes[indexPath.row].description,
                               priceText: priceFormatter.string(from: orderDiscountPaymentPrice as NSNumber) ?? "",
                               type: paymentTypes[indexPath.row])
                return cell
            case .amountPricePayment:
                let cell = OrderAmountPaymentPriceCell()
                cell.configure(titleText: paymentTypes[indexPath.row].description,
                               priceText: priceFormatter.string(from: orderAmountPaymentPrice as NSNumber) ?? "")
                return cell
            }
        case .methodsOfPayMent:
            let cell = MethodsOfPayMentCell()
            cell.selectedPaymentType = selectedPaymentType(type:)
            cell.selectedType = selectPaymentType
            return cell
        case .deliveryAction:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DeliveryActionCell.identifier,
                for: indexPath) as! DeliveryActionCell

            let actionType = UnDeliveryActionType(rawValue: indexPath.row) ?? .paymentRefund
            cell.configure(isChecked: undeliveryType == actionType,
                           titleText: actionType.description)
            return cell
        case .payForProduct:
            let cell = PayForProductCell()
            cell.paymentButton.addTarget(self,
                                         action: #selector(tappedPayForButton(_:)),
                                         for: .touchUpInside)
            return cell
        }

        // AgreementCheckMarkView => V 체크모양버튼
        // KurlyChecker => 동그라미버튼
    }
}

// MARK: - UITableViewDelegate

extension ProductOrderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch OrderCellType(rawValue: section)! {
        case .productInfomation:
            orderProductInfomationHeaderView.orderData = self.orderData
            return orderProductInfomationHeaderView
        case .ordererInfomation:
            return ordererInfomationHeaderView
        case .orderDelivery:
            return orderDeliveryHeaderView
        case .orderReceiveSpace:
            return orderReceiveSpaceHeaderView
        case .orderPaymentPrice:
            return orderPaymentPriceHeaderView
        case .methodsOfPayMent:
            return methodsOfPaymentHeaderView
        case .deliveryAction:
            return orderDeliveryActionHeaderView
        default: return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch OrderCellType(rawValue: section)! {
        case .payForProduct: return 0
        default: return 60
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = ColorManager.General.backGray.rawValue
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch OrderCellType(rawValue: indexPath.section)! {
        case .deliveryAction: undeliveryType = UnDeliveryActionType(rawValue: indexPath.row)!
        default: break
        }
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
    }
}

// MARK: - UserDeliverySettingVCDeleagte

extension ProductOrderVC: UserDeliverySettingVCDeleagte {
    func tappedDeliveryConfirm(addressData: AddressModel) {
        deliverySpace = addressData
        orderTableView.reloadData()
    }
}

// MARK: - ReceiveSpaceSettingVCDelegate

extension ProductOrderVC: ReceiveSpaceSettingVCDelegate {
    func receiveSpaceData(receiving_place: ReceiveSpaceType,
                          entrance_password: String?,
                          free_pass: Bool,
                          etc: String?,
                          message: Bool?,
                          extra_message: String?) {
        deliverySpaceData = DeliverySpaceModel(address: "",
                                               detail_address: "",
                                               status: "",
                                               receiving_place: receiving_place.description,
                                               entrance_password: entrance_password,
                                               free_pass: free_pass,
                                               etc: etc,
                                               message: message,
                                               extra_message: extra_message)
        let indexPath = IndexPath(row: 0, section: OrderCellType.orderReceiveSpace.rawValue)
        if let cell = orderTableView.cellForRow(at: indexPath) as? OrderReceiveSpaceCell {
            switch receiving_place {
            case .doorFront:
                let root = entrance_password != nil ? "공동현관 비밀번호" :
                    free_pass != false ? "자유 출입 가능" : "기타"
                let text = "출입방법: \(root)"
                cell.configure(titleText: receiving_place.description,
                               accessUsageText: text)
            default:
                cell.configure(titleText: receiving_place.description)
            }
        }
    }
}
