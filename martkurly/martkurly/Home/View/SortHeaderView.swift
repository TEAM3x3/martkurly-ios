//
//  SortHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/23.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

protocol SortHeaderViewDelegate: class {
    func tappedSortButton(type: SortType, sortButtonFrame: CGRect, isShow: Bool)
}

class SortHeaderView: UICollectionReusableView {

    // MARK: - Properties

    static let identifier = "SortHeaderView"

    weak var delegate: SortHeaderViewDelegate?
    var sortType: SortType? {
        didSet { configureVisibleButton() }
    }

    private var isShowingList: Bool = false {
        didSet { configureButton() }
    }
    private var whatIsShowListButton: SortType!

    private lazy var fastAreaButton = makeSortStackView(title: "샛별지역상품",
                                                        type: .fastArea)
    private lazy var qualityButton = makeSortStackView(title: "신상품순",
                                                        type: .fastAreaAndCondition)
    private lazy var priceButton = makeSortStackView(title: "혜택순",
                                                        type: .fastAreaAndBenefit)

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    func tappedSortEvent(_ sender: UITapGestureRecognizer) {
        guard let gestureName = sender.name else { return }

        switch SortType(rawValue: gestureName)! {
        case .fastArea:
            whatIsShowListButton = .fastArea
            delegate?.tappedSortButton(type: .fastArea,
                                       sortButtonFrame: fastAreaButton.frame,
                                       isShow: isShowingList)
        case .fastAreaAndCondition:
            whatIsShowListButton = .fastAreaAndCondition
            delegate?.tappedSortButton(type: .fastAreaAndCondition,
                                       sortButtonFrame: qualityButton.frame,
                                       isShow: isShowingList)
        case .fastAreaAndBenefit:
            whatIsShowListButton = .fastAreaAndBenefit
            delegate?.tappedSortButton(type: .fastAreaAndBenefit,
                                       sortButtonFrame: priceButton.frame,
                                       isShow: isShowingList)
        case .notSort:
            whatIsShowListButton = .none
        }

        isShowingList.toggle()
    }

    // MARK: - Helpers

    func configureVisibleButton() {
        guard let sortType = sortType else { return }

        switch sortType {
        case .fastArea:
            fastAreaButton.isHidden = false
        case .fastAreaAndCondition:
            fastAreaButton.isHidden = false
            qualityButton.isHidden = false
        case .fastAreaAndBenefit:
            fastAreaButton.isHidden = false
            priceButton.isHidden = false
        case .notSort:
            break
        }
    }

    func configureButton() {
        var showListButton: UIStackView!

        switch whatIsShowListButton! {
        case .fastArea:
            showListButton = fastAreaButton
        case .fastAreaAndCondition:
            showListButton = qualityButton
        case .fastAreaAndBenefit:
            showListButton = priceButton
        case .notSort:
            showListButton = nil
        }

        showListButton.subviews.forEach {
            if let imageView = $0 as? UIImageView {
                if self.isShowingList {
                    imageView.image = UIImage(systemName: "chevron.down")
                } else {
                    imageView.image = UIImage(systemName: "chevron.up")
                }
            }
        }
    }

    func configureUI() {
        self.backgroundColor = .clear

        self.addSubview(fastAreaButton)
        self.addSubview(qualityButton)
        self.addSubview(priceButton)

        fastAreaButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-16)
        }

        qualityButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(fastAreaButton)
        }

        priceButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(fastAreaButton)
        }
    }

    func makeSortStackView(title: String, type: SortType) -> UIStackView {
        let titleLabel = UILabel().then {
            $0.text = title
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16)
            $0.textAlignment = .center
        }

        let imageView = UIImageView().then {
            $0.image = UIImage(systemName: "chevron.down")
            $0.tintColor = .black
            $0.snp.makeConstraints {
                $0.width.height.equalTo(16)
            }
        }

        let stack = UIStackView(arrangedSubviews: [titleLabel, imageView])
        stack.axis = .horizontal
        stack.spacing = 4

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedSortEvent))
        tapGesture.name = type.rawValue
        stack.addGestureRecognizer(tapGesture)
        stack.isUserInteractionEnabled = true
        stack.isHidden = true

        return stack
    }
}
