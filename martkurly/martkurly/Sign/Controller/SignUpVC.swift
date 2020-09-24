//
//  SignUpVC.swift
//  martkurly
//
//  Created by Doyoung Song on 8/20/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

final class SignUpVC: UIViewController {

    // MARK: - Properties
    private let separtor = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .backgroundGray
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    private var textFieldTitleLabels = [SignUpTextFieldTitleView]()
    private var textFieldViews = [UserTextFieldView]() // 아이디, 비밀번호, 비밀번호 확인, 이름, 이메일, 휴대폰 뷰가 순서로 들어있음
    private let checkUsernameButton = KurlyButton(title: StringManager.SignUp.checkDuplicate.rawValue, style: .white)
    private let phoneNumberCheckButton = KurlyButton(title: StringManager.SignUp.checkPhoneNumber.rawValue, style: .white)
    private let addressView = SignUpAddressView()
    var address: String {
        get { addressView.addressLabel.addressLabel.text! }
        set { addressView.addressLabel.addressLabel.text = newValue }
    }
    var isAddressFilled = false {
        willSet {
            addressView.snp.updateConstraints { $0.height.equalTo(150) }
            birthdayTitleView.snp.updateConstraints { $0.top.equalTo(addressView.snp.bottom).offset(60) }
            addressView.quickDeliveryAvailable = true
        }
    }
    private let birthdayTitleView = SignUpTextFieldTitleView(title: StringManager.SignUp.birthday.rawValue, mendatory: false)
    private let birthdayTextFields = SignUpBirthdayView() // YYYY, MM, DD 3개의 TextFields 로 구성되어 있다.
    private let genderChoice = SignUpGenderView()
    private lazy var genderTableView = genderChoice.tableView // 성별 선택
    private var genderSelected: Gender = .unknwon // 유저가 선택한 성별
    private let additionalInfoView = AdditionalInfoView()
    private lazy var additionalInfoTableView = additionalInfoView.tableView // 추천인 및 참여 이벤트명 선택
    private let newAddtionalInfoView = NewAdditionalInfoView()

    private let contentView2 = UIView().then {
        $0.backgroundColor = .white
    }
    private let data = StringManager().agreement
    private let agreementTitleView = SignUpTextFieldTitleView(title: StringManager.SignUp.agreement.rawValue, mendatory: true)
    private let agreementView = AgreementView()
    private lazy var agreementTableView = agreementView.tableView
    private var agreementCells = [AgreementTableViewCell]()
    private var agreementSelectedCells: Set<Int> = [] // 유저가 선택한 이용약관동의에 대한 정보
    private var selectedPromotion: Set<Int> = [] // 유저가 선택한 혜택정보 수신에 대한 정보
    private let signUpButton = KurlyButton(title: StringManager.SignUp.signUp.rawValue, style: .purple)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.hideKeyboardWhenTappedAround()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        setNavigationBarStatus(type: .whiteType,
                               isShowCart: false,
                               leftBarbuttonStyle: .pop,
                               titleText: StringManager.Sign.signUp.rawValue)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.snp.updateConstraints {
            $0.height.equalTo(newAddtionalInfoView.frame.maxY)
        }

        contentView2.snp.updateConstraints {
            $0.height.equalTo(signUpButton.frame.maxY + 20)
        }
    }

    // MARK: - UI
    private func configureUI() {
        setScrollView()
        generateTextFields()
        setAttributes()
        setConstraints()
    }

    private func setAttributes() {
        textFieldViews[1].textField.isSecureTextEntry = true
        textFieldViews[2].textField.isSecureTextEntry = true
        textFieldViews[4].textField.keyboardType = .emailAddress
        textFieldViews[5].textField.keyboardType = .numberPad

        genderTableView.delegate = self
        genderTableView.dataSource = self

        additionalInfoTableView.delegate = self
        additionalInfoTableView.dataSource = self

        agreementTableView.delegate = self
        agreementTableView.dataSource = self

        checkUsernameButton.addTarget(self, action: #selector(handleCheckUsernameButton), for: .touchUpInside)

        let addressTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleaddressTapGesture(_:)))
        addressView.addGestureRecognizer(addressTapGesture)
        addressView.isUserInteractionEnabled = true

        addAdditionalViewTapGesture()
    }

    private func setConstraints() {
        guard
            let idTextField = textFieldViews.first,
            let phoneNumberTextField = textFieldViews.last
        else { return }
        checkUsernameButton.snp.makeConstraints {
            $0.trailing.equalTo(view).inset(20)
            $0.centerY.equalTo(idTextField)
            $0.height.equalTo(48)
            $0.width.equalTo(92)
        }
        phoneNumberCheckButton.snp.makeConstraints {
            $0.trailing.equalTo(view).inset(20)
            $0.centerY.equalTo(phoneNumberTextField)
            $0.height.equalTo(48)
            $0.width.equalTo(120)
        }
        addressView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(94)
        }
        birthdayTitleView.snp.makeConstraints {
            $0.top.equalTo(addressView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        birthdayTextFields.snp.makeConstraints {
            $0.top.equalTo(birthdayTitleView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        genderChoice.snp.makeConstraints {
            $0.top.equalTo(birthdayTextFields.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(170)
        }
        newAddtionalInfoView.snp.makeConstraints {
            $0.top.equalTo(genderChoice.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(160)
        }
    }

    private func setScrollView() {
        [separtor, scrollView].forEach {
            view.addSubview($0)
        }
        separtor.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separtor.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(view.frame.width)
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.height * 1.5)
            $0.width.equalTo(view)
        }
        [checkUsernameButton, phoneNumberCheckButton, addressView, birthdayTitleView, birthdayTextFields, genderChoice, newAddtionalInfoView].forEach {
            contentView.addSubview($0)
        }
        scrollView.addSubview(contentView2)
        contentView2.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(500)
            $0.width.equalToSuperview()
        }
        [agreementTitleView, agreementView, signUpButton].forEach {
            contentView2.addSubview($0)
        }
        agreementTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        agreementView.snp.makeConstraints {
            $0.top.equalTo(agreementTitleView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(500)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(agreementView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }

    private func generateTextFields() {
        var tag = 0
        for info in StringManager().signUpTextFieldsInfo {
            guard let title = info["title"] as? String,
                  let placeHolder = info["placeholder"] as? String
            else { return }
            let titleLabel = SignUpTextFieldTitleView(title: title, mendatory: true)
            let subtitles = info["subtitles"] as? [String] ?? nil
            let textField = UserTextFieldView(placeholder: placeHolder, fontSize: 14, subtitles: subtitles, viewSizeHandler: viewSizeHandler(tag: textFieldViews.count))
            textField.tag = tag

            [titleLabel, textField].forEach {
                contentView.addSubview($0)
            }

            if textFieldViews.isEmpty == true { // 첫번째 텍스트필드 값이면...
                titleLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(16)
                    $0.leading.trailing.equalTo(view).inset(20)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                    $0.leading.equalToSuperview().inset(20)
                    $0.trailing.equalTo(checkUsernameButton.snp.leading).offset(-10)
                    $0.height.equalTo(48)
                }
            } else if textFieldViews.count == 5 { // 휴대폰 입력 텍스트필드
                guard
                    let firstObject = textFieldViews.first,
                    let lastObject = textFieldViews.last else { return }
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(lastObject.snp.bottom).offset(16)
                    $0.leading.trailing.equalTo(view).inset(20)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalTo(phoneNumberCheckButton.snp.leading).offset(-10)
                    $0.height.equalTo(48)
                }
            } else {
                guard
                    let firstObject = textFieldViews.first,
                    let lastObject = textFieldViews.last else { return }
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(lastObject.snp.bottom).offset(16)
                    $0.leading.trailing.equalTo(view).inset(20)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(8)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(48)
                }
            }
            textFieldTitleLabels.append(titleLabel)
            textFieldViews.append(textField)
            tag += 1
        }
    }

    // MARK: - Selectors
    @objc
    private func handleCheckUsernameButton() {
        var isValidUsername = true
        guard let username = textFieldViews[0].textField.text?.lowercased() else { return }
        guard username.count <= 20, username.count >= 6, username != "" else {
            generateAlert(title: "6자 이상의 영문 혹은 영문과 숫자를 조합으로 입력해 주세요")
            return
        }
        for character in username {
            guard let asciiValue = character.asciiValue else {
                generateAlert(title: "6자 이상의 영문 혹은 영문과 숫자를 조합으로 입력해 주세요")
                return
            }
            switch asciiValue {
            case UInt8(48)...UInt8(57):
                fallthrough
            case UInt8(97)...UInt8(122):
                continue
            default:
                isValidUsername = false
            }
        }
        guard isValidUsername == true else {
            generateAlert(title: "6자 이상의 영문 혹은 영문과 숫자를 조합으로 입력해 주세요")
            return
        }
        CurlyService.shared.checkUsername(username: username, completionHandler: { title in
            self.generateAlert(title: title)
        })
    }

    @objc
    private func handleaddressTapGesture(_ sender: UITapGestureRecognizer) {
        let nextVC = KakaoAddressVC()
        let naviVC = UINavigationController(rootViewController: nextVC)
        naviVC.modalPresentationStyle = .overFullScreen
        naviVC.modalTransitionStyle = .crossDissolve
        present(naviVC, animated: true)
    }

    @objc
    private func handleSMSTapGesture(_ sender: UITapGestureRecognizer) {
        agreementCells[5].smsCheckmark.isActive
            ? { agreementCells[5].smsCheckmark.isActive = false
                selectedPromotion.remove(0) }()
            : { agreementCells[5].smsCheckmark.isActive = true
                selectedPromotion.insert(0) }()
        checkPromotionStatus()
    }
    @objc
    private func handleEmailTapGesture(_ sender: UITapGestureRecognizer) {
        agreementCells[5].emailCheckmark.isActive
            ? { agreementCells[5].emailCheckmark.isActive = false
                selectedPromotion.remove(1) }()
            : { agreementCells[5].emailCheckmark.isActive = true
                selectedPromotion.insert(1) }()
        checkPromotionStatus()
    }

    @objc
    private func handleRecommendationViewTapGesutre(_ sender: UITapGestureRecognizer) {
        guard newAddtionalInfoView.isRecommendationViewActive == false else { return }
        newAddtionalInfoView.isRecommendationViewActive.toggle()
        newAddtionalInfoView.isEventNameViewActive = false
        self.newAddtionalInfoView.snp.updateConstraints {
            $0.height.equalTo(185)
        }
        DispatchQueue.main.async {
            let height = self.newAddtionalInfoView.frame.maxY < 1120 ? 1128 : self.newAddtionalInfoView.frame.maxY
            self.contentView.snp.updateConstraints {
                $0.height.equalTo(height + 10)
            }
        }
    }

    @objc
    private func handleEventViewTapGesutre(_ sender: UITapGestureRecognizer) {
        guard newAddtionalInfoView.isEventNameViewActive == false else { return }
        newAddtionalInfoView.isEventNameViewActive.toggle()
        newAddtionalInfoView.isRecommendationViewActive = false
        newAddtionalInfoView.snp.updateConstraints {
            $0.height.equalTo(185)
        }
        DispatchQueue.main.async {
            self.contentView.snp.updateConstraints {
                $0.height.equalTo(self.newAddtionalInfoView.frame.maxY + 10)
            }
        }
    }

    // MARK: - Helpers
    private func handleGenderTableView(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SignUpGenderTableViewCell else { return }
        switch indexPath.row {
        case 0:
            genderSelected = .male
        case 1:
            genderSelected = .female
        case 2:
            genderSelected = .unknwon
        default:
            genderSelected = .unknwon
        }
        cell.isActive = true
    }

    private func handleAdditionalInfoTableView(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AdditionalInfoTableViewCell else { return }
        switch indexPath.row {
        case 0:
            print(#function, 0)
        case 1:
            print(#function, 1)
        default:
            print(#function)
        }
        cell.isActive = true
    }

    private func handleAgreementTableView(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AgreementTableViewCell else { return }
        switch indexPath.row {
        case 0:
            agreementSelectedCells.contains(0) ? deactivateAllCells() : activateAllCells()
        case 5:
            break
        case 4:
            agreementSelectedCells.contains(indexPath.row) ? deselectsAllPromotion() : selectsAllPromotion()
            fallthrough
        default:
            agreementSelectedCells.contains(indexPath.row) ? deleteCellInfo(indexPath: indexPath) : insertCellInfo(indexPath: indexPath)
            cell.checkmark.isActive.toggle()
            agreementSelectedCells.contains(0) ? deactivateSelectsAll() : activateSelectsAll()
        }
    }

    private func configureCellType(type: String) -> AgreementCellType {
        switch type {
        case "title":
            return .title
        case "page":
            return .page
        case "choice":
            return .choice
        case "normal":
            return .normal
        default:
            fatalError()
        }
    }

    private func addTapGestures(cell: AgreementTableViewCell, indexPath: IndexPath) {
        guard indexPath.row == 5 else { return }
        let smsCheckmarkGesture = UITapGestureRecognizer(target: self, action: #selector(handleSMSTapGesture(_:)))
        let emailCheckmarkGesture = UITapGestureRecognizer(target: self, action: #selector(handleEmailTapGesture(_:)))
        cell.smsCheckmark.addGestureRecognizer(smsCheckmarkGesture)
        cell.emailCheckmark.addGestureRecognizer(emailCheckmarkGesture)
    }

    private func addAdditionalViewTapGesture() {
        let recommendationViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRecommendationViewTapGesutre(_:)))
        newAddtionalInfoView.recommendationView.addGestureRecognizer(recommendationViewTapGesture)
        newAddtionalInfoView.recommendationView.isUserInteractionEnabled = true

        let eventNameViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleEventViewTapGesutre(_:)))
        newAddtionalInfoView.eventNameView.addGestureRecognizer(eventNameViewTapGesture)
        newAddtionalInfoView.eventNameView.isUserInteractionEnabled = true
    }

    private func activateAllCells() {
        var counter = 0
        for cell in agreementCells {
            cell.checkmark.isActive = true
            cell.smsCheckmark.isActive = true
            cell.emailCheckmark.isActive = true
            agreementSelectedCells.insert(counter)
            counter += 1
        }
        guard selectedPromotion.count != 2 else { return }
        selectedPromotion.insert(0)
        selectedPromotion.insert(1)
    }

    private func deactivateAllCells() {
        for cell in agreementCells {
            cell.checkmark.isActive = false
            cell.smsCheckmark.isActive = false
            cell.emailCheckmark.isActive = false
            agreementSelectedCells.removeAll()
            selectedPromotion.removeAll()
        }
    }

    private func activateSelectsAll() {
        if agreementSelectedCells.contains(1),
           agreementSelectedCells.contains(2),
           agreementSelectedCells.contains(3),
           agreementSelectedCells.contains(4),
           agreementSelectedCells.contains(6) {
            activateAllCells()
        }
    }

    private func deactivateSelectsAll() {
        guard let cell = agreementCells.first else { return }
        cell.checkmark.isActive = false
        agreementSelectedCells.remove(0)
    }

    private func insertCellInfo(indexPath: IndexPath) {
        agreementSelectedCells.insert(indexPath.row)
    }

    private func deleteCellInfo(indexPath: IndexPath) {
        agreementSelectedCells.remove(indexPath.row)
    }

    private func selectsAllPromotion() {
        agreementCells[5].smsCheckmark.isActive = true
        agreementCells[5].emailCheckmark.isActive = true
        selectedPromotion.insert(0)
        selectedPromotion.insert(1)
    }

    private func deselectsAllPromotion() {
        agreementCells[5].smsCheckmark.isActive = false
        agreementCells[5].emailCheckmark.isActive = false
        selectedPromotion.removeAll()
    }

    private func checkPromotionStatus() {
        if selectedPromotion.contains(0),
           selectedPromotion.contains(1) {
            agreementCells[4].checkmark.isActive = true
            agreementSelectedCells.insert(4)
            activateSelectsAll()
        } else {
            agreementCells[4].checkmark.isActive = false
            deactivateSelectsAll()
        }
    }

    private func viewSizeHandler(tag: Int) -> () -> Void { // 텍스트필드가 활성화되었을 때 크기 조절
        switch tag {
        case 0:
            return {
                let offset: CGFloat = 50
                self.textFieldTitleLabels[1].snp.updateConstraints {
                    $0.top.equalTo(self.textFieldViews[0].snp.bottom).offset(offset)
                }
                self.contentView.snp.updateConstraints {
                    $0.height.equalTo(self.newAddtionalInfoView.frame.maxY + offset)
                }
            }
        case 1:
            return {
                let offset: CGFloat = 70
                self.textFieldTitleLabels[2].snp.updateConstraints {
                    $0.top.equalTo(self.textFieldViews[1].snp.bottom).offset(offset)
                }
                self.contentView.snp.updateConstraints {
                    $0.height.equalTo(self.newAddtionalInfoView.frame.maxY + offset)
                }
            }
        case 2:
            return {
                let offset: CGFloat = 32
                self.textFieldTitleLabels[3].snp.updateConstraints {
                    $0.top.equalTo(self.textFieldViews[2].snp.bottom).offset(offset)
                }
                self.contentView.snp.updateConstraints {
                    $0.height.equalTo(self.newAddtionalInfoView.frame.maxY + offset)
                }
            }
        default:
            return { return }
        }
    }

    private func generateAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SignUpVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case genderTableView:
            let number = StringManager().signUpGenderList.count
            return number
        case additionalInfoTableView:
            let number = StringManager().additionalInfoList.count
            return number
        case agreementTableView:
            return data.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case genderTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SignUpGenderTableViewCell.identifier, for: indexPath) as? SignUpGenderTableViewCell else { fatalError() }
            let title = StringManager().signUpGenderList[indexPath.row]
            cell.configureCell(title: title)
            return cell
        case additionalInfoTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalInfoTableViewCell.identifier, for: indexPath) as? AdditionalInfoTableViewCell else { fatalError() }
            let title = StringManager().additionalInfoList[indexPath.row]
            cell.configureCell(title: title)
            return cell
        case agreementTableView:
            let cell = AgreementTableViewCell()
            guard
                let title = data[indexPath.row]["title"],
                let subtitle = data[indexPath.row]["subtitle"],
                let info = data[indexPath.row]["info"],
                let type = data[indexPath.row]["type"]
            else { fatalError() }
            let cellType = configureCellType(type: type)
            cell.configureCell(title: title, info: info, subtitle: subtitle, cellType: cellType)
            addTapGestures(cell: cell, indexPath: indexPath)
            agreementCells.append(cell)
            return cell
        default:
            fatalError()
        }
    }
}

// MARK: - UITableViewDelegate
extension SignUpVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case genderTableView:
            handleGenderTableView(tableView: tableView, indexPath: indexPath)
        case additionalInfoTableView:
            handleAdditionalInfoTableView(tableView: tableView, indexPath: indexPath)
        case agreementTableView:
            handleAgreementTableView(tableView: tableView, indexPath: indexPath)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch tableView {
        case genderTableView:
            guard let cell = tableView.cellForRow(at: indexPath) as? SignUpGenderTableViewCell else { return }
            cell.isActive = false
        case additionalInfoTableView:
            guard let cell = tableView.cellForRow(at: indexPath) as? AdditionalInfoTableViewCell else { return }
            cell.isActive = false
        case agreementTableView:
            break
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case genderTableView:
            return 50
        case additionalInfoTableView:
            return 100
        case agreementTableView:
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 50
            case 2:
                return 50
            case 3:
                return 50
            case 4:
                return 50 // 130
            case 5:
                return 130
            case 6:
                return 50
            default:
                fatalError()
            }
        default:
            return 0
        }
    }
}
