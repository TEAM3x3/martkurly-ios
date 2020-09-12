//
//  CategoryVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryVC: UIViewController {

    // MARK: - Properties
    let tableV = UITableView().then {
        $0.backgroundColor = .white
    }

    let refresh = UIRefreshControl()
    var selectedCell: IndexPath?
    var categoryClick = false

    // MARK: - Data
    let inData = StringManager().categoryTitleData

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(
            type: .purpleType,
            isShowCart: true,
            leftBarbuttonStyle: .none,
            titleText: "카테고리")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        [tableV].forEach {
            view.addSubview($0)
        }

        tableV.backgroundColor = ColorManager.General.backGray.rawValue
        refresh.tintColor = ColorManager.General.mainGray.rawValue
        refresh.addTarget(self, action: #selector(reLoadData), for: .valueChanged)
        tableV.refreshControl = refresh

        tableV.dataSource = self
        tableV.delegate = self

        tableV.separatorStyle = .none
        tableV.showsVerticalScrollIndicator = false
        tableV.alwaysBounceVertical = true
        tableV.decelerationRate = .fast
//                tableV.bounces = false

//        tableV.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)

        tableV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

//        tableV.translatesAutoresizingMaskIntoConstraints = false
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: ["tableView": tableV]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: ["tableView": tableV]))
    }

    // MARK: - Action
    @objc
    func reLoadData() {
        tableV.refreshControl?.endRefreshing()
        tableV.reloadData()
    }
}

extension CategoryVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 17
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = FrequentlyProductButtonCell()
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = CustomCell()
            cell.configure(data: StringManager().categoryTitleData[indexPath.row])
            if let selectedCell = selectedCell, selectedCell == indexPath {
                cell.subView.isHidden = false
                cell.mainTitle.title.textColor = ColorManager.General.mainPurple.rawValue
                cell.mainTitle.chevron.tintColor = ColorManager.General.mainPurple.rawValue
                cell.mainTitle.chevron.image = UIImage(systemName: "chevron.up")
            } else {
                cell.subView.isHidden = true
            }
            return cell
        } else {
            let cell = CategoryKurlyRecommendView()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let header = SectionHeaderView()
            return header
        default:
            let header = UIView()
            return header
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        return footer
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 80
        case 1:
            return 0
        default:
            return 24
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 24
        case 1:
            return 24
        default:
            return 16
        }
    }
}

extension CategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0:
            let controller = frequentlyProductVC()
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            if selectedCell != indexPath {
                selectedCell = indexPath
            } else {
                selectedCell = [2, 0]
            }
            tableV.reloadData()
        default:
            print("a")
        }
    }
}
