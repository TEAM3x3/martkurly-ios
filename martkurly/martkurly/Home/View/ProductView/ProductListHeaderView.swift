//
//  ProductListHeaderView.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/25.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

protocol ProductListHeaderViewDelegate: class {
    func tappedSortButton(type: SortType, sortButtonFrame: CGRect, isShow: Bool)
}

class ProductListHeaderView: UICollectionReusableView {

    // MARK: - Properties

    static let identifier = "ProductListHeaderView"

    weak var delegate: ProductListHeaderViewDelegate?

    var initSortType: SortHeaderType? {
        didSet { configureVisibleButton() }
    }

    private var isShowingSortList = false
    private var previousListButton: UIStackView!
    private var whatIsShowListButton: UIStackView! {
        didSet { showSortList() }
    }

    private lazy var fastAreaButton =
        makeSortStackView(title: SortType.fastArea.sortList[0],
                          type: .fastArea)
    private lazy var conditionButton =
        makeSortStackView(title: SortType.condition.sortList[0],
                          type: .condition)
    private lazy var benefitButton =
        makeSortStackView(title: SortType.benefit.sortList[0],
                          type: .benefit)
    private lazy var recommendButton =
        makeSortStackView(title: SortType.recommend.sortList[0],
                          type: .recommend)

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    func setSortButtonTitle(titleText: String) {
        listTitleSet(whatIsShowListButton, setText: titleText)
        listUpDownImageSet(whatIsShowListButton, isUp: false)
        previousListButton = nil
    }

    // MARK: - Selectors

    @objc
    func tappedSortEvent(_ sender: UITapGestureRecognizer) {
        guard let gestureName = sender.name,
            let type = SortType(rawValue: gestureName) else { return }

        switch type {
        case .fastArea:
            whatIsShowListButton = fastAreaButton
        case .condition:
            whatIsShowListButton = conditionButton
        case .benefit:
            whatIsShowListButton = benefitButton
        case .recommend:
            whatIsShowListButton = recommendButton
        }
    }

    // MARK: - Helpers

    func listTitleSet(_ stack: UIStackView, setText: String) {
        stack.subviews.forEach {
            if let label = $0 as? UILabel {
                label.text = setText
            }
        }
    }

    func listUpDownImageSet(_ stack: UIStackView, isUp: Bool) {
        // isUp =>  true: 목록이 보여지고 있는 상태
        //          false: 목록이 보여지지 않고 있는 상태
        stack.subviews.forEach {
            if let imageView = $0 as? UIImageView {
                imageView.image = isUp ?
                    UIImage(systemName: "chevron.up") :
                    UIImage(systemName: "chevron.down")
            }
        }
    }

    func showSortList() {
        isShowingSortList.toggle()

        if previousListButton != nil
            && previousListButton != whatIsShowListButton {
            // 이전에 눌렀던 버튼과 새로 누른 버튼이 다를 경우
            listUpDownImageSet(previousListButton, isUp: false)
            previousListButton = nil
            delegate?.tappedSortButton(type: .fastArea,
                                       sortButtonFrame: .zero,
                                       isShow: false)
            return
        } else if previousListButton == whatIsShowListButton {
            // 이전에 눌렀던 버튼과 같을 경우 false
            listUpDownImageSet(whatIsShowListButton, isUp: false)
            previousListButton = nil
            delegate?.tappedSortButton(type: .fastArea,
                                       sortButtonFrame: .zero,
                                       isShow: false)
            return
        }

        if let typeString = whatIsShowListButton.gestureRecognizers?[0].name,
            let type = SortType(rawValue: typeString) {
            listUpDownImageSet(whatIsShowListButton, isUp: true)
            delegate?.tappedSortButton(type: type,
                                       sortButtonFrame: whatIsShowListButton.frame,
                                       isShow: true)
            previousListButton = whatIsShowListButton
        }
    }

    func configureVisibleButton() {
        guard let initSortType = initSortType else { return }
        fastAreaButton.isHidden =
            initSortType != .notSort ? false : true
        conditionButton.isHidden =
            initSortType == .fastAreaAndCondition ? false : true
        benefitButton.isHidden =
            initSortType == .fastAreaAndBenefit ? false : true
        recommendButton.isHidden =
            initSortType == .fastAreaAndRecommend ? false : true
    }

    func configureUI() {
        self.backgroundColor = .clear

        [fastAreaButton, conditionButton, benefitButton, recommendButton].forEach {
            self.addSubview($0)
        }

        fastAreaButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-16)
        }

        [conditionButton, benefitButton, recommendButton].forEach {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-8)
                $0.centerY.equalTo(fastAreaButton)
            }
        }
    }

    func makeSortStackView(title: String, type: SortType) -> UIStackView {
        let titleLabel = UILabel().then {
            $0.text = title
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16)
            $0.textAlignment = .right
            $0.snp.makeConstraints {
                $0.width.equalTo(88)
            }
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

        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedSortEvent))
        tapGesture.name = type.rawValue
        stack.addGestureRecognizer(tapGesture)
        stack.isUserInteractionEnabled = true
        stack.isHidden = false

        return stack
    }
}
