//
//  MainEachVProductCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/04.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MainEachVProductCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "MainEachVProductCell"

    var eventData: EventSqaureModel? {
        didSet { configure() }
    }

    private let productImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "콜린스그린 라떼 모음전"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    private let productSubTitleLabel = UILabel().then {
        $0.text = "입안 가득 달콤한 여운"
        $0.textColor = ColorManager.General.mainGray.rawValue
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }

    private lazy var contentsStackView = UIStackView().then {
        $0.addArrangedSubview(productTitleLabel)
        $0.addArrangedSubview(productSubTitleLabel)

        $0.axis = .vertical
        $0.spacing = 6
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear
        configureLayout()
    }

    func configureLayout() {
        [productImageView, contentsStackView].forEach {
            self.addSubview($0)
        }

        productImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(productImageView.snp.height)
        }

        contentsStackView.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(20)
            $0.trailing.centerY.equalToSuperview()
        }
    }

    func configure() {
        guard let eventData = eventData else { return }
        let imageURL = URL(string: eventData.square_image)
        productImageView.kf.setImage(with: imageURL)
        productTitleLabel.text = eventData.title
        productSubTitleLabel.text = "오직 마트컬리에서만 볼 수 있는 :)"
    }
}
