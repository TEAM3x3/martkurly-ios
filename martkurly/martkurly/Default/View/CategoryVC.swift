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
    private var categoryList = [Category]()

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
        requestCategoryList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(
            type: .purpleType,
            isShowCart: true,
            leftBarbuttonStyle: .none,
            titleText: "카테고리")
    }

    // MARK: - API
    func requestCategoryList() {
        // 카테고리 목록 가져오기
//        CurlyService.shared.requestCurlyCategoryList { categories in
//            self.categoryList = categories
//            print(self.categoryList)
//        }

        // 해당 카테고리 전체 상품 목록 가져오기
//        CurlyService.shared.requestCategoryProdcuts(category: "채소") { products in
//            print(products)
//        }

        // 해당 타입 상품 목록 가져오기
        CurlyService.shared.requestTypeProdcuts(type: "기본채소") { products in
            print(products)
        }
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

        tableV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Action
    @objc
    func reLoadData() {
        tableV.refreshControl?.endRefreshing()
        tableV.reloadData()
    }
}

extension CategoryVC: UITableViewDataSource {
    enum CategoryType: Int, CaseIterable {
        case oftenBuyProducts
        case productsCategory
        case kurlyCommend
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return CategoryType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch CategoryType(rawValue: section)! {
        case .oftenBuyProducts:
            return 1
        case .productsCategory:
            return 17
        case .kurlyCommend:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CategoryType(rawValue: indexPath.section)! {
        case .oftenBuyProducts:
            let cell = FrequentlyProductButtonCell()
            cell.selectionStyle = .none
            return cell
        case .productsCategory:
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
        case .kurlyCommend:
            let cell = CategoryKurlyRecommendView()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch CategoryType(rawValue: section)! {
        case .kurlyCommend:
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
        switch CategoryType(rawValue: section)! {
        case .oftenBuyProducts:
            return 24
        case .productsCategory:
            return 0
        case .kurlyCommend:
            return 80
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch CategoryType(rawValue: section)! {
        case .oftenBuyProducts:
            return 24
        case .productsCategory:
            return 24
        case .kurlyCommend:
            return 16
        }
    }
}

extension CategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch CategoryType(rawValue: indexPath.section)! {
        case .oftenBuyProducts:
            let controller = frequentlyProductVC()
            navigationController?.pushViewController(controller, animated: true)
        case .productsCategory:
            if selectedCell != indexPath {
                selectedCell = indexPath
            } else {
                selectedCell = [2, 0]
            }

            tableV.reloadData()
        case .kurlyCommend:
            print("a")
        }
    }
}
