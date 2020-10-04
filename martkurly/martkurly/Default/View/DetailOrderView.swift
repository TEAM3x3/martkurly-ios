//
//  DetailOrderView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class DetailOrderView: UIView {

    // MARK: - Properties
    private let tableV = UITableView()

    var changedTableViewHeight: ((CGFloat) -> Void)?

    // MARK: - ButtonOpenIdentify
    var moreLookButton = false
    var productErrorButton = false
    var changeMindOrderErrorButton = false
    var notChangeAndReturnViewButton = false

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setNeedsDisplay() {
        tableV.reloadData()
    }

    override func layoutIfNeeded() {
        tableV.reloadData()
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        [tableV].forEach { self.addSubview($0) }
        tableV.dataSource = self
        tableV.delegate = self
        tableV.separatorStyle = .none
        tableV.isScrollEnabled = false
        tableV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableViewDataSource
extension DetailOrderView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        11
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 1
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noCell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let cell = OrderCancelNoticeCell()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = MoreButtonCell()
            if moreLookButton {
                cell.configure(
                    text: "자세히 보기",
                    image: UIImage(systemName: "chevron.up")!,
                    color: ColorManager.General.backGray.rawValue
                )
            } else {
                cell.configure(
                    text: "자세히 보기",
                    image: UIImage(systemName: "chevron.down")!,
                    color: ColorManager.General.backGray.rawValue
                )
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            if moreLookButton == false {
                return noCell
            } else {
                let cell = CancelMoreNoticeView()
                cell.selectionStyle = .none
                return cell
            }
        case 3:
            let cell = ExchangeAndReturnCell()
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = MoreButtonCell()
            if productErrorButton {
                cell.configure(
                    text: "01. 받으신 상품에 문제가 있는 경우",
                    image: UIImage(systemName: "chevron.up")!,
                    color: .systemBackground)
            } else {
                cell.configure(
                    text: "01. 받으신 상품에 문제가 있는 경우",
                    image: UIImage(systemName: "chevron.down")!,
                    color: .systemBackground)
            }
            cell.selectionStyle = .none
            return cell
        case 5:
            if productErrorButton {
                let cell = ProductErrorView()
                cell.selectionStyle = .none
                return cell
            } else {
                return noCell
            }
        case 6:
            let cell = MoreButtonCell()
            if changeMindOrderErrorButton {
                cell.configure(
                    text: "02. 단순 변심, 주문 착오의 경우",
                    image: UIImage(systemName: "chevron.up")!,
                    color: .systemBackground)
            } else {
                cell.configure(
                    text: "02. 단순 변심, 주문 착오의 경우",
                    image: UIImage(systemName: "chevron.down")!,
                    color: .systemBackground)
            }
            cell.selectionStyle = .none
            return cell
        case 7:
            if changeMindOrderErrorButton {
                let cell = ChangeMaindOrderErrorView()
                cell.selectionStyle = .none
                return cell
            } else {
                return noCell
            }
        case 8:
            let cell = MoreButtonCell()
            if notChangeAndReturnViewButton {
                cell.configure(
                    text: "03. 교환∙반품이 불가한 경우",
                    image: UIImage(systemName: "chevron.up")!,
                    color: .systemBackground)
            } else {
                cell.configure(
                    text: "03. 교환∙반품이 불가한 경우",
                    image: UIImage(systemName: "chevron.down")!,
                    color: .systemBackground)
            }
            cell.selectionStyle = .none
            return cell
        case 9:
            if notChangeAndReturnViewButton {
                let cell = NotChangeAndReturnView()
                cell.selectionStyle = .none
                return cell
            } else {
                return noCell
            }
        default:
            return noCell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 350
        case 1:
            return 70
        case 2:
            if moreLookButton { return 350 } else { return 0 }
        case 3:
            return 200
        case 5:
            if productErrorButton { return 400 } else { return 0 }
        case 7:
            if changeMindOrderErrorButton { return 350 } else { return 0 }
        case 9:
            if notChangeAndReturnViewButton { return 300 } else { return 0 }
        default:
            return 50
        }
    }
}

extension DetailOrderView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            moreLookButton.toggle()
        case 4:
            productErrorButton.toggle()
        case 6:
            changeMindOrderErrorButton.toggle()
        case 8:
            notChangeAndReturnViewButton.toggle()
        default:
            break
        }
        tableView.reloadData()

        let maxYValue = tableView.scrollToBottom()
        self.changedTableViewHeight?(maxYValue)
    }
}
extension UITableView {
    func scrollToBottom() -> CGFloat {
        let lastSectionIndex = self.numberOfSections - 1
        if lastSectionIndex < 0 { //if invalid section
            return 0
        }

        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
        if lastRowIndex < 0 { //if invalid row
            return 0
        }

        let pathToLastRow = IndexPath(row: lastRowIndex, section: lastSectionIndex)
        self.scrollToRow(at: pathToLastRow, at: .bottom, animated: false)

        let maxYValue = self.cellForRow(at: pathToLastRow)?.frame.maxY
        return maxYValue ?? 0
    }
}
