//
//  ReviewRegisterVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class ReviewRegisterVC: UIViewController {

    // MARK: - Properties

    private let sideInsetValue: CGFloat = 12
    private let lineInsetValue: CGFloat = 24

    private let reviewRegisterScrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }

    private let reviewRegisterView = ReviewRegisterView()

    private let imagePicker = ImagePickerController().then {
        $0.settings.selection.max = 8
        $0.settings.selection.unselectOnReachingMax = true
        $0.settings.fetch.assets.supportedMediaTypes = [.image]
        $0.settings.theme.selectionStyle = .numbered
        $0.settings.theme.selectionFillColor = ColorManager.General.mainPurple.rawValue
        $0.settings.theme.selectionStrokeColor = .white
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    // MARK: - Actions

    func tappedRegisterPicture() {
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        option.resizeMode = .none

        self.presentImagePicker(imagePicker, select: { (_) in
//            print("Selected: \(asset)")
        }, deselect: { (_) in
//            print("Deselected: \(asset)")
        }, cancel: { (assets) in
//            print("Canceled with selections: \(assets)")
        }, finish: { (assets) in
//            debugPrint("Finished with selections: \(assets)")
            self.reviewRegisterView.pictureArray.removeAll()
            assets.forEach {
                PHImageManager.default().requestImage(
                    for: $0,
                    targetSize: PHImageManagerMaximumSize,
                    contentMode: .aspectFill,
                    options: option) { (image, _) in
                    guard let image = image else { return }
                    self.reviewRegisterView.pictureArray.append(image)
                }
            }
        }, completion: {

        })
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        view.backgroundColor = ColorManager.General.backGray.rawValue

        self.view.addSubview(reviewRegisterScrollView)
        reviewRegisterScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        reviewRegisterScrollView.addSubview(reviewRegisterView)

        let viewWidth = view.frame.width - (sideInsetValue * 2)
        reviewRegisterView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.width.equalTo(viewWidth)
        }
    }

    func configureAttributes() {
        reviewRegisterView.reviewTitleTextView.delegate = self
        reviewRegisterView.reviewContentsTextView.delegate = self
    }

    func configureNavigationBar() {
        self.setNavigationBarStatus(type: .whiteType,
                                    isShowCart: false,
                                    leftBarbuttonStyle: .dismiss,
                                    titleText: "후기 쓰기")

        let registerButton = UIBarButtonItem(
            title: "등록",
            style: .plain,
            target: nil,
            action: nil)
        registerButton.tintColor = .black
        registerButton.isEnabled = false

        self.navigationItem.rightBarButtonItem = registerButton
    }
}

// MARK: - UITextViewDelegate

extension ReviewRegisterVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case reviewRegisterView.reviewTitleTextView:
            reviewRegisterView.isShowTitlePlaceHolder = textView.text.isEmpty
            reviewRegisterView.titleTextCount = textView.text.count
        case reviewRegisterView.reviewContentsTextView:
            reviewRegisterView.isShowContentsPlaceHolder = textView.text.isEmpty
            reviewRegisterView.contentsTextCount = textView
                .text
                .trimmingCharacters(in: ["\n", " "])
                .count
        default:
            print(#function)
        }

        self.navigationItem.rightBarButtonItem?.isEnabled = reviewRegisterView.isRegisterEnabled
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == reviewRegisterView.reviewTitleTextView {
            if text == "\n" { return false }
        }
        return true
    }
}
