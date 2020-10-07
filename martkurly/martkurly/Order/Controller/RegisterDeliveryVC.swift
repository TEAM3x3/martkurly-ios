//
//  RegisterDeliveryVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import WebKit

class RegisterDeliveryVC: UIViewController {

    // MARK: - Properties

    private let registerTableView = UITableView()

    private var deliverySpaceData: DeliverySpaceModel?

    // 카카오 주소 찾기 서비스

    private var deliveryStatusType: DeliveryStatusType = .basicArea
    private var inputAddress: Bool = false {
        didSet { registerTableView.reloadData() }
    }

    private var isWebViewHidden = true {
        didSet {
            webView?.isHidden = isWebViewHidden
            closeButton.isHidden = isWebViewHidden
        }
    }

    private var webView: WKWebView?
    private let indicator = UIActivityIndicatorView(style: .medium)

    private var zipCode = ""
    private var findAddress = ""

    private let closeButton = UIButton(type: .system).then {
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = ColorManager.General.backGray.rawValue.cgColor
        $0.layer.borderWidth = 1
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .dismiss,
                                    titleText: "배송지 입력")
    }

    // MARK: - Selectors

    @objc
    func tappedCloseButton(_ sender: UIButton) {
        isWebViewHidden = true
    }

    // MARK: - Actions

    func tappedRegisterButton(cell: RegisterButtonCell) {
        guard let indexPath = registerTableView.indexPath(for: cell),
              let type = RegisterDeliveryType(rawValue: indexPath.section) else { return }
        switch type {
        case .basicAddress:
            isWebViewHidden = false

            guard
                let url = URL(string: "https://kasroid.github.io/Kakao-Postcode/"),
                let webView = webView
            else { return }

            let request = URLRequest(url: url)
            webView.load(request)
            indicator.startAnimating()
        case .receivePlace:
            let controller = ReceiveSpaceSettingVC()
            controller.delegate = self
            let naviVC = UINavigationController(rootViewController: controller)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true)
        default: break
        }
    }

    func tappedSaveButton() {
        print(#function)
        guard var deliverySpaceData = deliverySpaceData else { return }

        let basicAddress = "\(findAddress) [\(zipCode)]"
//        var name: String?
//        var phone: String?
        var detailAddress: String?
        var isDefaultAddress: Bool = false

//        let nameIndexPath = IndexPath(row: 0, section: RegisterDeliveryType.receiverName.rawValue)
//        if let cell = registerTableView.cellForRow(at: nameIndexPath) as? RegisterInputCell {
//            name = cell.inputTextData
//        }
//
//        let phoneIndexPath = IndexPath(row: 0, section: RegisterDeliveryType.receiverPhone.rawValue)
//        if let cell = registerTableView.cellForRow(at: phoneIndexPath) as? RegisterInputCell {
//            phone = cell.inputTextData
//        }

        let detailIndexPath = IndexPath(row: 0, section: RegisterDeliveryType.detailAddress.rawValue)
        if let cell = registerTableView.cellForRow(at: detailIndexPath) as? RegisterInputCell {
            detailAddress = cell.inputTextData
        }

        let DefaultAddressIndexPath = IndexPath(row: 0, section: RegisterDeliveryType.defaultPlaceSet.rawValue)
        if let cell = registerTableView.cellForRow(at: DefaultAddressIndexPath) as? CheckDeliveryStatusCell {
            isDefaultAddress = cell.isActive
        }

        deliverySpaceData.address = basicAddress
        deliverySpaceData.detail_address = detailAddress ?? ""
        deliverySpaceData.status = isDefaultAddress ? "T" : "F"

        self.showIndicate()
        AddressService.shared.registerAddress(delivery: deliverySpaceData) { status in
            self.stopIndicate()

            if status {
                print("DEBUG: ADDRESS 등록 성공")
            } else {
                print("DEBUG: ADDRESS 등록 실패")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Helpers

    func configureUI() {
        configureAttributes()
        configureLayout()
    }

    func configureLayout() {
        view.backgroundColor = ColorManager.General.backGray.rawValue

        let lineView = UIView()
        lineView.backgroundColor = ColorManager.General.backGray.rawValue

        [lineView, registerTableView].forEach {
            self.view.addSubview($0)
        }

        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        registerTableView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }

        guard let webView = webView else { return }
        isWebViewHidden = true

        [webView, indicator, closeButton].forEach {
            self.view.addSubview($0)
        }

        webView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view)
        }

        indicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(orderVCSideInsetValue)
            $0.height.equalTo(44)
        }
    }

    func configureAttributes() {
        registerTableView.backgroundColor = .white
        registerTableView.separatorStyle = .none
        registerTableView.allowsSelection = false
        registerTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        registerTableView.keyboardDismissMode = .interactive

        registerTableView.dataSource = self
        registerTableView.delegate = self

        registerTableView.register(CheckDeliveryStatusCell.self,
                                   forCellReuseIdentifier: CheckDeliveryStatusCell.identifier)
        registerTableView.register(RegisterInputCell.self,
                                   forCellReuseIdentifier: RegisterInputCell.identifier)
        registerTableView.register(RegisterButtonCell.self,
                                   forCellReuseIdentifier: RegisterButtonCell.identifier)

        // Kakao WebView 구성, message handler를 추가하는 메소드

        closeButton.addTarget(self,
                              action: #selector(tappedCloseButton(_:)),
                              for: .touchUpInside)

        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        self.webView = WKWebView(frame: .zero, configuration: config)
        self.webView?.navigationDelegate = self
    }
}

// MARK: - UITableViewDataSource

extension RegisterDeliveryVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return RegisterDeliveryType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch RegisterDeliveryType(rawValue: section)! {
        case .sameOrderer: fallthrough
        case .receiverName: fallthrough
        case .receiverPhone: fallthrough
        case .basicAddress: fallthrough
        case .saveButton: return 1
        case .detailAddress: fallthrough
        case .receivePlace: fallthrough
        case .defaultPlaceSet: return inputAddress ? 1 : 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = RegisterDeliveryType(rawValue: indexPath.section)!
        switch type {
        case .sameOrderer, .defaultPlaceSet:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CheckDeliveryStatusCell.identifier,
                for: indexPath) as! CheckDeliveryStatusCell
            cell.configure(titleText: type.titleText)
            cell.isActive = type == .sameOrderer ? true : false
            return cell
        case .receiverName, .receiverPhone, .detailAddress:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RegisterInputCell.identifier,
                for: indexPath) as! RegisterInputCell
            cell.configure(titleText: type.titleText,
                           placeHolderText: type.placeHolderText,
                           isShowCount: type.isShowCounting,
                           keyboardType: type.keyboardType)
            cell.inputTextData = type == .receiverName ?
                UserService.shared.currentUser?.username : type == .receiverPhone ?
                UserService.shared.currentUser?.phone : nil
            return cell
        case .receivePlace:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RegisterButtonCell.identifier,
                for: indexPath) as! RegisterButtonCell
            cell.configure(titleText: type.titleText,
                           placeHolderText: type.placeHolderText,
                           imageName: type.imageName)
            cell.tappedEvent = tappedRegisterButton(cell:)
            return cell
        case .basicAddress:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RegisterButtonCell.identifier,
                for: indexPath) as! RegisterButtonCell
            if inputAddress {
                cell.configureDelivery(addressText: "\(findAddress) [\(zipCode)]",
                                       deliveryType: deliveryStatusType)
            } else {
                cell.configure(titleText: type.titleText,
                               placeHolderText: type.placeHolderText,
                               imageName: type.imageName)
            }
            cell.tappedEvent = tappedRegisterButton(cell:)
            return cell
        case .saveButton:
            let cell = DeliverySaveButtonCell()
            cell.tappedSaveButton = tappedSaveButton
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension RegisterDeliveryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - WKScriptMessageHandler

extension RegisterDeliveryVC: WKScriptMessageHandler {
    //데이터를 받았을때 Invoke 하는 메서드
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let postCodeData = message.body as? [String: Any] {
            zipCode = postCodeData["zonecode"] as? String ?? ""
            findAddress = postCodeData["roadAddress"] as? String ?? ""
        }

        var alert: UIAlertController!
        if findAddress.contains("경기") || findAddress.contains("서울") {
            alert = UIAlertController(title: "샛별배송 지역입니다.", message: nil, preferredStyle: .alert)
            deliveryStatusType = .fastArea
        } else {
            alert = UIAlertController(title: "택배배송 지역입니다.", message: nil, preferredStyle: .alert)
            deliveryStatusType = .basicArea
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.isWebViewHidden = true
            self.inputAddress = true
        }))
        self.present(alert, animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension RegisterDeliveryVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

// MARK: - ReceiveSpaceSettingVCDelegate

extension RegisterDeliveryVC: ReceiveSpaceSettingVCDelegate {
    func receiveSpaceData(receiving_place: ReceiveSpaceType, entrance_password: String?, free_pass: Bool, etc: String?, message: Bool?, extra_message: String?) {
        deliverySpaceData = DeliverySpaceModel(address: "",
                                               detail_address: "",
                                               status: "",
                                               receiving_place: receiving_place.description,
                                               entrance_password: entrance_password,
                                               free_pass: free_pass,
                                               etc: etc,
                                               message: message,
                                               extra_message: extra_message)

        let indexPath = IndexPath(row: 0, section: RegisterDeliveryType.receivePlace.rawValue)
        if let cell = registerTableView.cellForRow(at: indexPath) as? RegisterButtonCell {
            switch receiving_place {
            case .doorFront:
                let root = entrance_password != nil ? "공동현관 비밀번호" :
                    free_pass != false ? "자유 출입 가능" : "기타"
                let text = "\(receiving_place.description) (출입방법: \(root))"
                cell.configureReceiveSpace(titleText: text)
            default:
                cell.configureReceiveSpace(titleText: receiving_place.description)
            }
        }
    }
}
