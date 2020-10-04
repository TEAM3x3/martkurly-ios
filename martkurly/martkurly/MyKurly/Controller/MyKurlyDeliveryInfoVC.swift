//
//  MyKurlyDeliveryInfoVC.swift
//  martkurly
//
//  Created by Kas Song on 8/28/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MyKurlyDeliveryInfoVC: UIViewController {
    // MARK: - Properties
    private let separator = UIView().then {
        $0.backgroundColor = .separatorGray
    }
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .backgroundGray
    }
    private let contentView = UIView()
    private var imageViews = [UIImageView]() // 생성된 이미지들이 저장
    private lazy var deliveryAddressSearchView = imageViews[3]
    private lazy var deliveryTypeSelectionView = imageViews[4]
    private lazy var deliveryInfoView = imageViews[5]
    private let deliverySelection = UIView()
    private let leftSelection = UIView()
    private let rightSelection = UIView()
    private var isDefault: Bool = true {
        willSet { changeImages(newValue: newValue) }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType, isShowCart: false, leftBarbuttonStyle: .pop, titleText: StringManager.MyKurly.deliveryInfo.rawValue)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.snp.makeConstraints {
            $0.height.equalTo(imageViews.last!.frame.maxY)
        }
    }

    // MARK: - UI
    private func configureUI() {
        setContraints()
        generateFixedImageViews()
        generateInteractionImageViews()
        generateDeliverySelectionView()
        generateDeliveryTypeInterationViews()
        addUserInteractions()
    }

    private func setContraints() {
        [separator, scrollView].forEach {
            view.addSubview($0)
        }
        separator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.leading.trailing.equalTo(scrollView)
            $0.bottom.equalTo(scrollView)
            $0.width.equalTo(view)
        }
    }

    private func generateFixedImageViews() {
        for i in 0...3 {
            let imageView = UIImageView()
            let imageName = "delivery" + String(i)
            let image = UIImage(named: imageName)!
            let ratio = image.size.width / image.size.height
            let height = view.frame.width / ratio
            imageView.image = image
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill

            contentView.addSubview(imageView)
            imageView.snp.makeConstraints {
                switch imageViews.count {
                case 0:
                    imageView.backgroundColor = .yellow
                    $0.top.equalToSuperview()
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(height)
                default:
                    let previousImage = imageViews[i - 1]
                    $0.top.equalTo(previousImage.snp.bottom)
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(height)
                }
            }
            imageViews.append(imageView)
        }
    }

    private func generateInteractionImageViews() {
        for i in 4...5 {
            let imageView = UIImageView()
            let imageName = "delivery" + String(i) + "-1"
            let image = UIImage(named: imageName)!
            let ratio = image.size.width / image.size.height
            let height = view.frame.width / ratio
            let previousView = imageViews.last!
            imageView.image = image
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill

            contentView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.top.equalTo(previousView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(height)
            }
            imageViews.append(imageView)
        }
    }

    private func generateDeliverySelectionView() {
        [deliverySelection].forEach {
            imageViews[3].addSubview($0)
        }
        deliverySelection.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func generateDeliveryTypeInterationViews() {
        [leftSelection, rightSelection].forEach {
            imageViews[4].addSubview($0)
        }
        leftSelection.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        rightSelection.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
    }

    // MARK: - Helpers
    private func addUserInteractions() {
        let deliveryAddressGesture = UITapGestureRecognizer(target: self, action: #selector(handleDeliveryLocationInteraction))
        deliveryAddressSearchView.addGestureRecognizer(deliveryAddressGesture)
        deliveryAddressSearchView.isUserInteractionEnabled = true

        let leftSelectionGesture = UITapGestureRecognizer(target: self, action: #selector(handleLeftSelectionGesture))
        leftSelection.addGestureRecognizer(leftSelectionGesture)
        leftSelection.isUserInteractionEnabled = true

        let rightSelectionGesture = UITapGestureRecognizer(target: self, action: #selector(handleRightSelectionGesture))
        rightSelection.addGestureRecognizer(rightSelectionGesture)
        rightSelection.isUserInteractionEnabled = true
        imageViews[4].isUserInteractionEnabled = true

        view.bringSubviewToFront(leftSelection)
        view.bringSubviewToFront(rightSelection)
    }

    private func changeImages(newValue: Bool) {
        switch newValue {
        case true:
            deliveryTypeSelectionView.image = UIImage(named: "delivery4-1")
            deliveryInfoView.image = UIImage(named: "delivery5-1")
        case false:
            deliveryTypeSelectionView.image = UIImage(named: "delivery4-2")
            deliveryInfoView.image = UIImage(named: "delivery5-2")
        }
    }

    // MARK: - Selectors
    @objc
    private func handleDeliveryLocationInteraction() {
        print(#function)
    }

    @objc
    private func handleLeftSelectionGesture() {
        isDefault = true
    }

    @objc
    private func handleRightSelectionGesture() {
        isDefault = false
    }
}
