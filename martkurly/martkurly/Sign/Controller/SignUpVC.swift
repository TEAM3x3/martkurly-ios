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
    private var textFields = [UserTextFieldView]() // 아이디, 비밀번호, 비밀번호 확인, 이름, 이메일 순서로 들어있음
    private let idCheckButton = KurlyButton(title: StringManager.SignUp.checkDuplicate.rawValue, style: .white)
    private let phoneNumberCheckButton = KurlyButton(title: StringManager.SignUp.checkPhoneNumber.rawValue, style: .white)
    private let addressView = SignUpAddressView()
    private let birthdayTitleView = SignUpTextFieldTitleView(title: StringManager.SignUp.birthday.rawValue, mendatory: false)
    private let birthdayTextFields = SingUpBirthdayView() // YYYY, MM, DD 3개의 TextFields 로 구성되어 있다.
    private let genderChoice = SignUpGenderView()
    private lazy var genderTableView = genderChoice.tableView // 성별 선택
    private var genderSelected: Gender = .unknwon // 유저가 선택한 성별
    private let additionalInfoView = AdditionalInfoView()
    private lazy var additionalInfoTableView = additionalInfoView.tableView // 추천인 및 참여 이벤트명 선택
    private let contentView2 = UIView().then {
        $0.backgroundColor = .white
    }
    private let data = StringManager().agreement
    private let agreementTitleView = SignUpTextFieldTitleView(title: StringManager.SignUp.agreement.rawValue, mendatory: true)
    private let agreementView = AgreementView()
    private lazy var agreementTableView = agreementView.tableView
    private let signUpButton = KurlyButton(title: StringManager.SignUp.signUp.rawValue, style: .purple)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
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
            $0.height.equalTo(additionalInfoView.frame.maxY + 12)
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
        genderTableView.delegate = self
        genderTableView.dataSource = self

        additionalInfoTableView.delegate = self
        additionalInfoTableView.dataSource = self

        agreementTableView.delegate = self
        agreementTableView.dataSource = self
    }

    private func setConstraints() {
        guard
            let idTextField = textFields.first,
            let phoneNumberTextField = textFields.last
            else { return }
        idCheckButton.snp.makeConstraints {
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
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(150)
        }
        birthdayTitleView.snp.makeConstraints {
            $0.top.equalTo(addressView.snp.bottom).offset(45)
            $0.leading.trailing.equalTo(view).inset(20)
        }
        birthdayTextFields.snp.makeConstraints {
            $0.top.equalTo(birthdayTitleView).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(48)
        }
        genderChoice.snp.makeConstraints {
            $0.top.equalTo(birthdayTextFields.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(170)
        }
        additionalInfoView.snp.makeConstraints {
            $0.top.equalTo(genderChoice.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(150)
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
        [idCheckButton, phoneNumberCheckButton, addressView, birthdayTitleView, birthdayTextFields, genderChoice, additionalInfoView].forEach {
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
            $0.top.equalTo(agreementTitleView).offset(20)
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
        for info in StringManager().signUpTextFieldsInfo {
            guard let title = info.keys.first,
                let placeHolder = info[title]
                else { return }
            let titleLabel = SignUpTextFieldTitleView(title: title, mendatory: true)
            let textField = UserTextFieldView(placeholder: placeHolder, fontSize: 14)

            [titleLabel, textField].forEach {
                contentView.addSubview($0)
            }

            if textFields.isEmpty == true {
                titleLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(12)
                    $0.leading.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalToSuperview().inset(20)
                    $0.trailing.equalTo(idCheckButton.snp.leading).offset(-10)
                    $0.height.equalTo(48)
                }
            } else if textFields.count == 5 {
                // 휴대폰 입력 텍스트필드
                guard
                    let firstObject = textFields.first,
                    let lastObject = textFields.last else { return }
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(lastObject.snp.bottom).offset(8)
                    $0.leading.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalTo(phoneNumberCheckButton.snp.leading).offset(-10)
                    $0.height.equalTo(48)
                }
            } else {
                guard
                    let firstObject = textFields.first,
                    let lastObject = textFields.last else { return }
                titleLabel.snp.makeConstraints {
                    $0.top.equalTo(lastObject.snp.bottom).offset(8)
                    $0.leading.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(30)
                }
                textField.snp.makeConstraints {
                    $0.top.equalTo(titleLabel.snp.bottom).offset(4)
                    $0.leading.equalTo(firstObject)
                    $0.trailing.equalTo(view).inset(20)
                    $0.height.equalTo(48)
                }
            }
            textFields.append(textField)
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
            cell.checkmark.isActive = true
        case 1:
            cell.checkmark.isActive = true
        case 2:
            cell.checkmark.isActive = true
        case 3:
            cell.checkmark.isActive = true
        default:
            cell.checkmark.isActive = true
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
            guard let cell = tableView.cellForRow(at: indexPath) as? AgreementTableViewCell else { return }
            cell.checkmark.isActive = false
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case genderTableView:
            return 50
        case additionalInfoTableView:
            return 50
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
                return 180
            case 5:
                return 50
            default:
                fatalError()
            }
        default:
            return 0
        }
    }
}
