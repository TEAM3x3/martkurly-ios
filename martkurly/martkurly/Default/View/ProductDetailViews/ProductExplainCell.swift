//
//  ProductExplainCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/27.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductExplainCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainCell"

    private let explainTableView = UITableView()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue

        configureLayout()
    }

    func configureLayout() {
        self.addSubview(explainTableView)
        explainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureTableView() {
        explainTableView.backgroundColor = .white
        explainTableView.allowsSelection = false
        explainTableView.separatorStyle = .none

        explainTableView.dataSource = self
        explainTableView.delegate = self

        explainTableView.register(ProductExplainCellInBasicCell.self,
                                  forCellReuseIdentifier: ProductExplainCellInBasicCell.identifier)
        explainTableView.register(ProductExplainInInfoCell.self,
                                  forCellReuseIdentifier: ProductExplainInInfoCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ProductExplainCell: UITableViewDataSource {
    enum ExplainTableViewCase: Int, CaseIterable {
        case productTitleImage
        case productInfo
    }

    enum ExplainTableInfoCase: Int, CaseIterable {
        case unit
        case weight
        case delivery
        case countryOfOrigin
        case packing
        case allergy
        case expiration

        var description: String {
            switch self {
            case .unit: return "판매단위"
            case .weight: return "중량/용량"
            case .delivery: return "배송구분"
            case .countryOfOrigin: return "원산지"
            case .packing: return "포장타입"
            case .allergy: return "알레르기정보"
            case .expiration: return "유통기한"
            }
        }

        var subContent: String? {
            switch self {
            case .packing: return "택배배송은 에코포장이 스티로폼으로 대체됩니다."
            default: return nil
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ExplainTableViewCase.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ExplainTableViewCase(rawValue: section)! {
        case .productInfo:
            return ExplainTableInfoCase.allCases.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ExplainTableViewCase(rawValue: indexPath.section)! {
        case .productTitleImage:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainCellInBasicCell.identifier,
                for: indexPath) as! ProductExplainCellInBasicCell
            return cell
        case .productInfo:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductExplainInInfoCell.identifier,
                for: indexPath) as! ProductExplainInInfoCell
            cell.configure(
                titleText: ExplainTableInfoCase(rawValue: indexPath.row)!.description,
                subContent: ExplainTableInfoCase(rawValue: indexPath.row)?.subContent)
            return cell
        }

    }
}

// MARK: - UITableViewDelegate

extension ProductExplainCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

import UIKit

class ProductExplainInInfoCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductExplainInInfoCell"

    private let sideInsetValue: CGFloat = 20
    private let lineSpacingValue: CGFloat = 8
    private let widthValue: CGFloat = 88

    private let infoTitleLabel = UILabel().then {
        $0.text = "알레르기정보"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = .systemFont(ofSize: 16)
    }

    private let infoContent = UILabel().then {
        $0.text = "Content Text"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let infoSubContent = UILabel().then {
        $0.text = "Sub Content Text"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
    }

    func configureLayout() {
        [infoTitleLabel].forEach {
            self.addSubview($0)
        }

        infoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineSpacingValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.width.equalTo(widthValue)
        }
    }

    func configure(titleText: String, subContent: String? = nil) {
        infoTitleLabel.text = titleText

        guard let subContentText = subContent else {
            viewAddAndSetupLayout(view: infoContent)
            infoSubContent.text = subContent
            return
        }

        infoSubContent.text = subContentText

        let stack = UIStackView(arrangedSubviews: [infoContent, infoSubContent])
        stack.axis = .vertical
        stack.spacing = 4

        viewAddAndSetupLayout(view: stack)
    }

    func viewAddAndSetupLayout(view: UIView) {
        self.addSubview(view)
        view.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel)
            $0.leading.equalTo(infoTitleLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.bottom.equalToSuperview().offset(-lineSpacingValue)
        }
    }
}
