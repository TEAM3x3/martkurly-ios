//
//  ProductDetailOrderGuideCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/11.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ProductDetailOrderGuideCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "ProductDetailOrderGuideCell"

    var layoutChangedMethod: (() -> Void)?

    private let topLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let detailOrderView = DetailOrderView()

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    func changedDetailOrderViewHeight(height: CGFloat) {
        detailOrderView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        layoutChangedMethod?()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        [topLine, detailOrderView].forEach {
            self.addSubview($0)
        }

        topLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(12)
        }

        detailOrderView.snp.makeConstraints {
            $0.top.equalTo(topLine.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(840)
        }
    }

    func configureAttributes() {
        detailOrderView.changedTableViewHeight = changedDetailOrderViewHeight(height:)
    }
}
