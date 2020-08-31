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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var imageViews = [UIImageView]() // 생성된 이미지들이 저장

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
        generateInteractionImageView()
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

    private func generateInteractionImageView() {
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
}
