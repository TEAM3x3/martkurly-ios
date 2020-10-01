//
//  ReceiveSpaceSettingVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

protocol ReceiveSpaceSettingVCDelegate: class {
    func receiveSpaceData(receiving_place: ReceiveSpaceType,
                          entrance_password: String?,
                          free_pass: Bool,
                          etc: String?,
                          message: Bool?,
                          extra_message: String?)
}

class ReceiveSpaceSettingVC: UIViewController {

    // MARK: - Properties

    weak var delegate: ReceiveSpaceSettingVCDelegate?

    private let receiveSpaceTableView = UITableView(frame: .zero, style: .grouped)

    private var selectedReceiveSpace: ReceiveSpaceType = .doorFront {
        didSet { receiveSpaceTableView.reloadData() }
    }
    private var selectedDoorFrontUsage: DoorFrontUsage = .commonDoor {
        didSet { receiveSpaceTableView.reloadData() }
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
                                    titleText: "받으실 장소 입력")
    }

    // MARK: - Actions

    func tappedConfirmButton() {
        var entrance_password: String?
        var free_pass: Bool = false
        var etc: String?
        var message: Bool?
        var extra_message: String?

        if selectedReceiveSpace == .doorFront && selectedDoorFrontUsage == .commonDoor {
            let indexPath = IndexPath(row: DoorFrontUsage.commonDoor.rawValue,
                                      section: ReceiveSettingType.attachedExplain.rawValue)
            if let cell = receiveSpaceTableView.cellForRow(at: indexPath) as? DoorFrontUsageCell {
                entrance_password = cell.inputTextData.isEmpty ? nil : cell.inputTextData
            }
        }

        if selectedReceiveSpace == .doorFront && selectedDoorFrontUsage == .enterFree {
            free_pass = true
        }

        if selectedReceiveSpace == .doorFront && selectedDoorFrontUsage == .theOthers {
            let indexPath = IndexPath(row: DoorFrontUsage.theOthers.rawValue,
                                      section: ReceiveSettingType.attachedExplain.rawValue)
            if let cell = receiveSpaceTableView.cellForRow(at: indexPath) as? DoorFrontUsageCell {
                etc = cell.inputTextData.isEmpty ? nil : cell.inputTextData
            }
        }

        let indexPath = IndexPath(row: 0,
                                  section: ReceiveSettingType.completeMessage.rawValue)
        if let cell = receiveSpaceTableView.cellForRow(at: indexPath) as? CompleteMessageCell {
            message = cell.selectedLeft ? true : false
        }

        if selectedReceiveSpace == .securityOffice ||
            selectedReceiveSpace == .parcelBox ||
            selectedReceiveSpace == .anotherPlace {
            switch selectedReceiveSpace {
            case .securityOffice: fallthrough
            case .anotherPlace:
                let indexPath = IndexPath(row: 0,
                                          section: ReceiveSettingType.attachedExplain.rawValue)
                if let cell = receiveSpaceTableView.cellForRow(at: indexPath) as? ReceiveSpaceTextViewCell {
                    extra_message = cell.textData
                }
            case .parcelBox:
                let indexPath = IndexPath(row: 0,
                                          section: ReceiveSettingType.attachedExplain.rawValue)
                if let cell = receiveSpaceTableView.cellForRow(at: indexPath) as? ReceiveSpaceTextFieldCell {
                    extra_message = cell.textData
                }
            default: break
            }
        }

        delegate?.receiveSpaceData(receiving_place: selectedReceiveSpace,
                                   entrance_password: entrance_password,
                                   free_pass: free_pass,
                                   etc: etc,
                                   message: message,
                                   extra_message: extra_message)
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = ColorManager.General.backGray.rawValue

        let lineView = UIView()
        lineView.backgroundColor = ColorManager.General.backGray.rawValue

        [lineView, receiveSpaceTableView].forEach {
            self.view.addSubview($0)
        }

        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        receiveSpaceTableView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureAttributes() {
        receiveSpaceTableView.backgroundColor = ColorManager.General.backGray.rawValue
        receiveSpaceTableView.separatorStyle = .none
        receiveSpaceTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        receiveSpaceTableView.keyboardDismissMode = .interactive

        receiveSpaceTableView.dataSource = self
        receiveSpaceTableView.delegate = self

        receiveSpaceTableView.register(
            ReceiveSettingHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ReceiveSettingHeaderView.identifier)
        receiveSpaceTableView.register(
            ReceiveSpaceCell.self,
            forCellReuseIdentifier: ReceiveSpaceCell.identifier)
        receiveSpaceTableView.register(
            DoorFrontUsageCell.self,
            forCellReuseIdentifier: DoorFrontUsageCell.identifier)
        receiveSpaceTableView.register(
            ReceiveSpaceTextViewCell.self,
            forCellReuseIdentifier: ReceiveSpaceTextViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ReceiveSpaceSettingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ReceiveSettingType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ReceiveSettingType(rawValue: section)! {
        case .receiveSpace: return ReceiveSpaceType.allCases.count
        case .attachedExplain:
            switch selectedReceiveSpace {
            case .doorFront: return DoorFrontUsage.allCases.count
            case .securityOffice: fallthrough
            case .parcelBox: fallthrough
            case .anotherPlace: return 1
            }
        case .completeMessage: fallthrough
        case .confirmButton: return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ReceiveSettingType(rawValue: indexPath.section)! {
        case .receiveSpace:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ReceiveSpaceCell.identifier,
                for: indexPath) as! ReceiveSpaceCell
            let type = ReceiveSpaceType(rawValue: indexPath.row) ?? .doorFront
            cell.configure(
                titleText: type.description,
                isActive: type == selectedReceiveSpace)
            return cell
        case .attachedExplain:
            switch selectedReceiveSpace {
            case .doorFront:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: DoorFrontUsageCell.identifier,
                    for: indexPath) as! DoorFrontUsageCell

                let type = DoorFrontUsage(rawValue: indexPath.row) ?? .commonDoor
                cell.configure(titleText: type.description,
                               isActive: type == selectedDoorFrontUsage,
                               type: selectedDoorFrontUsage,
                               placeHolder: type.placeHolder)
                return cell
            case .securityOffice: fallthrough
            case .anotherPlace:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ReceiveSpaceTextViewCell.identifier,
                    for: indexPath) as! ReceiveSpaceTextViewCell
                cell.configure(placeHolder: selectedReceiveSpace.placeHolder)
                return cell
            case .parcelBox:
                let cell = ReceiveSpaceTextFieldCell()
                return cell
            }
        case .completeMessage:
            let cell = CompleteMessageCell()
            return cell
        case .confirmButton:
            let cell = SpaceConfirmButtonCell()
            cell.tappedConfirmButton = tappedConfirmButton
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ReceiveSpaceSettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
        switch ReceiveSettingType(rawValue: indexPath.section)! {
        case .receiveSpace:
            selectedReceiveSpace = ReceiveSpaceType(rawValue: indexPath.row) ?? .doorFront
        case .attachedExplain:
            switch selectedReceiveSpace {
            case .doorFront:
                selectedDoorFrontUsage = DoorFrontUsage(rawValue: indexPath.row) ?? .commonDoor
            default: break
            }
        default: break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ReceiveSettingHeaderView.identifier) as! ReceiveSettingHeaderView
        headerView.productInfomationLabel.text =
            ReceiveSettingType(rawValue: section)!
            .getHeaderTitleText(receiveSpaceType: selectedReceiveSpace)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch ReceiveSettingType(rawValue: section)! {
        case .confirmButton: return 0
        default: return 60
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = ColorManager.General.backGray.rawValue
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
}
